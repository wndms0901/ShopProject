package shop.controls;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import shop.annotation.Component;
import shop.dao.MySqlMemberDao;
import shop.dao.MySqlOrderDao;
@Component("/admin/main.do")
public class AdminMainController implements Controller{
	MySqlMemberDao memberDao;
	MySqlOrderDao orderDao;
	
	public AdminMainController setMemberDao(MySqlMemberDao memberDao) {
		this.memberDao = memberDao;
		return this;
	}

	public AdminMainController setOrderDao(MySqlOrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("MM월 dd일 HH:mm");
		Date date = new Date();
		String now = format.format(date);
		int todayOrderCount = orderDao.todayGstOrderCount()+orderDao.todayMbOrderCount();
		int todayOrderSum = orderDao.todayGstOrderSum()+orderDao.todayMbOrderSum();
		int monthOrderCount = orderDao.monthGstOrderCount()+orderDao.monthMbOrderCount();
		int monthOrderSum = orderDao.monthGstOrderSum()+orderDao.monthMbOrderSum();
		model.put("now", now+" 기준");
		model.put("todayJoin", memberDao.todayJoin());
		model.put("monthJoin", memberDao.monthJoin());
		model.put("todayOrderCount", todayOrderCount);
		model.put("todayOrderSum", todayOrderSum);
		model.put("monthOrderCount", monthOrderCount);
		model.put("monthOrderSum", monthOrderSum);
		
		return "/admin/main.jsp";
	}

}
