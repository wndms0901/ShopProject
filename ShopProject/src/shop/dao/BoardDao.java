package shop.dao;

import java.util.HashMap;
import java.util.List;

import shop.vo.Board;
import shop.vo.Event;
import shop.vo.Notice;

public interface BoardDao {
	public List<Event> currentEvent(HashMap<String, Object> paramMap) throws Exception;

	public int currentEventCount() throws Exception;

	public List<Event> endEvent(HashMap<String, Object> paramMap) throws Exception;

	public int endEventCount() throws Exception;

	public Event eventRead(int no) throws Exception;

	public int eventCountUpdate(int no) throws Exception;

	public List<Notice> noticeList(HashMap<String, Object> paramMap) throws Exception;

	public int noticeListCount(HashMap<String, Object> paramMap) throws Exception;

	public Notice noticeRead(int no) throws Exception;

	public int noticeCountUpdate(int no) throws Exception;

	public List<Board> boardList() throws Exception;

	public List<Board> postList(HashMap<String, Object> paramMap) throws Exception;
	
	public int postListCount(HashMap<String, Object> paramMap) throws Exception;

	public List<Board> totalPostList(HashMap<String, Object> paramMap) throws Exception;
	
	public int totalPostListCount(HashMap<String, Object> paramMap) throws Exception;

	public int postAdd(Board board) throws Exception;

	public int postUpdate(Board board) throws Exception;

	public int postDelete(HashMap<String, Object> paramMap) throws Exception;
}
