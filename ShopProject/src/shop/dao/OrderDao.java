package shop.dao;

import java.util.HashMap;
import java.util.List;

import shop.vo.Order;
import shop.vo.OrderList;

public interface OrderDao {
	public int gstOrderAdd(Order order) throws Exception;

	public int mbOrderAdd(Order order) throws Exception;

	public int orderNoMax(String value) throws Exception;

	public int gstOrderListAdd(OrderList orderList) throws Exception;

	public Order gstOrderGet(HashMap<String, Object> paramMap) throws Exception;

	public List<OrderList> gstOrderListGet(String orderId) throws Exception;

	public int mbOrderListAdd(OrderList orderList) throws Exception;

	public Order mbOrderGet(String orderId) throws Exception;

	public List<OrderList> mbOrderListGet(String orderId) throws Exception;

	public int todayGstOrderCount() throws Exception;

	public int todayGstOrderSum() throws Exception;

	public int todayMbOrderCount() throws Exception;

	public int todayMbOrderSum() throws Exception;

	public int monthGstOrderCount() throws Exception;

	public int monthGstOrderSum() throws Exception;

	public int monthMbOrderCount() throws Exception;

	public int monthMbOrderSum() throws Exception;

	public List<Order> orderList(HashMap<String, Object> paramMap) throws Exception;

	public List<Order> mbOrderList(HashMap<String, Object> paramMap) throws Exception;
	
	public int mbOrderListCount(HashMap<String, Object> paramMap) throws Exception;

	public List<Order> gstOrderList(HashMap<String, Object> paramMap) throws Exception;
	
	public int gstOrderListCount(HashMap<String, Object> paramMap) throws Exception;

	public int mbStateUpdate(HashMap<String, Object> paramMap) throws Exception;

	public int gstStateUpdate(HashMap<String, Object> paramMap) throws Exception;
}
