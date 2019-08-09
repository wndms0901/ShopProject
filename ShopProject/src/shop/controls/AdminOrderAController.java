package shop.controls;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlOrderDao;
import shop.vo.OrderList;

@Component("/admin/orderA.do")
public class AdminOrderAController implements VoidController, DataBinding {
	MySqlOrderDao orderDao;

	public AdminOrderAController setOrderDao(MySqlOrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "orderId", String.class, "index", String.class };
	}

	@Override
	public void execute(Map<String, Object> model) throws Exception {
		HttpServletResponse response = (HttpServletResponse) model.get("response");
		PrintWriter out = response.getWriter();
		String result = "";
		String orderId = model.get("orderId").toString();

		if (orderId.startsWith("m")) {
			List<OrderList> list = orderDao.mbOrderListGet(orderId);
			for (int i = 0; i < list.size(); i++) {
				result+= "<p style='margin:0;font-size:14px'>"+list.get(i).getpName()+"</p>";
			}
		}
		if (orderId.startsWith("g")) {
			List<OrderList> list = orderDao.gstOrderListGet(orderId);
			for (int i = 0; i < list.size(); i++) {
				result+= "<p style='margin:0;font-size:14px'>"+list.get(i).getpName()+"</p>";
			}
		}

		out.println(result);
	}

}
