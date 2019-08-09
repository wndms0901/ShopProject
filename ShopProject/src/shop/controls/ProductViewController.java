package shop.controls;

import java.util.Map;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlProductDao;

@Component("/product/view.do")
public class ProductViewController implements Controller, DataBinding {
	MySqlProductDao productDao;
	MySqlCategoryDao categoryDao;

	public ProductViewController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public ProductViewController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] {"pno", String.class};
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		int pno = Integer.parseInt(model.get("pno").toString());
		model.put("high", categoryDao.highCtgryList()); //대분류 카테고리
		model.put("low1",categoryDao.lowCtgry1()); //강아지 카테고리
		model.put("low2",categoryDao.lowCtgry2()); //고양이 카테고리
		model.put("small",categoryDao.smallCtgry()); //소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); //모달창 카테고리
		model.put("product",productDao.pRead(pno)); //상품정보
		return "product_view.jsp";
	}

}
