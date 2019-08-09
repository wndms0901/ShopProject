package shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import shop.annotation.Component;
import shop.vo.Product;
import shop.vo.Search;

@Component("productDao")
public class MySqlProductDao implements ProductDao {
	SqlSessionFactory sqlSessionFactory;

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	@Override
	public int productAdd(Product product) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.ProductDao.productAdd", product);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Product> newList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.ProductDao.newList", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Product> bestList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.ProductDao.bestList", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Product> newMain() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.ProductDao.newMain");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Product> bestMain(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.ProductDao.bestMain", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Product> pList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.ProductDao.pList", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int pListCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.ProductDao.pListCount", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Product> pSearch(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.ProductDao.pSearch", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int pSearchCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.ProductDao.pSearchCount", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Product pRead(int pno) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.ProductDao.pRead", pno);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Product pGet(int pno) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.ProductDao.pGet", pno);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int pStock(int pno) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.ProductDao.pStock", pno);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int pStockMinus(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.ProductDao.pStockMinus", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int pBuyNumUpdate(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.ProductDao.pBuyNumUpdate", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Product> productList(HashMap<String, Object> paramMap) throws Exception{
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.ProductDao.productList",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int productListCount(Search search) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.ProductDao.productListCount",search);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int pDelete(int pno) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.delete("shop.dao.ProductDao.pDelete", pno);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int pUpdate(Product product) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.ProductDao.pUpdate", product);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

}
