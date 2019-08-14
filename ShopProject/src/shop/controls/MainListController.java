package shop.controls;

import java.util.Map;

import shop.annotation.Component;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlProductDao;
@Component("/main/list.do")
public class MainListController implements Controller{
	MySqlProductDao productDao;
	MySqlCategoryDao categoryDao;

	public MainListController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}
	
	  public MainListController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}
	
	@Override
	public String execute(Map<String, Object> model) throws Exception {
		model.put("newProduct", productDao.newMain()); //신상품12개
		//model.put("bestProduct", productDao.bestMain()); 베스트상품 8개
		model.put("high", categoryDao.highCtgryList()); //대분류 카테고리
		model.put("low1",categoryDao.lowCtgry1()); //강아지 카테고리
		model.put("low2",categoryDao.lowCtgry2()); //고양이 카테고리
		model.put("small",categoryDao.smallCtgry()); //소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); //모달창 카테고리
		return "/main/main.jsp";
	}

}
