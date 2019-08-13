package shop.dao;

import java.util.HashMap;
import java.util.List;

import shop.vo.Product;
import shop.vo.Search;

public interface ProductDao {
	public int productAdd(Product product);

	public List<Product> newMain() throws Exception;

	public List<Product> bestMain(HashMap<String, Object> paramMap) throws Exception;

	public List<Product> newList(HashMap<String, Object> paramMap) throws Exception;

	public List<Product> bestList(HashMap<String, Object> paramMap) throws Exception;

	public List<Product> pList(HashMap<String, Object> paramMap) throws Exception;
	
	public int pListCount(HashMap<String, Object> paramMap) throws Exception;

	public List<Product> pSearch(HashMap<String, Object> paramMap) throws Exception;
	
	public int pSearchCount(HashMap<String, Object> paramMap) throws Exception;

	public Product pRead(int pno);

	public Product pGet(int pno);

	public int pStock(int pno);

	public int pStockMinus(HashMap<String, Object> paramMap) throws Exception;

	public int pBuyNumUpdate(HashMap<String, Object> paramMap) throws Exception;
	
	public int pSoldOut(int pno) throws Exception;

	public List<Product> productList(HashMap<String, Object> paramMap) throws Exception;
	
	public int productListCount(Search search) throws Exception;

	public int pDelete(int pno) throws Exception;

	public int pUpdate(Product product) throws Exception;
}
