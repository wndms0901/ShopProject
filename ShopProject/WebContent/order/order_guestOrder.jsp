<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../js/address.js"></script>
<script src="../js/order.js"></script>
<script>
$(document).ready(function() {
$(".mileage").each(function(index,item) {
	$(".mileage").html("-");
});
});
</script>
<section id="form" style="margin-top: 40px; margin-bottom: 130px;">
	<div class="container" style="padding:0;">
		<h2
			style="margin-bottom: 5px; display: inline-block; vertical-align: bottom; font-size: 35px;width:260px">주문서작성/결제</h2>
		<p class="orderImg">
			<img src="../images/home/cart1.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/write2.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/order1.png">
		</p>
	</div>
	<div class="container" style="padding:0;margin-top:20px;">
		<div class="row">
			<div class="col-sm-12">
				<div class="order-form">
					<form action="/order/orderGuest.do" method="post">
						<input type="hidden" name="productsCount"> <input
							type="hidden" name="buyerPhone"> <input type="hidden"
							name="buyerTel"> <input type="hidden" name="buyerEmail">
						<input type="hidden" name="recipientPhone"> <input
							type="hidden" name="recipientTel"> <input type="hidden"
							name="productAmount"> <input type="hidden"
							name="finalAmount">
						<table class="cart-tb">
							<tr>
								<th colspan="2">상품명</th>
								<th width="10%">판매가</th>
								<th width="10%">수량</th>
								<th width="10%">합계금액</th>
								<th width="10%">적립금</th>
							</tr>
							<c:forEach var="product" items="${products}">
								<input type="hidden" name="pno" value="${product.pno}">
								<tr>
									<th width="10%" style="padding-right:50px"><img src="../images/product/${product.pImage}"
										width="110px" height="110px"></th>
									<td width="50%">${product.pName }</td>
									<th class="price">${product.price}</th>
									<th><input type="text" name="pQuantity"
										value="${product.pQuantity}" size="1" readonly></th>
									<th class="tot">합계금액</th>
									<th class="mileage">-</th>
								</tr>
							</c:forEach>
						</table>
						<div class="tot-div" style="width: 50%; float: right">
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
									<th class="hap"></th>
									<th class="dlv">3000원</th>
									<th class="totalHap">0000원</th>
								</tr>
							</table>
						</div>
						<br> <br> <br> <br> <br> <br> <br>
						<h4 style="width: 75%; display: inline-block">주문자 정보</h4>
						<font style="color: red">* 표시는 반드시 입력하셔야 하는 항목입니다.</font>
						<table class="order-tb">
							<tr>
								<td id="field"><font>*</font> 주문하시는 분</td>
								<td class="check"><input type="text" name="buyerName"
									size="42"></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 휴대폰 번호</td>
								<td class="check"><select id="bPhone1">
										<option value="010" selected>010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
								</select> - <input type="text" id="bPhone2" size="8" maxlength="4">
									- <input type="text" id="bPhone3" size="8" maxlength="4"></td>
							</tr>
							<tr>
								<td id="field">전화번호</td>
								<td><input type="text" id="bTel1" size="9" maxlength="4">
									- <input type="text" id="bTel2" size="8" maxlength="4">
									- <input type="text" id="bTel3" size="8" maxlength="4"></td>
							</tr>

							<tr>
								<td id="field"><font>*</font> 이메일</td>
								<td class="check"><input type="text" id="email1" size="10">
									@ <input type="text" id="email2" size="10">&nbsp; <select
									id="email3" style="width: 115px">
										<option value="" selected>직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="daum.net">daum.net</option>
										<option value="nate.com">nate.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="icloud.com">icloud.com</option>
								</select></td>
							</tr>
						</table>
						<h4>배송정보</h4>
						<table class="order-tb">
							<tr>
								<td id="field">배송지 확인</td>
								<td><input type="radio" name="input" value="direct">&nbsp;직접
									입력 &nbsp;&nbsp;<input type="radio" name="input" value="same">&nbsp;주문자
									정보와 동일</td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 받으실분</td>
								<td class="check"><input type="text" name="recipientName"
									size="42"></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 받으실곳</td>
								<td class="check"><p>
										<input type="text" name="recipientZip" id="zip" size="6">&nbsp;
										<button type="button" onClick="address()">우편번호검색</button>
									</p>
									<p>
										<input type="text" name="recipientAddr1" id="addr1" size="50">
									</p> <input type="text" name="recipientAddr2" id="addr2" size="50"></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 휴대폰 번호</td>
								<td class="check"><select id="rPhone1">
										<option value="010" selected>010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
								</select> - <input type="text" id="rPhone2" size="8" maxlength="4">
									- <input type="text" id="rPhone3" size="8" maxlength="4"></td>
							</tr>
							<tr>
								<td id="field">전화번호</td>
								<td><input type="text" id="rTel1" size="9" maxlength="4">
									- <input type="text" id="rTel2" size="8" maxlength="4">
									- <input type="text" id="rTel3" size="8" maxlength="4"></td>
							</tr>
							<tr>
								<td id="field">남기실 말씀</td>
								<td><input type="text" name="orderMessage" size="110"></td>
							</tr>
						</table>
						<h4>결제정보</h4>
						<table class="order-tb">
							<tr>
								<td id="field">상품 합계 금액</td>
								<td class="hap"></td>
							</tr>
							<tr>
								<td id="field">배송비</td>
								<td class="dlv"></td>
							</tr>
							<tr>
								<td id="field">최종 결제 금액</td>
								<td class="totalHap"></td>
							</tr>
						</table>
						<h4>결제수단 선택 / 결제</h4>
						<table class="order-tb">
							<tr>
								<td id="field">결제수단</td>
								<td><input type="radio" name="payType" value="실시간 계좌이체">
									실시간 계좌이체</td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 계좌 이체 은행</td>
								<td id="checkBank"><select name="bankName">
										<option value="" selected>은행선택</option>
										<option value="경남은행">경남은행</option>
										<option value="국민은행">국민은행</option>
										<option value="기업은행">기업은행</option>
										<option value="농협중앙회">농협중앙회</option>
										<option value="대구은행">대구은행</option>
										<option value="부산은행">부산은행</option>
										<option value="신한은행">신한은행</option>
										<option value="외환은행">외환은행</option>
										<option value="우리은행">우리은행</option>
										<option value="우체국">우체국</option>
										<option value="전북은행">전북은행</option>
										<option value="SC제일은행">SC제일은행</option>
										<option value="제주은행">제주은행</option>
										<option value="하나은행">하나은행</option>
								</select></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 계좌 번호</td>
								<td class="check"><input type="text" name="accountNumber"
									size="42">&nbsp; <font
									style="font-size: 16px; color: #323232">( '-' 생략 )</font></td>
							</tr>
							<tr>
								<td id="field"><font>*</font> 입금자명</td>
								<td class="check"><input type="text" name="depositName"
									size="42"></td>
							</tr>
						</table>
						<h4 style="margin-top: 15px; text-align: right;">
							최종 결제 금액&nbsp;&nbsp;&nbsp;<font class="totalHap"
								style="font-size: 27px; font-weight: bold;"></font>
						</h4>
						<p
							style="text-align: center; padding: 30px 0 30px; font-size: 16px">
							<input type="checkbox" id="agree"> 구매하실 상품의 결제정보를 확인하였으며, 구매진행에
							동의합니다.
						</p>
						<p style="text-align: center;">
							<input type="submit" id="pay-btn" value="결제하기">
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<%@include file="../includes/footer.jsp"%>