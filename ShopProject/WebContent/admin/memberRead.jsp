<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="../css/admin.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	$("th").css("background-color","#ECF0F7");
	});
</script>
</head>
<body
	style="min-width: 800px; max-width: 920px; background-color: #ECF0F7">
	<div class="product-update">
		<h1 style="font-weight:500">회원 정보</h1>
		<div style="padding:40px 0px;background-color:#fff">
		<table style="margin:0 auto">
			<tr>
				<th width="20%">아이디</th>
				<td colspan="3">${member.mbId}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td colspan="3">${member.mbName}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3">${member.mbEmail}</td>
			</tr>
			<tr>
				<th>휴대폰번호</th>
				<td colspan="3">${member.mbPhone}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td colspan="3">${member.mbTel}</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td colspan="3">${member.mbZip}</td>
			</tr>
			<tr>
				<th>기본주소</th>
				<td>${member.mbAddr1}</td>
				<th width="20%">상세주소</th>
				<td>${member.mbAddr2}</td>
			</tr>
			<tr>
				<th>생일</th>
				<td colspan="3">${member.mbBirth}</td>
			</tr>
			<tr>
				<th>적립금</th>
				<td colspan="3">${member.mbMileage}</td>
			</tr>
			<tr>
				<th>최근 로그인</th>
				<td colspan="3"><fmt:formatDate value="${member.mbLoginTime}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td colspan="3"><fmt:formatDate value="${member.mbRegisterDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<th>메모</th>
				<td colspan="3">${member.mbMemo}</td>
			</tr>
		</table>
		</div>
	</div>
</body>
</html>