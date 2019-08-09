package shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import shop.annotation.Component;
import shop.vo.Board;
import shop.vo.Event;
import shop.vo.Notice;
@Component("boardDao")
public class MySqlBoardDao implements BoardDao {
	SqlSessionFactory sqlSessionFactory;

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}
	
	@Override
	public List<Event> currentEvent(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.BoardDao.currentEvent",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int currentEventCount() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.BoardDao.currentEventCount");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Event> endEvent(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.BoardDao.endEvent",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int endEventCount() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.BoardDao.endEventCount");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Event eventRead(int no) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.BoardDao.eventRead", no);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int eventCountUpdate(int no) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.BoardDao.eventCountUpdate", no);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Notice> noticeList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.BoardDao.noticeList",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int noticeListCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.BoardDao.noticeListCount", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Notice noticeRead(int no) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.BoardDao.noticeRead", no);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int noticeCountUpdate(int no) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.BoardDao.noticeCountUpdate", no);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Board> boardList() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.BoardDao.boardList");
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Board> postList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.BoardDao.postList", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int postListCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.BoardDao.postListCount", paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Board> totalPostList(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectList("shop.dao.BoardDao.totalPostList",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int totalPostListCount(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.selectOne("shop.dao.BoardDao.totalPostListCount",paramMap);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int postAdd(Board board) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.insert("shop.dao.BoardDao.postAdd", board);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int postUpdate(Board board) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.update("shop.dao.BoardDao.postUpdate", board);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int postDelete(HashMap<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.delete("shop.dao.BoardDao.postDelete", paramMap);
			sqlSession.commit();
			return count;
		} finally {
			sqlSession.close();
		}
	}
	
}
