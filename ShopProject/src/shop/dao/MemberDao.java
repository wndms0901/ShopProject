package shop.dao;

import java.util.HashMap;
import java.util.List;

import shop.vo.Cart;
import shop.vo.Member;
import shop.vo.Mileage;
import shop.vo.MyPage;

public interface MemberDao {
	public int mbAdd(Member member) throws Exception;

	public Member mbRead(String mbId) throws Exception;

	public int mbUpdate(Member member) throws Exception;

	public int mbIdCheck(String mbId) throws Exception;

	public int mbCheck(HashMap<String, Object> paramMap) throws Exception;

	public int mbLogin(String mbId) throws Exception;

	public Member mbOrder(String mbId) throws Exception;

	public int cartmAdd(HashMap<String, Object> paramMap) throws Exception;

	public int cartpAdd(String mbId) throws Exception;

	public List<Cart> cartRead(String mbId) throws Exception;

	public int cartChg(HashMap<String, Object> paramMap) throws Exception;

	public int cartQuantity(HashMap<String, Object> paramMap) throws Exception;

	public int cartDlt(HashMap<String, Object> paramMap) throws Exception;

	public int cartCheck(String mbId) throws Exception;

	public List<Mileage> mbMileage(String mbId) throws Exception;
	
	public List<Mileage> mbMileageList(HashMap<String, Object> paramMap) throws Exception;
	
	public int mbMileageCount(String mbId) throws Exception;

	public int mileageAdd(Mileage mileage) throws Exception;

	public int mileageUpdate(HashMap<String, Object> paramMap) throws Exception;

	public List<MyPage> mypageOrder(HashMap<String, Object> paramMap) throws Exception;

	public MyPage totalOrder(String mbId) throws Exception;

	public int todayJoin() throws Exception;

	public int monthJoin() throws Exception;

	public List<Member> memberList(HashMap<String, Object> paramMap) throws Exception;
	
	public int memberListCount(HashMap<String, Object> paramMap) throws Exception;

	public int mbMemoUpdate(HashMap<String, Object> paramMap) throws Exception;

	public int mbDelete(String mbId) throws Exception;
}
