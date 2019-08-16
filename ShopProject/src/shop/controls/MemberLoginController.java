package shop.controls;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlMemberDao;

@Component("/member/login.do")
public class MemberLoginController implements Controller, DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlMemberDao memberDao;

	public MemberLoginController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public MemberLoginController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mbId", String.class, "mbPwd", String.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HttpSession session = (HttpSession) model.get("session");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리
		if (model.get("mbId") == null) { // 로그인 화면
			return "/member/login.jsp";
		} else { // 로그인 정보 세션에 등록
			paramMap.put("mbId", model.get("mbId")); // 아이디
			paramMap.put("mbPwd", model.get("mbPwd")); // 비밀번호
			int check = memberDao.mbCheck(paramMap);
			if (check == 0) { // 로그인 실패
				model.put("mbCheck", true);
				return "/member/login.jsp";
			} else { // 로그인 성공
				session.setAttribute("mbId", model.get("mbId"));
				String mbId = session.getAttribute("mbId").toString();
				Enumeration<String> cart = session.getAttributeNames();

				memberDao.mbLogin(mbId); // 로그인 시간 저장
				if (mbId.equals("admin")) { // 관리자 로그인
					return "redirect:/admin/main.do";
				} else { //일반회원 로그인
					while (cart.hasMoreElements()) { // 세션에 저장된 상품도 cart DB에 insert
						String pno = cart.nextElement();
						if (pno.equals("mbId") || pno.startsWith("javax")) {
							continue;
						}
						String pQuantity = session.getAttribute(pno).toString();
						paramMap.put("pno", Integer.parseInt(pno));
						paramMap.put("pQuantity", Integer.parseInt(pQuantity));
						
						int result = memberDao.cartProductCheck(paramMap);
						
						if(result==0) { //장바구니에 없는 상품일 경우
							memberDao.cartmAdd(paramMap); //아이디,상품수 등록(insert)
							memberDao.cartpAdd(mbId);// 상품정보 등록(update)	
						}else { //이미 장바구니에 있는 상품일 경우
							int quantity = memberDao.cartQuantity(paramMap); // 상품 수량 가져오기
							quantity += Integer.parseInt(pQuantity); // 원래수량에 더하기
							paramMap.put("pQuantity", quantity);
							memberDao.cartChg(paramMap); // 수량 업데이트
						}
					}
					return "redirect:/main/list.do";
				}
			}
		}
	}
}
