<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script src="../js/cart.js"></script>
<script type="text/javascript">
$(document).ready(function() {
var mbId = '<c:out value="${sessionScope.mbId}"/>';
if(mbId){ //로그인했을때
	$(".cart-tb-bottom").append("<p>장바구니에 담긴 상품은 최대 30일까지 보관되며 30일이 지나거나 품절될 경우 자동으로 삭제됩니다.</p>");
	$("#cartForm").attr("action","/order/orderMember.do");
}else{ //로그인x
	 $("form").attr("action","/order/cart.do");
 	 $("form").append("<input type='hidden' name='guest' value='cart'>");
}
});
</script>
<section id="form" style="margin-top: 40px; margin-bottom: 110px;">
	<!--form-->
	<div class="container" style="padding:0">
			<h2 style="margin-bottom:5px;display: inline-block;vertical-align:bottom;font-size:35px;width:260px">장바구니</h2>
			<p class="orderImg"><img src="../images/home/cart2.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/write1.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/order1.png"></p>
	</div>
	<div class="container"
		style="margin-top: 20px; padding:0">
		<div class="row" style="height: 400px;">
			<div class="col-sm-12">
				<!-- <form method="get" action="cartDlt.do"> -->
				<form id="cartForm" method="post">
					<table class="cart-tb">
						<tr>
							<th><input type="checkbox" id="checkAll" checked></th>
							<th colspan="2" width="50%">상품명</th>
							<th width="10%">판매가</th>
							<th width="10%">수량</th>
							<th width="10%">합계금액</th>
							<th width="10%">적립금</th>
						</tr>
						<c:forEach var="product" items="${products}">
							<input type="hidden" class="pStock" value="${product.pStock }">
							<tr>
								<th><input type="checkbox" name="pno" class="check"
									value="${product.pno}"></th>
								<th><img src="../images/product/${product.pImage}"
									width="110px" height="110px"></th>
								<td>${product.pName }</td>
								<th class="price">${product.price}</th>
								<th><input type="button" value="-" class="minus"> <input
									type="text" class="pQuantity" value="${product.pQuantity}"
									size="1" readOnly><input type="button" value="+" class="plus"></th>
								<th class="tot">합계금액</th>
								<th class="mileage">적립금</th>
							</tr>
						</c:forEach>
					</table>
					<div class="cart-tb-bottom">
					<button id="dlt-btn">선택 상품 삭제</button>
					</div>
					<div class="tot-div">
						<table class="tot-tb">
							<tr id="tot-tb-tr1">
								<th width="30%">총 <font id="count"></font>개의 상품금액
								</th>
								<th rowspan="2" width="5%"><img
									src="../images/home/plus.png"></th>
								<th width="30%">배송비</th>
								<th rowspan="2" width="5%"><img
									src="../images/home/equal.png"></th>
								<th width="30%">합계</th>
							</tr>
							<tr id="tot-tb-tr2">
								<th id="hap"></th>
								<th id="dlv">3000원</th>
								<th id="totalHap">0000원</th>
							</tr>
						</table>
					</div>
				<div class="order-Btn">
						<button id="orderSlct">선택 상품 주문</button>&nbsp;
						<button id="orderAll">전체 상품 주문</button>
					</div>
				</form>
			</div>
		</div>

	</div>
</section>
<!--/form-->

<%@include file="../includes/footer.jsp"%>
