package shop.controls;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlMemberDao;

@Component("/order/cartChgA.do")
public class OrderCartChageAController implements VoidController, DataBinding {
	MySqlMemberDao memberDao;
	
	public OrderCartChageAController setMySqlMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "pno", String.class, "pQuantity", Integer.class };
	}

	@Override
	public void execute(Map<String, Object> model) throws Exception {
		HttpSession session = (HttpSession) model.get("session");
		if (session.getAttribute("mbId") == null) { /* 로그인 안했을 때 */
			session.setAttribute(model.get("pno").toString(), model.get("pQuantity"));
		} else { /* 로그인 했을 때 */
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("mbId", session.getAttribute("mbId"));
			paramMap.put("pno", model.get("pno"));
			paramMap.put("pQuantity", model.get("pQuantity"));
			memberDao.cartChg(paramMap);
		}
	}

}
