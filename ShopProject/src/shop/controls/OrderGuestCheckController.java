package shop.controls;

import java.util.HashMap;
import java.util.Map;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlOrderDao;
import shop.dao.MySqlProductDao;
@Component("/order/orderCheck.do")
public class OrderGuestCheckController implements Controller,DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlProductDao productDao;
	MySqlOrderDao orderDao;

	public OrderGuestCheckController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public OrderGuestCheckController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public OrderGuestCheckController setOrderDao(MySqlOrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}
	
	@Override
	public Object[] getDataBinders() {
		return new Object[] {"orderId",String.class,"buyerName",String.class};
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		String orderId= model.get("orderId").toString();
		String buyerName = model.get("buyerName").toString();
		paramMap.put("orderId", orderId);
		paramMap.put("buyerName", buyerName);
		model.put("order", orderDao.gstOrderGet(paramMap));
		model.put("products", orderDao.gstOrderListGet(orderId));
		return "order_guestOrderInfo.jsp";
	}

}
