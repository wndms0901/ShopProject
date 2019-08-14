package shop.controls;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlOrderDao;
import shop.vo.Criteria;
import shop.vo.Order;
import shop.vo.PageMaker;
import shop.vo.Search;

@Component("/admin/order.do")
public class AdminOrderController implements Controller, DataBinding {
	MySqlOrderDao orderDao;

	public AdminOrderController setOrderDao(MySqlOrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mode", String.class, "user", String.class, "search", Search.class, "orderState",
				String.class, "read", String.class, "cri", Criteria.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		Search search = (Search) model.get("search"); // 검색 데이터
		HttpServletRequest request = (HttpServletRequest) model.get("request");
		String[] values = request.getParameterValues("orderState");
		List<Order> order = null;
		List<String> orderState = new ArrayList<String>();
		if (values != null) {
			for (String value : values) {
				orderState.add(value);
			}
		}
		paramMap.put("search", search);

		if (model.get("mode") == null) { // 주문 목록
			Criteria cri = (Criteria) model.get("cri");
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			paramMap.put("cri", cri);
			if (model.get("user") == null) { // 전체 주문목록
				int total = orderDao.mbOrderListCount(paramMap)+orderDao.gstOrderListCount(paramMap);
				pageMaker.setTotalCount(total);
				order = orderDao.orderList(paramMap);
				model.put("order", order);
				model.put("total", total);
				model.put("pageMaker", pageMaker); // 페이징
			} else if (model.get("user").toString().equals("전체")) {
				paramMap.put("orderState", orderState);
				if (search.getType().equals("mbId")) { // 주문자 아이디로 검색
					pageMaker.setTotalCount(orderDao.mbOrderListCount(paramMap));
					order = orderDao.mbOrderList(paramMap);
					model.put("total", orderDao.mbOrderListCount(paramMap));
				} else {
					int total = orderDao.mbOrderListCount(paramMap)+orderDao.gstOrderListCount(paramMap);
					pageMaker.setTotalCount(total);
					order = orderDao.orderList(paramMap);
					model.put("total", total);
				}
				model.put("order", order);
				model.put("pageMaker", pageMaker); // 페이징
			} else if (model.get("user").equals("회원")) { // 회원 주문목록
				paramMap.put("orderState", orderState);
				int total = orderDao.mbOrderListCount(paramMap);
				pageMaker.setTotalCount(total);
				order = orderDao.mbOrderList(paramMap);
				model.put("order", order);
				model.put("total", total);
				model.put("pageMaker", pageMaker); // 페이징
			} else { // 비회원 주문목록
				paramMap.put("orderState", orderState);
				int total = orderDao.gstOrderListCount(paramMap);
				pageMaker.setTotalCount(total);
				order = orderDao.gstOrderList(paramMap);
				model.put("order", order);
				model.put("total", total);
				model.put("pageMaker", pageMaker); // 페이징
			}
			model.put("orderState", orderState);
			return "/admin/orderList.jsp";
		} else if (model.get("mode").equals("read")) { // 주문상세내역
			// 비회원 paramMap에 buyName 없이 출력해보기
			String orderId = request.getParameter("orderId");
			if (orderId.startsWith("m")) { // 회원
				model.put("order", orderDao.mbOrderGet(orderId));
				model.put("products", orderDao.mbOrderListGet(orderId));
			} else { // 비회원
				paramMap.put("orderId", orderId);
				model.put("order", orderDao.gstOrderGet(paramMap));
				model.put("products", orderDao.gstOrderListGet(orderId));
			}
			return "/admin/orderRead.jsp";
		} else { // 주문상태변경
			String[] orderIds = request.getParameterValues("orderId");
			paramMap.put("orderState", model.get("orderState"));
			for (String orderId : orderIds) {
				paramMap.put("orderId", orderId);
				if (orderId.startsWith("m")) { // 회원
					orderDao.mbStateUpdate(paramMap);
				} else { // 비회원
					orderDao.gstStateUpdate(paramMap);
				}
			}
			if (model.get("read") == null) { // 목록페이지에서 변경했을때
				return "redirect:/admin/order.do";
			} else { // 주문상세 페이지에서 변경했을때
				String orderId = request.getParameter("orderId");
				if (orderId.startsWith("m")) { // 회원
					model.put("order", orderDao.mbOrderGet(orderId));
					model.put("products", orderDao.mbOrderListGet(orderId));
				} else { // 비회원
					paramMap.put("orderId", orderId);
					model.put("order", orderDao.gstOrderGet(paramMap));
					model.put("products", orderDao.gstOrderListGet(orderId));
				}
				return "/admin/orderRead.jsp";
			}
		}
	}

}
