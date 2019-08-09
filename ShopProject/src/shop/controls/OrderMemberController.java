package shop.controls;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlMemberDao;
import shop.dao.MySqlOrderDao;
import shop.dao.MySqlProductDao;
import shop.vo.Member;
import shop.vo.Mileage;
import shop.vo.Order;
import shop.vo.OrderList;
import shop.vo.Product;
@Component("/order/orderMember.do")
public class OrderMemberController implements Controller, DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlProductDao productDao;
	MySqlMemberDao memberDao;
	MySqlOrderDao orderDao;

	public OrderMemberController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public OrderMemberController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public OrderMemberController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	public OrderMemberController setOrderDao(MySqlOrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}
	
	@Override
	public Object[] getDataBinders() {
		return new Object[] {"order", shop.vo.Order.class,"mbId",String.class,"mbPwd",String.class};
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); //모달창 카테고리
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String now = format.format(date);
		HttpServletRequest request = (HttpServletRequest) model.get("request");
		HttpSession session = (HttpSession) model.get("session");
		Order order = (Order) model.get("order");
		if(model.get("mbId")!=null) { //비회원 상품조회페이지 > 로그인
			HashMap<String, Object> param =new HashMap<String, Object>();
			 param.put("mbId", model.get("mbId")); //아이디
			 param.put("mbPwd", model.get("mbPwd")); //비밀번호
			int check=memberDao.mbCheck(param);
				 if(check ==0) { //로그인 실패
					 model.put("pno", request.getParameterValues("pno"));
					 model.put("pQuantity", request.getParameterValues("pQuantity"));
					 model.put("mbCheck", false);
					 return "/order/order_loginOrder.jsp";
				 }else { //로그인 성공
					 System.out.println("로그인 성공........");
				        session.setAttribute("mbId", model.get("mbId"));
				 }
		}
		System.out.println("회원주문.............");
		String mbId = session.getAttribute("mbId").toString();
		Member member = memberDao.mbOrder(mbId); //주문자 정보 가져오기
		if (order.getBuyerName() == null) { // 주문서 작성 페이지
			List<Product> products = new ArrayList<Product>();
			String[] pno =request.getParameterValues("pno"); 
			String[] quantity =request.getParameterValues("pQuantity");
			for(int i=0;i<pno.length;i++) {
				Product product = productDao.pGet(Integer.parseInt(pno[i])); //상품정보 가져오기
				product.setpQuantity(Integer.parseInt(quantity[i])); //수량set
				products.add(product); //list에 담기
			}
			model.put("products", products);
			model.put("member", member); 
			return "order_memberOrder.jsp";
		} else { // 주문정보 insert
			HashMap<String, Object> paramMap =new HashMap<String, Object>();
			paramMap.put("mbId", mbId);
			//param.put("mbId", mbId);
			Mileage mileage =new Mileage();
			int orderNo=orderDao.orderNoMax("member");
			if(orderNo==0) {
				orderNo=1;
			}else {
				orderNo++;
			}
			String orderId ="m"+now+orderNo; //주문번호
			order.setOrderNo(orderNo);
			order.setOrderId(orderId);
			order.setMbId(mbId);
			order.setOrderState("결제완료");
			orderDao.mbOrderAdd(order); //주문정보 저장
			
			paramMap.put("mbMileage", member.getMbMileage()-order.getMileageUse()+order.getMileageAdd());
			memberDao.mileageUpdate(paramMap); // 총적립금-사용적립금+추가적립금
			
			//적립금 정보 저장
			mileage.setMbId(mbId);
			mileage.setOrderId(orderId);
			mileage.setMileage(order.getMileageAdd());
			mileage.setContent("구매에 대한 적립금");
			memberDao.mileageAdd(mileage); //add
			if(order.getMileageUse() !=0) {
				mileage.setMileage((-1)*order.getMileageUse());
				mileage.setContent("상품구매시 사용한 적립금");
				memberDao.mileageAdd(mileage); //사용한 적립금이 있을때 저장
			}
			
	// 재고감소, 상품구매수 증가, 주문 상품리스트 저장, 구매한 상품 cart DB에서 삭제
			String[] pno = request.getParameterValues("pno");
			String [] pQuantity = request.getParameterValues("pQuantity");
			OrderList orderList = new OrderList();
			for(int i=0;i<pno.length;i++) {
				int stock = productDao.pStock(Integer.parseInt(pno[i]));
				stock-=Integer.parseInt(pQuantity[i]);
				paramMap.put("pno", pno[i]);
				paramMap.put("pStock", stock);
				paramMap.put("pQuantity", pQuantity[i]);
				productDao.pStockMinus(paramMap); //재고감소
				productDao.pBuyNumUpdate(paramMap); //상품구매수 증가
				Product p = productDao.pGet(Integer.parseInt(pno[i])); //상품정보 가져오기
				orderList.setPno(Integer.parseInt(pno[i]));
				orderList.setpName(p.getpName());
				orderList.setPrice(p.getPrice());
				orderList.setpImage(p.getpImage());
				orderList.setOrderId(orderId);
				orderList.setpQuantity(Integer.parseInt(pQuantity[i]));
				orderDao.mbOrderListAdd(orderList); //주문 상품리스트 저장
				memberDao.cartDlt(paramMap); //구매한 상품 cart DB에서 삭제
			}
			model.put("products", orderDao.mbOrderListGet(orderId));
			model.put("order",orderDao.mbOrderGet(orderId));
			return "order_memberOrderCmplt.jsp";
		}
	}
}
