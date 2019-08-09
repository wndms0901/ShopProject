package shop.controls;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlCategoryDao;
import shop.dao.MySqlProductDao;
import shop.vo.Category;
import shop.vo.Criteria;
import shop.vo.PageMaker;
import shop.vo.Product;
import shop.vo.Search;

@Component("/admin/product.do")
public class AdminProductController implements Controller, DataBinding {
	MySqlCategoryDao categoryDao;
	MySqlProductDao productDao;

	public AdminProductController setCategoryDao(MySqlCategoryDao categoryDao) {
		this.categoryDao = categoryDao;
		return this;
	}

	public AdminProductController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mode", String.class, "product", Product.class, "search", Search.class, "cri",
				Criteria.class };
	}

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Criteria cri = (Criteria) model.get("cri");
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		if (model.get("mode") != null) {
			String mode = model.get("mode").toString();
			Product product = (Product) model.get("product");

			if (mode.equals("register")) { // 상품등록
				if (product.getpName() == null) { // 상품등록화면
					model.put("high", categoryDao.highCtgryList());
					return "/admin/productAdd.jsp";
				} else { // 상품등록후 목록화면으로
					productDao.productAdd(product);
					return "redirect:/admin/product.do";
				}
			} else if (mode.equals("update")) { // 상품수정
				if (product.getpName() == null) { // 상품수정화면
					List<List<Category>> medium = new ArrayList<List<Category>>();
					List<List<Category>> low = new ArrayList<List<Category>>();
					for (int i = 1; i <= 3; i++) {
						medium.add(categoryDao.mediumCtgryList(i));
					}
					for (int i = 1; i <= 5; i++) {
						low.add(categoryDao.lowList(i));
					}
					model.put("high", categoryDao.highCtgryList());
					model.put("medium", medium);
					model.put("low", low);
					model.put("product", productDao.pRead(product.getPno()));
					return "/admin/productUpdate.jsp";
				} else { // 상품정보 수정 후 목록화면으로
					productDao.pUpdate(product);
					return "redirect:/admin/product.do";
				}
			} else { // 상품삭제
				HttpServletRequest request = (HttpServletRequest) model.get("request");
				String[] pnos = request.getParameterValues("pno");
				for (String pno : pnos) {
					productDao.pDelete(Integer.parseInt(pno));
				}
				return "redirect:/admin/product.do";
			}
		} else { // 상품목록
			Search search = (Search) model.get("search");
			pageMaker.setTotalCount(productDao.productListCount(search)); //전체 상품수
			paramMap.put("search", search);
			paramMap.put("cri", cri);
			
			model.put("high", categoryDao.highCtgryList());
			model.put("product", productDao.productList(paramMap));
			model.put("total", productDao.productListCount(search)); //전체 상품수
			model.put("pageMaker", pageMaker); // 페이징
			return "/admin/productList.jsp";
		}
	}
}
