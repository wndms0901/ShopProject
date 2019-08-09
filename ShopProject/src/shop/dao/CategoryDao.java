package shop.dao;

import java.util.HashMap;
import java.util.List;

import shop.vo.Category;


public interface CategoryDao {
	public List<Category> highCtgryList() throws Exception;
	public List<Category> mediumCtgryList(int highCtgryNo) throws Exception; //관리자 상품관리 페이지에서 사용
	public List<Category> lowCtgryList(HashMap<String, Object> paramMap) throws Exception;
	public List<Category> lowList(int mediumCtgryNo) throws Exception; //관리자 상품수정 페이지에서 사용
	public List<Category> lowCtgrySelect(int mediumCtgryNo) throws Exception; //관리자 상품관리 페이지에서 사용
	public List<List<Category>> CtgryAll() throws Exception; //모달창 카테고리
	public List<Category> lowCtgry1() throws Exception;
	public List<Category> lowCtgry2() throws Exception;
	public List<Category> smallCtgry() throws Exception;
}
