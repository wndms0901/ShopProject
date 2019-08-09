<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../css/admin.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="../js/ajax.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#menu1").click(function(){
		var value = $("#menu1Font").html();
		if(value=="+"){
			$("#menu1Font").html("-");
			$("#menu1Font").css("font-weight","bold");
			$(this).css("background-color","#f3f7f8");
			$(".left ul li ul").css("display","block");
			$(".left ul li ul").css("background-color","#f3f7f8");
		}
		if(value=="-"){
			$("#menu1Font").html("+");
			$("#menu1Font").css("font-weight","normal");
			$(this).css("background-color"," transparent");
			$(".left ul li ul").css("display","none");
		}
	});
});
</script>
</head>
<body>
	<header>
		<p id="logo">
			<a href="/admin/main.do"><img src="../images/home/logo2.png"></a>
		</p>
		<p id="logout">
			<a href="/member/logout.do">로그아웃</a>
		</p>
	</header>
	<section>
		<div class="left">
			<ul>
				<li class="product"><a id="menu1"><img src="../images/home/adminMenu1.png">상품관리 <font id="menu1Font">+</font></a>
					<ul style="display:none">
						<li class="list"><a href="/admin/product.do?mode=register">상품
								등록</a>
						<li class="list"><a href="/admin/product.do">상품
								목록</a>
					</ul></li>
				<li><a href="/admin/order.do"><img src="../images/home/adminMenu2.png">주문관리</a></li>
				<li><a href="/admin/member.do"><img src="../images/home/adminMenu3.png">회원관리</a></li>
				<li><a href="/admin/board.do"><img src="../images/home/adminMenu4.png">게시판관리</a></li>
			</ul>
		</div>