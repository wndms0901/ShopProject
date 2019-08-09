package shop.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import shop.annotation.Component;
import shop.vo.Category;

@Component("categoryDao")
public class MySqlCategoryDao implements CategoryDao {
	SqlSessionFactory sqlSessionFactory;

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	@Override
	public List<Category> highCtgryList() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.highCtgryList");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Category> mediumCtgryList(int highCtgryNo) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.mediumCtgryList",highCtgryNo);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Category> lowCtgryList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.lowCtgryList", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Category> lowList(int mediumCtgryNo) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.lowList",mediumCtgryNo);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Category> lowCtgrySelect(int mediumCtgryNo) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.lowCtgrySelect",mediumCtgryNo);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<List<Category>> CtgryAll() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<List<Category>> list = new ArrayList<List<Category>>();
		try {
			for (int num = 1; num <= 5; num++) {
				List<Category> ctgry = sqlSession.selectList("shop.dao.CategoryDao.CtgryAll", num);
				list.add(ctgry);
			}
			return list;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Category> lowCtgry1() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.lowCtgry1");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Category> lowCtgry2() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.lowCtgry2");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Category> smallCtgry() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.CategoryDao.smallCtgry");
		} finally {
			sqlSession.close();
		}
	}

}
