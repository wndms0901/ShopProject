<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script src="../js/orderCmplt.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$(".orderCmplt-Btn button").click(function(){
		var url = "/member/mypage.do?go=order";
		var page ='<c:out value="${cri.page}"/>';
		if(page){
			url+="&page="+page;
		}
		location.href=url;
	});
});
</script>
    <section id="form" style="margin-top: 40px; margin-bottom: 130px;">
	<div class="container" style="padding:0;">
	<h3 style="margin-bottom: 30px;width:260px">주문상세내역</h3>
	</div>
	<div class="container" style="padding:0;">
		<div class="row">
			<div class="col-sm-12">
				<div class="order-form">
				<h4 style="margin:10px 0 10px">주문 정보</h4>
				<table class="order-tb">
							<tr>
								<td id="field">주문번호</td>
								<td>${order.orderId}</td>
							</tr>
							<tr>
								<td id="field">주문일</td>
								<td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</tr>
							<tr>
								<td id="field">주문자명</td>
								<td>${order.buyerName}</td>
							</tr>
							<tr>
								<td id="field">주문상태</td>
								<td>${order.orderState}</td>
							</tr>
						</table>
				<h4>주문상품</h4>
						<table class="cart-tb">
							<tr>
								<th colspan="2">상품명</th>
								<th width="10%">판매가</th>
								<th width="10%">수량</th>
								<th width="10%">합계금액</th>
								<th width="10%">적립금</th>
							</tr>
							<c:forEach var="product" items="${products}">
								<tr>
									<th width="10%" style="padding-right:50px"><img src="../images/product/${product.pImage}"
										width="110px" height="110px"></th>
									<td width="50%">${product.pName }</td>
									<th class="price">${product.price}</th>
									<th class="pQuantity">${product.pQuantity}</th>
									<th class="tot">합계금액</th>
									<th class="mileage">-</th>
								</tr>
							</c:forEach>
						</table>
					<div class="tot-div" style="width: 60%; float: right;">
							<table class="tot-tb">
								<tr id="tot-tb-tr1">
									<th width="25%">총 ${order.productsCount}개의 상품금액
									</th>
									<th rowspan="2" width="5%"><img
										src="../images/home/plus.png"></th>
									<th width="20%">배송비</th><th rowspan="2" width="5%"><img
										src="../images/home/minus.png"></th>
									<th width="20%">적립금 사용</th>
									<th rowspan="2" width="5%"><img
										src="../images/home/equal.png"></th>
									<th width="25%">합계</th>
								</tr>
								<tr id="tot-tb-tr2">
									<th class="hap">${order.productAmount}</th>
									<th class="dlv"></th>
									<th class="mileageUse">${order.mileageUse}</th>
									<th class="totalHap">${order.finalAmount}</th>
								</tr>
							</table>
						</div>
						<br> <br> <br> <br> <br> 
						<h4>결제 정보</h4>
						<table class="order-tb">
							<tr>
								<td id="field">결제수단</td>
								<td>${order.payType}</td>
							</tr>
							<tr>
								<td id="field">상품 합계 금액</td>
								<td class="hap">${order.productAmount}</td>
							</tr>
							<tr>
								<td id="field">배송비</td>
								<td class="dlv"></td>
							</tr>
							<tr>
								<td id="field">적립금 사용</td>
								<td class="mileageUse">${order.mileageUse}</td>
							</tr>
							<tr>
								<td id="field">적립금 지급</td>
								<td class="mileageAdd">${order.mileageAdd}</td>
							</tr>
							<tr>
								<td id="field">최종 결제 금액</td>
								<td class="totalHap">${order.finalAmount}</td>
							</tr>
						</table>
						<h4>주문자 정보</h4>
						<table class="order-tb">
							<tr>
								<td id="field">주문자명</td>
								<td>${order.buyerName}</td>
							</tr>
							<tr>
								<td id="field">휴대폰번호</td>
								<td>${order.buyerPhone}</td>
							</tr>
							<tr>
								<td id="field">전화번호</td>
								<td>${order.buyerTel}</td>
							</tr>
							<tr>
								<td id="field">이메일</td>
								<td>${order.buyerEmail}</td>
							</tr>
						</table>
						<h4>수령자 정보</h4>
						<table class="order-tb">
							<tr>
								<td id="field">수령자명</td>
								<td>${order.recipientName}</td>
							</tr>
							
							<tr>
								<td id="field">배송지 주소</td>
								<td>(${order.recipientZip}) ${order.recipientAddr1} ${order.recipientAddr2}</td>
							</tr>
							<tr>
								<td id="field">휴대폰번호</td>
								<td>${order.recipientPhone}</td>
							</tr>
							<tr>
								<td id="field">전화번호</td>
								<td>${order.recipientTel}</td>
							</tr>
							<tr>
								<td id="field">배송 메시지</td>
								<td>${order.orderMessage}</td>
							</tr>
						</table>
						<div class="orderCmplt-Btn">
							<button>주문내역 목록</button>
						</div>
				</div>
			</div>
		</div>
	</div>
</section>
    <%@include file="../includes/footer.jsp"%>
