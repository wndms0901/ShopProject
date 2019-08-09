package shop.controls;

import java.util.Map;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlMemberDao;
import shop.vo.Member;
import shop.vo.Mileage;
@Component("/member/join.do")
public class MemberJoinController implements Controller,DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlMemberDao memberDao;

	public MemberJoinController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public MemberJoinController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}
	
	@Override
	public Object[] getDataBinders() {
		return new Object[] {"member",shop.vo.Member.class};
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		model.put("high", categoryDao.highCtgryList()); //대분류 카테고리
		model.put("low1",categoryDao.lowCtgry1()); //강아지 카테고리
		model.put("low2",categoryDao.lowCtgry2()); //고양이 카테고리
		model.put("small",categoryDao.smallCtgry()); //소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); //모달창 카테고리
		Member member = (Member)model.get("member");
		if(member.getMbId() == null) {
			return "/member/join.jsp";
		}else {
			Mileage mileage = new Mileage();
			mileage.setMbId(member.getMbId());
			mileage.setMileage(2000);
			mileage.setContent("신규회원 적립금");
			memberDao.mbAdd(member); //회원등록
			memberDao.mileageAdd(mileage); //적립금 정보 등록
			model.put("mb", memberDao.mbRead(member.getMbId()));
		return "/member/joinCmplt.jsp";
		}
	}

}
