<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	var check =${mbCheck};
	if(check==false){
		alert("등록되지 않은 아이디이거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.");
}
});
</script>
<section id="form" style="margin-top: 80px; margin-bottom: 110px;">
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
					<form action="/order/orderMember.do" method="post">
						<c:forEach var="p" items="${pno}">
							<input type="hidden" name="pno" value="${p}">
						</c:forEach>
						<c:forEach var="q" items="${pQuantity}">
							<input type="hidden" name="pQuantity" value="${q}">
						</c:forEach>
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
										onclick="location.href='/member/join.do'">회원가입</button></td>
							</tr>
						</table>
					</form>
				</div>
				<!--/login form-->
			</div>
			<div class="col-sm-4" style="width: 33%">
				<div class="signup-form">
				<form action="/order/orderGuest.do" method="post">
				<c:forEach var="p" items="${pno}">
					<input type="hidden" name="pno" value="${p}">
				</c:forEach>
				<c:forEach var="q" items="${pQuantity}">
					<input type="hidden" name="pQuantity" value="${q}">
				</c:forEach>
					<!-- <input type="hidden" name="guest" value="order"> -->
					<div style="margin-bottom: 20px">
						<h2 style="margin-bottom: 20px">비회원 구매</h2>
						<p>펫마트에서는 비회원도 구매가 가능합니다.</p>
						<p>단, 비회원 주문시 펫마트에서 제공하는 다양한 혜택에서 </p>
						<p>제외될 수 있습니다.</p>
					</div>
					<input type="submit" id="guestPrchs" value="비회원 구매하기">
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<!--/form-->

<%@include file="../includes/footer.jsp"%>
