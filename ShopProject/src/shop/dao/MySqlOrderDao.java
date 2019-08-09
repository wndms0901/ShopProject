package shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import shop.annotation.Component;
import shop.vo.Order;
import shop.vo.OrderList;

@Component("orderDao")
public class MySqlOrderDao implements OrderDao {
	SqlSessionFactory sqlSessionFactory;

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	@Override
	public int gstOrderAdd(Order order) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.OrderDao.gstOrderAdd", order);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbOrderAdd(Order order) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.OrderDao.mbOrderAdd", order);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int orderNoMax(String value) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.orderNoMax", value);
		} catch (NullPointerException e) {
			return 0;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int gstOrderListAdd(OrderList orderList) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.OrderDao.gstOrderListAdd", orderList);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Order gstOrderGet(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.gstOrderGet", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<OrderList> gstOrderListGet(String orderId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.OrderDao.gstOrderListGet", orderId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbOrderListAdd(OrderList orderList) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.OrderDao.mbOrderListAdd", orderList);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Order mbOrderGet(String orderId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.mbOrderGet", orderId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<OrderList> mbOrderListGet(String orderId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.OrderDao.mbOrderListGet", orderId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int todayGstOrderCount() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.todayGstOrderCount");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int todayGstOrderSum() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.todayGstOrderSum");
		} catch (NullPointerException e) {
			return 0;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int todayMbOrderCount() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.todayMbOrderCount");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int todayMbOrderSum() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.todayMbOrderSum");
		} catch (NullPointerException e) {
			return 0;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int monthGstOrderCount() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.monthGstOrderCount");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int monthGstOrderSum() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.monthGstOrderSum");
		} catch (NullPointerException e) {
			return 0;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int monthMbOrderCount() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.monthMbOrderCount");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int monthMbOrderSum() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.monthMbOrderSum");
		} catch (NullPointerException e) {
			return 0;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Order> orderList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.OrderDao.orderList",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Order> mbOrderList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.OrderDao.mbOrderList",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbOrderListCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.mbOrderListCount",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Order> gstOrderList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.OrderDao.gstOrderList",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int gstOrderListCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.OrderDao.gstOrderListCount",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbStateUpdate(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.OrderDao.mbStateUpdate", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int gstStateUpdate(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.OrderDao.gstStateUpdate", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

}
