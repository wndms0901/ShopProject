package shop.controls;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlBoardDao;
import shop.dao.MySqlCategoryDao;
import shop.vo.Board;
import shop.vo.Criteria;
import shop.vo.Event;
import shop.vo.Notice;
import shop.vo.PageMaker;

@Component("/board/list.do")
public class BoardController implements Controller, DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlBoardDao boardDao;

	public BoardController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public BoardController setBoardDao(MySqlBoardDao boardDao) {
		this.boardDao = boardDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "board", Board.class, "cri", Criteria.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리

		HttpServletRequest request = (HttpServletRequest) model.get("request");
		HttpServletResponse response = (HttpServletResponse) model.get("response");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Board board = (Board) model.get("board");
		Criteria cri = (Criteria) model.get("cri");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		if (board.getBoardCode().equals("event") && board.getNo() == null) { // 이벤트 목록
			if (board.getPeriod() == "" || board.getPeriod() == null || board.getPeriod().equals("current")) {
				pageMaker.setTotalCount(boardDao.currentEventCount());
				paramMap.put("cri", cri);
				model.put("eventList", boardDao.currentEvent(paramMap));
				model.put("pageMaker", pageMaker); // 페이징
				return "/board/eventList.jsp";
			} else if (board.getPeriod().equals("end")) {
				pageMaker.setTotalCount(boardDao.endEventCount());
				paramMap.put("cri", cri);
				model.put("eventList", boardDao.endEvent(paramMap));
				model.put("pageMaker", pageMaker); // 페이징
				return "/board/eventList.jsp";
			}
		} else if (board.getBoardCode().equals("event") && board.getNo() != null) { // 이벤트 조회
			boolean check = false;
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie c : cookies) {
					if (c.getName().equals("eno" + String.valueOf(board.getNo()))) { // eno 쿠키가 있는 경우
						check = true;
					}
				}
				if (!check) { // eno 쿠키가 없는 경우
					System.out.println("조회수 증가..................");
					boardDao.eventCountUpdate(Integer.parseInt(board.getNo())); // 조회수 증가
					Cookie c = new Cookie("eno" + String.valueOf(board.getNo()), String.valueOf(board.getNo()));
					c.setMaxAge(1 * 24 * 60 * 60); // 하루저장
					response.addCookie(c);
				}
			}
			Event event = boardDao.eventRead(Integer.parseInt(board.getNo()));
			model.put("e", event);
			return "/board/eventView.jsp";
		} else if (board.getBoardCode().equals("notice") && board.getNo() == null) { // 공지사항 목록
			paramMap.put("type", board.getType());
			paramMap.put("keyword", board.getKeyword());
			pageMaker.setTotalCount(boardDao.noticeListCount(paramMap));
			paramMap.put("cri", cri);
			model.put("noticeList", boardDao.noticeList(paramMap));
			model.put("pageMaker", pageMaker); // 페이징
			return "/board/noticeList.jsp";
		} else if (board.getBoardCode().equals("notice") && board.getNo() != null) { // 공지사항 조회
			boolean check = false;
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie c : cookies) {
					if (c.getName().equals("no" + String.valueOf(board.getNo()))) { // no 쿠키가 있는 경우
						check = true;
					}
				}
				if (!check) { // no 쿠키가 없는 경우
					System.out.println("조회수 증가..................");
					boardDao.noticeCountUpdate(Integer.parseInt(board.getNo())); // 조회수 증가
					Cookie c = new Cookie("no" + String.valueOf(board.getNo()), String.valueOf(board.getNo()));
					c.setMaxAge(1 * 24 * 60 * 60); // 하루저장
					response.addCookie(c);
				}
			}
			Notice notice = boardDao.noticeRead(Integer.parseInt(board.getNo()));
			model.put("notice", notice);
			return "/board/noticeView.jsp";
		}
		return null;
	}
}
