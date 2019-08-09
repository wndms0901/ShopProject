package shop.controls;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlBoardDao;
import shop.vo.Board;
import shop.vo.Criteria;
import shop.vo.Event;
import shop.vo.Notice;
import shop.vo.PageMaker;
import shop.vo.Search;

@Component("/admin/board.do")
public class AdminBoardController implements Controller, DataBinding {
	MySqlBoardDao boardDao;

	public AdminBoardController setBoardDao(MySqlBoardDao boardDao) {
		this.boardDao = boardDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "board", Board.class, "search", Search.class, "mode", String.class, "cri",
				Criteria.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HttpServletRequest request = (HttpServletRequest) model.get("request");
		HttpServletResponse response = (HttpServletResponse) model.get("response");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Board board = (Board) model.get("board");
		Search search = (Search) model.get("search");
	

		if (model.get("mode") == null) { // 목록
			model.put("list", boardDao.boardList()); // 게시판 종류
			Criteria cri = (Criteria) model.get("cri");
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			paramMap.put("cri", cri);
			if (board.getBno() != 0) { // 선택한 게시판의 게시물
				paramMap.put("board", board);
				paramMap.put("search", search);
				pageMaker.setTotalCount(boardDao.postListCount(paramMap));
				model.put("b", board);
				model.put("total", boardDao.postListCount(paramMap));
				model.put("post", boardDao.postList(paramMap));
			} else { // 전체 게시물
				paramMap.put("board", boardDao.boardList());
				paramMap.put("search", search);
				pageMaker.setTotalCount(boardDao.totalPostListCount(paramMap));
				model.put("total", boardDao.totalPostListCount(paramMap));
				model.put("post", boardDao.totalPostList(paramMap));
			}
			model.put("pageMaker", pageMaker); // 페이징
			return "/admin/boardList.jsp";
		} else if (model.get("mode").equals("write")) { // 글쓰기
			if (board.getTitle() == null) { // 글쓰기 페이지
				model.put("boardCode", board.getBoardCode());
				if (board.getBoardCode().equals("notice")) { // 공지사항 글쓰기
					return "/admin/noticeWrite.jsp";
				} else { // 이벤트 글쓰기
					return "/admin/eventWrite.jsp";
				}
			} else { // 글등록 후 게시판목록 페이지로 이동
				System.out.println("글쓰기.............");
				boardDao.postAdd(board);
				return "redirect:/admin/board.do";
			}
		} else if (model.get("mode").equals("read")) { // 글읽기
			if (board.getBoardCode().equals("notice")) { // 공지사항 게시물
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
				return "/admin/noticeRead.jsp";
			} else { // 이벤트 게시물
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
				return "/admin/eventRead.jsp";
			}
		} else if (model.get("mode").equals("update")) { // 글수정
			if (board.getTitle() == null) { // 글수정 페이지
				if (board.getBoardCode().equals("notice")) { // 공지사항 게시물
					Notice notice = boardDao.noticeRead(Integer.parseInt(board.getNo()));
					model.put("boardCode", board.getBoardCode());
					model.put("no", board.getNo());
					model.put("notice", notice);
					return "noticeUpdate.jsp";
				} else { // 이벤트 게시물
					Event event = boardDao.eventRead(Integer.parseInt(board.getNo()));
					model.put("boardCode", board.getBoardCode());
					model.put("no", board.getNo());
					model.put("e", event);
					return "eventUpdate.jsp";
				}
			} else { // 글 수정한후 게시판목록 페이지로 이동
				boardDao.postUpdate(board);
				return "redirect:/admin/board.do";
			}
		} else { // 게시물 삭제
			String[] boardCode = request.getParameterValues("boardCode");
			String[] no = request.getParameterValues("no");
			for (int i = 0; i < boardCode.length; i++) {
				paramMap.put("boardCode", boardCode[i]);
				paramMap.put("no", no[i]);
				boardDao.postDelete(paramMap);
			}
			return "redirect:/admin/board.do";
		}
	}

}
