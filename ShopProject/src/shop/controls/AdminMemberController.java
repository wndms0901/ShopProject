package shop.controls;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlMemberDao;
import shop.vo.Criteria;
import shop.vo.PageMaker;
import shop.vo.Search;

@Component("/admin/member.do")
public class AdminMemberController implements Controller, DataBinding {
	MySqlMemberDao memberDao;

	public AdminMemberController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mode", String.class, "search", Search.class, "mbId", String.class, "cri",
				Criteria.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HttpServletRequest request = (HttpServletRequest) model.get("request");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("search", model.get("search"));
		if (model.get("mode") == null) { // 회원목록
			Criteria cri = (Criteria) model.get("cri");
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(memberDao.memberListCount(paramMap));
			paramMap.put("cri", cri);
			model.put("member", memberDao.memberList(paramMap));
			model.put("total", memberDao.memberListCount(paramMap));
			model.put("pageMaker", pageMaker); // 페이징
			return "/admin/memberList.jsp";
		} else if (model.get("mode").equals("update")) { // 메모 수정
			String[] mbId = request.getParameterValues("mbId");
			String[] mbMemo = request.getParameterValues("mbMemo");
			for (int i = 0; i < mbId.length; i++) {
				paramMap.put("mbId", mbId[i]);
				paramMap.put("mbMemo", mbMemo[i]);
				memberDao.mbMemoUpdate(paramMap);
			}
			return "redirect:/admin/member.do";
		} else if (model.get("mode").equals("read")) { // 회원정보
			String mbId = model.get("mbId").toString();
			model.put("member", memberDao.mbRead(mbId));
			return "/admin/memberRead.jsp";
		} else { // 회원 삭제
			String[] mbIds = request.getParameterValues("mbId");
			for (String mbId : mbIds) {
				memberDao.mbDelete(mbId);
			}
			return "redirect:/admin/member.do";
		}
	}

}
