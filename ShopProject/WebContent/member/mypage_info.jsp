<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../js/address.js"></script>
<script src="../js/mbInfo.js"></script>
<script>
$(document).ready(function(){
	// 휴대폰번호, 전화번호, 이메일, 주소, 생일 setting
	var mbPhone = '<c:out value="${mb.mbPhone}"/>';
	var mbTel = '<c:out value="${mb.mbTel}"/>';
	var mbEmail = '<c:out value="${mb.mbEmail}"/>';
	var mbBirth = '<c:out value="${mb.mbBirth}"/>';
	mbPhone = mbPhone.split('-');
	mbTel=mbTel.split('-');
	mbEmail = mbEmail.split('@');
	mbBirth = mbBirth.split('-');
	
	$("select[id='phone1']").val(mbPhone[0]);
	$("input[id='phone2']").val(mbPhone[1]);
	$("input[id='phone3']").val(mbPhone[2]);
	$("input[id='tel1']").val(mbTel[0]);
	$("input[id='tel2']").val(mbTel[1]);
	$("input[id='tel3']").val(mbTel[2]);
	$("input[id='email1']").val(mbEmail[0]);
	$("input[id='email2']").val(mbEmail[1]);
	$("input[id='birth1']").val(mbBirth[0]);
	$("select[id='birth2']").val(mbBirth[1]);
	$("input[id='birth3']").val(mbBirth[2]);
});
</script>
<section style="margin-bottom:60px">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="join-form">
					<div class="mypage-btn">
						<a href="/member/mypage.do?go=order">주문내역 조회</a><a
							href="/member/mypage.do?go=mileage">적립금 조회</a><a id="point"
							href="/member/mypage.do?go=info">회원 정보</a>
					</div>
					<h3>회원 정보</h3>
					<p style="text-align: right; color: red">* 표시는 반드시 입력하셔야 하는
						항목입니다.</p>
					<form name="info" action="/member/mypage.do" method="post">
					<input type="hidden" name="go" value="info">
						<input type="hidden" name="mbEmail" value=""> <input
							type="hidden" name="mbPhone" value=""> <input
							type="hidden" name="mbTel" value=""> <input type="hidden"
							name="mbBirth" value="">
						<table class="join-table">
							<tr>
								<td id="field"><font>*</font> 아이디</td>
								<td><input type="text" name="mbId" value="${mb.mbId}" readOnly
								style="border:0;outline:0"></td>
							</tr>
							<tr>
								<td id="field">&nbsp;&nbsp;신규 비밀번호</td>
								<td><input type="password" name="mbPwd" id="mbPwd"></td>
							</tr>
							<tr>
								<td id="field">&nbsp;&nbsp;신규 비밀번호 확인</td>
								<td><input type="password" id="pwdCheck">&nbsp;&nbsp;
									<font id="pwd-fail" style="vertical-align: middle;">비밀번호가
										일치하지 않습니다.</font></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 이름</td>
								<td><input type="text" name="mbName" value="${mb.mbName}" readOnly
								style="border:0;outline:0"></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 이메일</td>
								<td class="check"><input type="text" id="email1" size="10"> @ <input
									type="text" id="email2" size="10">&nbsp; <select
									id="email3">
										<option value="" selected>직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="daum.net">daum.net</option>
										<option value="nate.com">nate.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="icloud.com">icloud.com</option>
								</select></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 휴대폰번호</td>
								<td class="check"><select id="phone1">
										<option value="010" selected>010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
								</select> - <input type="text" id="phone2" size="4"> - <input
									type="text" id="phone3" size="4"></td>
							</tr>
							<tr>
								<td id="field">&nbsp;&nbsp;전화번호</td>
								<td><input type="text" id="tel1" size="4"> - <input
									type="text" id="tel2" size="4"> - <input type="text"
									id="tel3" size="4"></td>
							</tr>
							<tr>
								<td id="field">&nbsp;&nbsp;주소</td>
								<td><p>
										<input type="text" name="mbZip" id="zip" size="5" value="${mb.mbZip}">&nbsp;
										<button type="button" onClick="address()">우편번호검색</button>
									</p>
									<p>
										<input type="text" name="mbAddr1" id="addr1" size="40" value="${mb.mbAddr1}">
									</p> <input type="text" name="mbAddr2" id="addr2" size="40" value="${mb.mbAddr2}"></td>
							</tr>
							 <tr>
								<td id="field" style="border-bottom: 0">&nbsp;&nbsp;생일</td>
								<td style="border-bottom: 0"><input type="text" id="birth1"
									placeholder="년(4자)" size="8" maxlength="4"> &nbsp; <select
									id="birth2">
										<option value="">월</option>
										<option value="01">1</option>
										<option value="02">2</option>
										<option value="03">3</option>
										<option value="04">4</option>
										<option value="05">5</option>
										<option value="06">6</option>
										<option value="07">7</option>
										<option value="08">8</option>
										<option value="09">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
								</select>&nbsp; <input type="text" id="birth3" placeholder="일" size="8"
									maxlength="2"></td>
							</tr> 
						</table>
						<div class="join-button">
						<input id="cancel" type="button" value="취소">
						&nbsp;&nbsp;
						<input id="ok" type="button" value="회원정보수정">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>