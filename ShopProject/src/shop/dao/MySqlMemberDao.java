package shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import shop.annotation.Component;
import shop.vo.Cart;
import shop.vo.Member;
import shop.vo.Mileage;
import shop.vo.MyPage;

@Component("memberDao")
public class MySqlMemberDao implements MemberDao {
	SqlSessionFactory sqlSessionFactory;

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	@Override
	public int mbAdd(Member member) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.MemberDao.mbAdd", member);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Member mbRead(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.mbRead", mbId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbUpdate(Member member) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.MemberDao.mbUpdate", member);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbIdCheck(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.mbIdCheck", mbId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbCheck(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.mbCheck", paramMap);
		} finally {
			sqlSession.close();
		}
	}
	
	@Override
	public int mbLogin(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.MemberDao.mbLogin", mbId);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Member mbOrder(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.mbOrder", mbId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int cartmAdd(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.MemberDao.cartmAdd", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int cartpAdd(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.MemberDao.cartpAdd", mbId);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Cart> cartRead(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.MemberDao.cartRead", mbId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int cartProductCheck(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.cartProductCheck", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int cartChg(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.MemberDao.cartChg", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int cartQuantity(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.cartQuantity", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int cartDlt(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.delete("shop.dao.MemberDao.cartDlt", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int cartCheck(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.delete("shop.dao.MemberDao.cartCheck", mbId);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Mileage> mbMileage(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.MemberDao.mbMileage", mbId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Mileage> mbMileageList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.MemberDao.mbMileageList", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbMileageCount(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.mbMileageCount", mbId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mileageAdd(Mileage mileage) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.MemberDao.mileageAdd", mileage);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mileageUpdate(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.MemberDao.mileageUpdate", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<MyPage> mypageOrder(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.MemberDao.mypageOrder", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public MyPage totalOrder(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.totalOrder", mbId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int todayJoin() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.todayJoin");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int monthJoin() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.monthJoin");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Member> memberList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.MemberDao.memberList", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int memberListCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.MemberDao.memberListCount", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbMemoUpdate(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.MemberDao.mbMemoUpdate", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int mbDelete(String mbId) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.delete("shop.dao.MemberDao.mbDelete", mbId);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}
	
}