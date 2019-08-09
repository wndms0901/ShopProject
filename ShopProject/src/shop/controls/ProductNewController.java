package shop.controls;

import java.util.HashMap;
import java.util.Map;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlProductDao;
import shop.vo.Criteria;
import shop.vo.PageMaker;

@Component("/product/new.do")
public class ProductNewController implements Controller, DataBinding {
	MySqlProductDao productDao;
	MySqlCategoryDao categoryDao;

	public ProductNewController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public ProductNewController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] {"sort", String.class, "cri", Criteria.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Criteria cri = (Criteria) model.get("cri");
		cri.setPerPageNum(); //한 페이지당 보여줄 게시글의 갯수 12개로 변경
		
		model.put("high", categoryDao.highCtgryList()); // 대분류 카테고리
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 카테고리
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 카테고리
		model.put("small", categoryDao.smallCtgry()); // 소동물 카테고리
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(30);

		if (model.get("sort") != null) {
			paramMap.put("sort", model.get("sort"));
		}
		paramMap.put("cri", cri);
		model.put("products", productDao.newList(paramMap)); // 신상품
		model.put("pageMaker", pageMaker); // 페이징
		return "/product/product_new.jsp";
	}

}
