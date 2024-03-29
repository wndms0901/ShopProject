package shop.controls;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlMemberDao;

@Component("/order/cartA.do")
public class OrderCartAController implements VoidController, DataBinding {
	MySqlMemberDao memberDao;

	public void setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "pno", String.class, "pQuantity", Integer.class };
	}

	@Override
	public void execute(Map<String, Object> model) throws Exception {
		System.out.println("CartA Controller 실행.............");
		String pno = model.get("pno").toString();
		int pQuantity = Integer.parseInt(model.get("pQuantity").toString());
		HttpSession session = (HttpSession) model.get("session");
		if (session.getAttribute("mbId") == null) { /*로그인 안했을 때*/
			if (session.getAttribute(pno) != null) { // 이미 장바구니에 있는경우 수량 +
				int quantity = Integer.parseInt(session.getAttribute(pno).toString());
				quantity += pQuantity;
				session.setAttribute(pno, quantity);
			} else { // 장바구니에 없는 상품일 때
				session.setAttribute(pno, pQuantity);
			}
		} else { /*로그인 했을때*/
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			String mbId = session.getAttribute("mbId").toString();
			paramMap.put("pQuantity",pQuantity);
			paramMap.put("mbId", mbId);
			paramMap.put("pno", Integer.parseInt(pno));
			int result = memberDao.cartProductCheck(paramMap);
			
			if(result==0) { //장바구니에 없는 상품일 경우
				memberDao.cartmAdd(paramMap); //아이디,상품수 등록(insert)
				memberDao.cartpAdd(mbId);// 상품정보 등록(update)	
			}else { //이미 장바구니에 있는 상품일 경우
				int quantity =memberDao.cartQuantity(paramMap); //상품 수량 가져오기
				quantity+=pQuantity; // 원래수량에 더하기
				paramMap.put("pQuantity",quantity);
				memberDao.cartChg(paramMap); //수량 업데이트
			}
		}
		/*
		 * HttpServletResponse response= (HttpServletResponse)model.get("response");
		 * PrintWriter out = response.getWriter();
		 * out.print(session.getAttribute("pno"));
		 */
	}

}
