package shop.controls;

import java.util.HashMap;
import java.util.Map;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlProductDao;
import shop.vo.Criteria;
import shop.vo.PageMaker;
@Component("/product/search.do")
public class ProductSearchController implements Controller,DataBinding {
	MySqlProductDao productDao;
	MySqlCategoryDao categoryDao;

	public ProductSearchController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}
	
	  public ProductSearchController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}
	  
	@Override
	public Object[] getDataBinders() {
		return new Object[] {"pName",String.class,"pCompany",String.class,"sort",String.class, "cri", Criteria.class};
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		 HashMap<String, Object> paramMap =new HashMap<String, Object>();
		 Criteria cri = (Criteria) model.get("cri");
		 PageMaker pageMaker = new PageMaker();
		 pageMaker.setCri(cri);
		 
		 paramMap.put("sort", model.get("sort"));
		 if(model.get("pName")!=null) {
			 paramMap.put("pName", model.get("pName"));
			 model.put("pName", model.get("pName")); //상품명
		 }
		 else if(model.get("pCompany")!=null) {
			 paramMap.put("pCompany", model.get("pCompany"));
			 model.put("pCompany", model.get("pCompany")); //브랜드명
		 }
		 pageMaker.setTotalCount(productDao.pSearchCount(paramMap));
		 model.put("searchTotal", productDao.pSearchCount(paramMap));
		 
		model.put("high", categoryDao.highCtgryList()); //대분류 카테고리
		model.put("low1",categoryDao.lowCtgry1()); //강아지 카테고리
		model.put("low2",categoryDao.lowCtgry2()); //고양이 카테고리
		model.put("small",categoryDao.smallCtgry()); //소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); //모달창 카테고리
		
		paramMap.put("cri", cri);
		model.put("products", productDao.pSearch(paramMap)); //검색결과
		model.put("pageMaker", pageMaker); // 페이징
		return "/product/product_search.jsp";
	}

}
