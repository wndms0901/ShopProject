<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	var check ='<c:out value="${mbCheck}"/>';
	if(check){
		alert("등록되지 않은 아이디이거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.");
}
});
</script>
<section id="form" style="margin-top: 60px; margin-bottom: 110px;">
	<!--form-->
	<h2 style="text-align: center; margin-bottom: 25px;">회원 로그인</h2>
	<h4 style="text-align: center">환영합니다! 펫마트 회원으로 다양한 혜택을 받아 보세요.</h4>
	<div class="container"
		style="border: 1px solid #ccc; margin-top: 40px;">
		<div class="row" style="height: 400px;">
			<div class="col-sm-4"
				style="border-right: 1px solid #ccc; width: 33%">
				<div style="text-align: center;">
					<img src="../images/home/가입혜택.png" width="320px" height="400px">
				</div>
			</div>
			<div class="col-sm-4 col-sm-offset-1"
				style="border-right: 1px solid #ccc; margin-left: 0px; width: 33%">
				<!--login form-->
				<div class="login-form">
					<form action="/member/login.do" method="post">
						<h2 style="margin-bottom: 20px">로그인</h2>
						<table style="width: 100%">
							<tr>
								<td><input type="text" name="mbId" placeholder="아이디" /></td>
							</tr>
							<tr>
								<td><input type="password" name="mbPwd" placeholder="비밀번호" /></td>
							</tr>
							<tr>
								<td><button type="submit">로그인</button></td>
							</tr>
							<tr>
								<td><button type="button" style="background: #fff;"
										onclick="location.href='join.do'">회원가입</button></td>
							</tr>
						</table>
					</form>
				</div>
				<!--/login form-->
			</div>
			<!-- <div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div> -->
			<div class="col-sm-4" style="width: 33%">
				<div class="signup-form">
					<!--sign up form-->
					<div style="margin-bottom: 20px">
						<h2 style="margin-bottom: 20px">비회원 주문조회</h2>
						<p>주문자명과 주문번호를 잊으신 경우,</p>
						<p>고객센터로 문의하여 주시기 바랍니다.</p>
					</div>
					<form action="/order/orderCheck.do">
						<input type="text" name="buyerName" placeholder="주문자명" /> 
						<input type="text" name="orderId" placeholder="주문번호" /><br>
						<button type="submit" style="background: white;">비회원 주문조회</button>
					</form>
				</div>
				<!--/sign up form-->
			</div>
		</div>
	</div>
</section>
<!--/form-->

<%@include file="../includes/footer.jsp"%>
