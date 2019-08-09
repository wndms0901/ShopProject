package shop.controls;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.exceptions.PersistenceException;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlMemberDao;
import shop.dao.MySqlProductDao;
import shop.vo.Cart;
import shop.vo.Product;

@Component("/order/cart.do")
public class OrderCartController implements Controller, DataBinding {
	MySqlProductDao productDao;
	MySqlCategoryDao categoryDao;
	MySqlMemberDao memberDao;

	public OrderCartController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public OrderCartController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public OrderCartController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mbId", String.class, "mbPwd", String.class, "guest", String.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리

		HttpServletRequest request = (HttpServletRequest) model.get("request");
		HttpSession session = (HttpSession) model.get("session");
		Enumeration<String> names = session.getAttributeNames();
		
		if(model.get("guest")!=null) {// 비회원 장바구니> 로그인페이지
			model.put("pno", request.getParameterValues("pno"));
			model.put("pQuantity", request.getParameterValues("pQuantity"));
			return "/order/order_loginCart.jsp";
		}else if(model.get("mbId")==null && session.getAttribute("mbId")==null) { /* 로그인 안했을 때 */
			int sessionCount = 0;
			List<Product> products = new ArrayList<Product>();
			while (names.hasMoreElements()) { // 세션에 등록된 pno 가져오기
				String pno = names.nextElement();
				if (pno.equals("mbId") || pno.startsWith("javax")) {
					continue;
				}
				Product product = productDao.pGet(Integer.parseInt(pno)); // 상품정보 가져오기
				// 수량 set
				product.setpQuantity(Integer.parseInt(session.getAttribute(pno).toString()));
				products.add(product); // list에 담기
				sessionCount++;
			}
			if (sessionCount > 0) { // 로그인x , 장바구니에 상품이 있을때
				model.put("products", products);
				return "/order/order_cart.jsp";
			} else {// 로그인x , 장바구니에 상품이 없을때
				return "order_empCart.jsp";
			}
		}else {
			if(model.get("mbId")!=null) { // 비회원 장바구니> 로그인
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("mbId", model.get("mbId")); // 아이디
				param.put("mbPwd", model.get("mbPwd")); // 비밀번호
				model.put("pno", request.getParameterValues("pno"));
				model.put("pQuantity", request.getParameterValues("pQuantity"));
				int check = memberDao.mbCheck(param);
				if (check == 0) { // 로그인 실패
					System.out.println("로그인 실패!!!!!!!!!!!");
					model.put("mbCheck", false);
					return "/order/order_loginCart.jsp";
				} else { // 로그인 성공
					session.setAttribute("mbId", model.get("mbId"));
					// HashMap<String, Object> paramMap = new HashMap<String, Object>();
					String[] pno = request.getParameterValues("pno");
					String[] quantity = request.getParameterValues("pQuantity");
					for (int i = 0; i < pno.length; i++) { //회원 cart에 상품 insert
						try {
							param.put("pno", pno[i]);
							param.put("pQuantity", quantity[i]);
							memberDao.cartmAdd(param); // 아이디,상품수 등록(insert)
							memberDao.cartpAdd(model.get("mbId").toString());// 상품정보 등록(update)
						} catch (PersistenceException e) { // 이미 장바구니에 있는 상품일 경우
							// HashMap<String, Object> param = new HashMap<String, Object>();
							// param.put("mbId", mbId);
							// param.put("pno", Integer.parseInt(pno));
							int qnt = memberDao.cartQuantity(param); // 상품 수량 가져오기
							qnt += Integer.parseInt(quantity[i]); // 원래수량에 더하기
							param.put("pQuantity", qnt);
							memberDao.cartChg(param); // 수량 업데이트
						}
					}
				}
			}
			// 로그인 했을때
			String mbId = session.getAttribute("mbId").toString();
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			memberDao.cartCheck(mbId); // 30일 지난 상품 삭제
			List<Cart> products = memberDao.cartRead(mbId);
			if (products.size() > 0) { // 로그인o, 장바구니에 상품이 있을때
				for (int i = 0; i < products.size(); i++) {
					int stock = productDao.pStock(products.get(i).getPno());
					if (stock == 0) { // 재고 0이면 장바구니에서 삭제
						paramMap.put("pno", products.get(i).getPno());
						memberDao.cartDlt(paramMap);
					}
				}
				products = memberDao.cartRead(mbId);
				for (int i = 0; i < products.size(); i++) { // 현재 상품재고 set
					int stock = productDao.pStock(products.get(i).getPno());
					products.get(i).setpStock(stock);
				}
				model.put("products", products);
				return "/order/order_cart.jsp";
			} else { // 로그인o, 장바구니에 상품이 없을때
				return "order_empCart.jsp";
			}
		}
		
	}
		
}
