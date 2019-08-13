package shop.controls;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import shop.annotation.Component;
import shop.bind.DataBinding;
import shop.dao.MySqlProductDao;
import shop.vo.Product;

@Component("/product/stockCheckA.do")
public class StockCheckAController implements VoidController, DataBinding {
	MySqlProductDao productDao;


	public void setProductDao(MySqlProductDao productDao) {
		this.productDao = productDao;
	}

	@Override
	public Object[] getDataBinders() {
		return new Object[] {"pno",Integer.class, "pQuantity", String.class};
	}

	@Override
	public void execute(Map<String, Object> model) throws Exception {
		System.out.println("stockCheckA Controller 실행.............");
		HttpServletResponse response = (HttpServletResponse) model.get("response");
		PrintWriter out = response.getWriter();
		int pno = (int) model.get("pno");
		if(model.get("pQuantity")!=null) { //상품재고 체크
		int pQuantity = Integer.parseInt(model.get("pQuantity").toString());
		int result = 0;
		Product product = productDao.pGet(pno);
		if(product.getpStock()<1) { //재고가 없을때
			result =1;
		}else if(product.getpStock() < pQuantity) { // 재고 < 주문수량 일때
			result = 2;
		}
		out.print(result);
		}else { //현재 상품재고 출력
			Product product = productDao.pGet(pno);
			int result = product.getpStock();
			out.print(result);
		}
	}

}
