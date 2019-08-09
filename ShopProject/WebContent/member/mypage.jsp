<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script>
function AddComma(data_value) { //숫자 3자리 단위마다 ,추가하기
	return Number(data_value).toLocaleString('en');
	}	
</script>
<script type="text/javascript">
$(document).ready(function() {
	var used = 0;
	var use = 0;
	var total =0;
	<c:forEach var="m" items="${mileage}">
		var value = ${m.mileage};
		if(value>0){
			total+=value;
		}else{
			used+=value;
		}
	</c:forEach>
	use = total + used;
	if(used<0){
		used = -used;
	}
	$("#use").html(AddComma(use)+"원");
	$("#used").html(AddComma(used)+"원");
	
	var totalOrderAmount = '<c:out value="${myPage.totalOrderAmount}"/>'; //총주문금액
	var totalOrderCount = '<c:out value="${myPage.totalOrderCount}"/>'; //총주문횟수
	$("#totalOrderAmount").html(AddComma(totalOrderAmount)+"원");
	$("#totalOrderCount").html(AddComma(totalOrderCount)+"회");
	
	$(".mypage:eq(1)").click(function(){
		location.href="/member/mypage.do?go=order";
	});
	$(".mypage:eq(2)").click(function(){
		location.href="/member/mypage.do?go=mileage";
	});
	$(".mypage:eq(3)").click(function(){
		location.href="/member/mypage.do?go=info";
	});
});
</script>
<section id="form" style="margin-top: 60px; margin-bottom: 110px;">
	<h2 style="text-align: center; margin-bottom: 25px;">마이페이지</h2>
	<div class="container"
		style="border: 1px solid #ccc; margin-top: 40px;height:283px;padding:0">
		<div class="mypage" style="width:36%;border:0">
		<p style="margin:30px 0 10px">${mbName}님, 저희 쇼핑몰을 이용해 주셔서 감사합니다.</p>
		<table>
		<tr><td>사용가능 적립금</td><td id="use"></td></tr>
		<tr><td>사용된 적립금</td><td id="used"></td></tr>
		<tr><td>총주문</td><td><font id="totalOrderAmount"></font>&nbsp;(<font id="totalOrderCount"></font>)</td></tr>
		</table> 
		</div>
		<div class="mypage" style="width:21.3%">
		<h2>ORDER</h2>
		<p>주문내역 조회</p>
		<p style="margin:30px 0 20px"><img src="../images/home/orderCheck.png"></p>
		<p style="font-size:14px;margin:0">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.</p>
		</div>
		<div class="mypage" style="width:21.3%">
		<h2>MILEAGE</h2>
		<p>적립금 조회</p>
		<p style="margin:30px 0 20px"><img src="../images/home/mileage.png"></p>
		<p style="font-size:14px;margin:0">보유하고 계신 적립금의 구체적인 내역을 확인합니다.</p>
		</div>
		<div class="mypage" style="width:21.3%">
		<h2>PROFILE</h2>
		<p>회원 정보</p>
		<p style="margin:30px 0 20px"><img src="../images/home/profile.png"></p>
		<p style="font-size:14px;margin:0">고객님의 개인정보를 수정하고 관리할 수 있습니다.</p>
		</div>
	</div>
</section>
<%@include file="../includes/footer.jsp"%>