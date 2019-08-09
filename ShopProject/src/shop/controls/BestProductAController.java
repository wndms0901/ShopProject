package shop.controls;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlProductDao;
import shop.vo.Product;

@Component("/product/bestA.do")
public class BestProductAController implements VoidController, DataBinding {
	MySqlProductDao productDao;


	public BestProductAController setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
		return this;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] { "mCode", String.class, "lowCode", String.class };
	}

	@Override
	public void execute(Map<String, Object> model) throws Exception {
		System.out.println("bestA Controller 실행.............");
		HttpServletResponse response= (HttpServletResponse)model.get("response");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		PrintWriter out = response.getWriter();
		String result ="";
		paramMap.put("mCode", model.get("mCode"));
		paramMap.put("lowCode", model.get("lowCode"));
		List<Product> product =productDao.bestMain(paramMap);
		for (int i =0 ;i<product.size();i++ ) {
			result+= "<div class='col-sm-3'> <div class='product-image-wrapper'>";
			result+="<div class='single-products'> <div class='productinfo text-center'>";
			result+="<a href='/product/view.do?pno="+product.get(i).getPno()+"'>";
			result+="<img src='../images/product/"+product.get(i).getpImage()+"' alt='베스트상품' /></a>";
			result+="<h2>"+product.get(i).getpName()+"</h2>";
			result+="<p class='bestPrice'>"+product.get(i).getPrice()+"원</p>";
			result+="</div> </div> </div> </div>";
		}
			out.println(result);
		}
	}

