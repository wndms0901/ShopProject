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
<script src="../js/orderCmplt.js"></script>
<script>
$(document).ready(function() {
	var orderState = '<c:out value="${order.orderState}"/>';
	$("select[name='orderState']").val(orderState);
	
	var orderId = $("#orderId").html();
	var value = orderId.substring(0,1);
	if(value=="g"){ //비회원일때
		$(".mileage").each(function(index,item) {
			$(".mileage").html("-");
		});
	}else{ //회원일때
		var mileageUse = '<c:out value="${order.mileageUse}"/>';
		var mileageAdd = '<c:out value="${order.mileageAdd}"/>';
		var add1 = "<th rowspan='2' width='5%'><img src='../images/home/minus.png'></th><th width='20%'>적립금 사용</th>";
		var add2 ="<th class='mileageUse'>"+AddComma(mileageUse)+"원"+"</th>";
		var add3 ="<tr><td id='field'>적립금 사용</td><td class='mileageUse'>";
		add3+=AddComma(mileageUse)+"원"+"</td></tr><tr><td id='field'>적립금 지급</td><td class='mileageAdd'>";
		add3+=AddComma(mileageAdd)+"원"+"</td></tr>";
		$("#dlv").after(add1);
		$("#tot-tb-tr2 .dlv").after(add2);
		$(".order-tb:eq(1) tr:eq(2)").after(add3);
		$(".tot-div").css("width","60%");
	}
	
	$("#update-btn").click(function() { //변경버튼 클릭
		 var result = confirm("선택한 항목의 주문상태를 변경하시겠습니까?");
			if(result){
				document.updateForm.submit();
				alert("주문상태가 변경되었습니다.");
				 opener.location.reload();
			}
	});
});
</script>
</head>
<body style="min-width:1000px;max-width:1200px;background-color:#ECF0F7;padding:0px 30px 30px;margin:0">
		<h1 style="font-weight:500">주문 상세내역</h1>
		<div class="order-form">
				<h4 style="margin-top:0px">주문 정보</h4>
				<form name="updateForm" action="/admin/order.do" method="post"> 
				<input type="hidden" name="mode" value="update">
				<input type="hidden" name="read" value="page">
				<input type="hidden" name="orderId" value="${order.orderId}">
				<table class="order-tb">
							<tr>
								<td id="field">주문번호</td>
								<td id="orderId">${order.orderId}</td>
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
								<%-- <td>${order.orderState}</td> --%>
								<td><select name="orderState">
						<option value="">-- 선택 --</option>
						<option>입금대기</option>
							<option>결제완료</option>
							<option>상품준비중</option>
							<option>배송중</option>
							<option>배송완료</option></select>&nbsp;<button type="button" id="update-btn" type="button">변경</button>
							</tr>
						</table>
						</form>
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
						<div class="tot-div" style="width: 50%; float: right">
							<table class="tot-tb">
								<tr id="tot-tb-tr1">
									<th>총 ${order.productsCount}개의 상품금액
									</th>
									<th rowspan="2" width="5%"><img
										src="../images/home/plus.png"></th>
									<th id="dlv">배송비</th>
									<th rowspan="2" width="5%"><img
										src="../images/home/equal.png"></th>
									<th>합계</th>
								</tr>
								<tr id="tot-tb-tr2">
									<th class="hap">${order.productAmount}</th>
									<th class="dlv"></th>
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
				</div>
</body>
</html>