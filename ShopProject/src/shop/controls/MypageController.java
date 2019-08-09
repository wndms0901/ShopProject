package shop.controls;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlMemberDao;
import shop.dao.MySqlOrderDao;
import shop.vo.Criteria;
import shop.vo.Member;
import shop.vo.Mileage;
import shop.vo.MyPage;
import shop.vo.PageMaker;

@Component("/member/mypage.do")
public class MypageController implements Controller, DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlMemberDao memberDao;
	MySqlOrderDao orderDao;

	public MypageController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public MypageController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	public MypageController setOrderDao(MySqlOrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mypage", MyPage.class, "member", Member.class, "cri", Criteria.class};
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Criteria cri = (Criteria) model.get("cri");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리

		HttpSession session = (HttpSession) model.get("session");
		if(session.getAttribute("mbId")==null) {
			return "redirect:/member/login.do";
		}
		String mbId = session.getAttribute("mbId").toString();
		MyPage mypage = (MyPage) model.get("mypage");
		Member member = (Member) model.get("member");
		if (mypage.getOrderId() != null) { // 주문상세내역
			String orderId = mypage.getOrderId();
			model.put("order", orderDao.mbOrderGet(orderId));
			model.put("products", orderDao.mbOrderListGet(orderId));
			return "/order/order_memberOrderInfo.jsp";
		} else if (mypage.getGo() == null) { // 마이페이지 메인
			Member mb = memberDao.mbRead(mbId);
			MyPage myPage =memberDao.totalOrder(mbId);
			List<Mileage> mileage =memberDao.mbMileage(mbId);
			model.put("mbName", mb.getMbName()); //회원이름
			model.put("myPage", myPage); //총주문금액, 총주문횟수
			model.put("mileage", mileage); //사용가능적립금, 사용된 적립금
			return "/member/mypage.jsp";
		} else if (mypage.getGo().equals("order")) { // 주문내역조회
			MyPage myPage =memberDao.totalOrder(mbId);
			pageMaker.setTotalCount(myPage.getTotalOrderCount()); //전체 주문수
			
			paramMap.put("mbId", mbId);
			paramMap.put("cri", cri);
			List<MyPage> orderList = memberDao.mypageOrder(paramMap);
			for (int i = 0; i < orderList.size(); i++) {
				orderList.get(i).setOrderList(orderDao.mbOrderListGet(orderList.get(i).getOrderId()));
			}
			model.put("orderList", orderList);
			model.put("pageMaker", pageMaker); // 페이징
			return "/member/mypage_order.jsp";
		} else if (mypage.getGo().equals("mileage")) { // 적립금 조회
			pageMaker.setTotalCount(memberDao.mbMileageCount(mbId)); 
			
			paramMap.put("mbId", mbId);
			paramMap.put("cri", cri);
			List<Mileage> mileage =memberDao.mbMileageList(paramMap);
			model.put("mileage", mileage);
			model.put("pageMaker", pageMaker); // 페이징
			return "/member/mypage_mileage.jsp";
		} else { // 회원정보
			if (mypage.getMbId() == null) { // 비밀번호 확인
				return "/member/mypage_check.jsp";
			} else if(member.getMbName() == null){ // 회원정보
				Member mb = memberDao.mbRead(mypage.getMbId());
				model.put("mb", mb);
				return "/member/mypage_info.jsp";
			}else {                               // 회원정보 수정
				memberDao.mbUpdate(member);
				Member mb = memberDao.mbRead(mypage.getMbId());
				model.put("mb", mb);
				return "/member/mypage_info.jsp";
			}
		}
	}
}
