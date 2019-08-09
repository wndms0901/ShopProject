package shop.controls;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlMemberDao;

@Component("/member/mbCheckA.do")
public class MemberCheckAController implements VoidController, DataBinding {
	MySqlMemberDao memberDao;

	public void setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mbId", String.class, "mbPwd", String.class };
	}

	@Override
	public void execute(Map<String, Object> model) throws Exception {
		System.out.println("mbCheckA Controller 실행.............");
		HttpServletResponse response = (HttpServletResponse) model.get("response");
		PrintWriter out = response.getWriter();
		int result = 0;
		if (model.get("mbPwd") == null) {
			result =memberDao.mbIdCheck(model.get("mbId").toString());
			System.out.println("중복체크!!!!!"+result);
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("mbId", model.get("mbId"));
			paramMap.put("mbPwd", model.get("mbPwd"));
			result = memberDao.mbCheck(paramMap);
		}
		out.print(result);
	}

}
