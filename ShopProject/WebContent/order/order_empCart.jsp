<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<section id="form" style="margin-top: 40px; margin-bottom: 20px;">
	<div class="container" style="padding:0">
			<h2 style="margin-bottom:5px;display: inline-block;vertical-align:bottom;font-size:35px;width:260px">장바구니</h2>
			<p class="orderImg"><img src="../images/home/cart2.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/write1.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/order1.png"></p>
	</div>
</section>
<div class="col-sm-12"
	style="height: 500px; background-color: #f7f7f7; border-top: 1px solid #D6D6D6; border-bottom: 1px solid #D6D6D6; display: table;">
	<div class="empty">
		<p>
			<img src="../images/home/empty.png">
		</p>
		<p>장바구니에 담긴 상품이 없습니다.</p>
		<p style="margin-top: 50px;">
			<a href="/main/list.do">홈으로 가기</a>
		</p>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>
