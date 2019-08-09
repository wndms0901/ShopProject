package shop.controls;

import java.util.Map;

import javax.servlet.http.HttpSession;

import shop.annotation.Component;
@Component("/member/logout.do")
public class MemberLogoutController implements Controller {

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		  HttpSession session = (HttpSession)model.get("session");
		    session.invalidate();
		    return "redirect:/main/list.do";
	}

}
