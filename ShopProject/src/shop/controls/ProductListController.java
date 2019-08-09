package shop.controls;

import java.util.HashMap;
import java.util.Map;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlProductDao;
import shop.vo.Criteria;
import shop.vo.PageMaker;

@Component("/product/list.do")
public class ProductListController implements Controller, DataBinding {
	MySqlProductDao productDao;
	MySqlCategoryDao categoryDao;

	public ProductListController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	public ProductListController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mCode", String.class, "lowNo", String.class, "sort", String.class, "cri",
				Criteria.class};
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Criteria cri = (Criteria) model.get("cri");
		cri.setPerPageNum(); //한 페이지당 보여줄 게시글의 갯수 12개로 변경
		model.put("high", categoryDao.highCtgryList()); // header 메뉴
		model.put("low1", categoryDao.lowCtgry1()); // 강아지 하위메뉴
		model.put("low2", categoryDao.lowCtgry2()); // 고양이 하위메뉴
		model.put("small", categoryDao.smallCtgry()); // 소동물 하위메뉴
		model.put("list", categoryDao.CtgryAll()); // 모달창 카테고리

		paramMap.put("mCode", model.get("mCode")); // 대분류 파라미터
		paramMap.put("lowNo", model.get("lowNo")); // 소분류 파라미터

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productDao.pListCount(paramMap));

		paramMap.put("sort", model.get("sort")); // 정렬 파라미터
		paramMap.put("cri", cri);
		model.put("products", productDao.pList(paramMap)); // 상품정보
		model.put("lowCtgry", categoryDao.lowCtgryList(paramMap)); // 상품메뉴
		model.put("mCode", model.get("mCode")); // mCode 파라미터
		model.put("lowNo", model.get("lowNo")); // lowNo 파라미터
		model.put("sort", model.get("sort"));
		model.put("pageMaker", pageMaker); // 페이징
		return "/product/product_list.jsp";
	}
}
