<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("input[type='submit']").click(function(){
		var mbId = $("input[name='mbId']").val();
		var mbPwd = $("input[name='mbPwd']").val();
		var params = "?mbId="+mbId+"&mbPwd="+mbPwd;
		var result= productService.mbCheck(params);
		if(result==0){
			alert("비밀번호가 일치하지 않습니다.");
			$("input[name='mbPwd']").val("");
			$("input[name='mbPwd']").focus();
			return false;			
		}
	});
	
});
</script>

<section>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="mypage-btn">
					<a href="/member/mypage.do?go=order">주문내역 조회</a><a
						href="/member/mypage.do?go=mileage">적립금 조회</a><a id="point"
						href="/member/mypage.do?go=info">회원 정보</a>
				</div>
				<div class="pwdCheck">
				<h4>비밀번호 확인</h4>
				<p>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 확인합니다.</p>
				<form action="/member/mypage.do" method="post">
				<input type="hidden" name="mbId" value="${sessionScope.mbId}">
				<input type="hidden" name="go" value="info">
				<font>비밀번호 확인</font><input type="password" name="mbPwd"><input type="submit" value="확인">
				</form>
				</div>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>