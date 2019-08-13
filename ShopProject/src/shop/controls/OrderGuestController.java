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
import shop.dao.MySqlOrderDao;
import shop.dao.MySqlProductDao;
import shop.vo.Order;
import shop.vo.OrderList;
import shop.vo.Product;

@Component("/order/orderGuest.do")
public class OrderGuestController implements Controller, DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlProductDao productDao;
	MySqlOrderDao orderDao;

	public OrderGuestController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public OrderGuestController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public OrderGuestController setOrderDao(MySqlOrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] {"order", shop.vo.Order.class, "guest", String.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String now = format.format(date);
		HttpServletRequest request = (HttpServletRequest) model.get("request");
		HttpSession session = (HttpSession) model.get("session");
		Order order = (Order) model.get("order");
		
		if (order.getBuyerName() == null) {
			if (model.get("guest")!=null) { // 비회원 구매하기 페이지
				System.out.println("guest order...........");
				model.put("pno", request.getParameterValues("pno"));
				model.put("pQuantity", request.getParameterValues("pQuantity"));
				return "order_loginOrder.jsp";
			}else { // 비회원 주문서 작성 페이지
				System.out.println("비회원주문........");
				List<Product> products = new ArrayList<Product>();
				// 수량 setting하기
				String[] pno = request.getParameterValues("pno");
				String[] quantity = request.getParameterValues("pQuantity");
				for (int i = 0; i < pno.length; i++) {
					Product product = productDao.pGet(Integer.parseInt(pno[i])); // 상품정보 가져오기
					product.setpQuantity(Integer.parseInt(quantity[i]));
					products.add(product); // list에 담기
				}
				model.put("products", products);
				return "order_guestOrder.jsp";
			}
		} else { // 비회원 주문정보 insert
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			int orderNo = orderDao.orderNoMax("guest");
			if (orderNo == 0) {
				orderNo = 1;
			} else {
				orderNo++;
			}
			String orderId = "g" + now + orderNo; // 주문번호
			order.setOrderNo(orderNo);
			order.setOrderId(orderId);
			order.setOrderState("결제완료");
			orderDao.gstOrderAdd(order); // 주문정보 저장
			// 재고감소, 상품구매수 증가, 주문 상품리스트 저장, 장바구니에서 구매한 상품삭제
			String[] pno = request.getParameterValues("pno");
			String[] pQuantity = request.getParameterValues("pQuantity");
			OrderList orderList = new OrderList();
			for (int i = 0; i < pno.length; i++) {
				int stock = productDao.pStock(Integer.parseInt(pno[i]));
				stock -= Integer.parseInt(pQuantity[i]);
				paramMap.put("pno", pno[i]);
				paramMap.put("pStock", stock);
				paramMap.put("pQuantity", pQuantity[i]);
				productDao.pStockMinus(paramMap); // 재고감소
				productDao.pBuyNumUpdate(paramMap); // 상품구매수 증가
				Product p = productDao.pGet(Integer.parseInt(pno[i])); // 상품정보 가져오기
				orderList.setPno(Integer.parseInt(pno[i]));
				orderList.setpName(p.getpName());
				orderList.setPrice(p.getPrice());
				orderList.setpImage(p.getpImage());
				orderList.setOrderId(orderId);
				orderList.setpQuantity(Integer.parseInt(pQuantity[i]));
				orderDao.gstOrderListAdd(orderList); // 주문 상품리스트 저장
				session.removeAttribute(pno[i]); // 장바구니에서 구매한 상품삭제
				if(p.getpStock()==0) {
					productDao.pSoldOut(Integer.parseInt(pno[i]));
				}
			}
			paramMap.put("orderId", order.getOrderId());
			paramMap.put("buyerName", order.getBuyerName());
			model.put("products", orderDao.gstOrderListGet(orderId));
			model.put("order", orderDao.gstOrderGet(paramMap));
			return "order_guestOrderCmplt.jsp";
		}
	}

}
