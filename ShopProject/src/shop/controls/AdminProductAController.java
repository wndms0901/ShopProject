package shop.controls;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.vo.Category;

@Component("/admin/productA.do")
public class AdminProductAController implements VoidController, DataBinding {
	MySqlCategoryDao categoryDao;

	public AdminProductAController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "ctgry", String.class, "no", String.class };
	}

	@Override
	public void execute(Map<String, Object> model) throws Exception {
		HttpServletResponse response= (HttpServletResponse)model.get("response");
		PrintWriter out = response.getWriter();
		String result = "";
		if (model.get("ctgry").equals("medium")) {
			int highCtgryNo = Integer.parseInt(model.get("no").toString());
			List<Category> medium = categoryDao.mediumCtgryList(highCtgryNo);
			for (int i = 0; i < medium.size(); i++) {
				result+="<option value="+medium.get(i).getMediumCtgryNo()+">";
				result+=medium.get(i).getMediumCtgryName()+"</option>";
			}
		}
		if (model.get("ctgry").equals("low")) {
			int mediumCtgryNo = Integer.parseInt(model.get("no").toString());
			List<Category> low =categoryDao.lowCtgrySelect(mediumCtgryNo);
			for (int i = 0; i < low.size(); i++) {
				result+="<option value="+low.get(i).getLowCtgryName()+">";
				result+=low.get(i).getLowCtgryName()+"</option>";
			}
		}
		out.println(result);
	}

}
