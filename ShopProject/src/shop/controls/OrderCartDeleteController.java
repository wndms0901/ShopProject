package shop.controls;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shop.annotation.Component;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlMemberDao;
import shop.dao.MySqlProductDao;

@Component("/order/cartDlt.do")
public class OrderCartDeleteController implements Controller {
	MySqlProductDao productDao;
	MySqlCategoryDao categoryDao;
	MySqlMemberDao memberDao;

	public OrderCartDeleteController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public OrderCartDeleteController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public OrderCartDeleteController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HttpSession session = (HttpSession)model.get("session");
		HttpServletRequest request = (HttpServletRequest)model.get("request");
		String[] pnos =request.getParameterValues("pno");
		if(session.getAttribute("mbId")==null) { /*로그인 안했을 때*/
			for(String pno: pnos) {
				System.out.println("삭제되는 pno:"+pno);
				session.removeAttribute(pno);
			}
		}else { /* 로그인 했을 때 */ 
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			String mbId = session.getAttribute("mbId").toString();
			paramMap.put("mbId", mbId);
			for(String pno: pnos) {
				paramMap.put("pno",pno);
				memberDao.cartDlt(paramMap); // 선택한 장바구니 상품 삭제
			}
		}
		return "redirect:/order/cart.do";
	}

}
