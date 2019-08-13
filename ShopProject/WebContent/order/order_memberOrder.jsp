<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../js/address.js"></script>
<script type="text/javascript">
function loginCheck(){
	var mbId= '<c:out value="${sessionScope.mbId}"/>';
	 return mbId;
}
</script>
<script src="../js/order.js"></script>
<script type="text/javascript">
$(document).ready(function() { 
	//주문자 휴대폰번호, 전화번호, 이메일 값 setting
	var mbPhone = '<c:out value="${member.mbPhone}"/>';
	var mbTel = '<c:out value="${member.mbTel}"/>';
	var mbEmail = '<c:out value="${member.mbEmail}"/>';
	mbPhone = mbPhone.split('-');
	mbTel=mbTel.split('-');
	mbEmail = mbEmail.split('@');
	$("select[id='bPhone1']").val(mbPhone[0]);
	$("input[id='bPhone2']").val(mbPhone[1]);
	$("input[id='bPhone3']").val(mbPhone[2]);
	$("input[id='bTel1']").val(mbTel[0]);
	$("input[id='bTel2']").val(mbTel[1]);
	$("input[id='bTel3']").val(mbTel[2]);
	$("input[id='email1']").val(mbEmail[0]);
	$("input[id='email2']").val(mbEmail[1]);
	//총 사용가능 적립금 setting
	var mbMileage = '<c:out value="${member.mbMileage}"/>';
	mbMileage = Number(mbMileage);
	if(mbMileage == 0){ //적립금이 0이면 적립금사용x
		$("input[name='mileageUse']").attr("disabled",true); 
	}
	$("#mileage").html(AddComma(mbMileage));
	//전체 상품 합계가 2만원 이상일때 적립금사용가능
	var hap = $(".hap").html();
	hap = removeCommas(hap); //콤마제거
	hap = hap.substr(0,hap.length-1); //"원"제거
	hap = Number(hap);
	if(hap<20000){ //전체상품합계가 2만원 미만일때 적립금사용x
		$("input[name='mileageUse']").attr("disabled",true); 
	}
	//추가되는 적립금
	var mileageAdd = 0;
	$(".mileage").each(function(index,item) {
		var value= $(this).html();
		value=value.substr(0,value.length-1); //원 제거
		mileageAdd += Number(value);
		//var quantity = $("input[name='pQuantity']:eq("+index+")").val(); 
		//value = removeCommas(value); //콤마제거
		//value = value.substr(0,value.length-1); //"원"제거
		//mileageAdd+= Number(value) * Number(quantity);
	});
	$("input[name='mileageAdd']").attr("value",mileageAdd);
	
	    var totalHap = $(".totalHap").html(); //최종 결제 금액
	    totalHap = removeCommas(totalHap); //콤마 제거
		totalHap = totalHap.substr(0,totalHap.length-1); //"원"제거
		totalHap = Number(totalHap);
	// 적립금 숫자만 입력가능 , 콤마추가
	$("input[name='mileageUse']").on("focus", function() { 
	    var x = $(this).val();
		if(Number(x)==0){ // 포커스 됐을때 0제거 또는 값이 ""일때 처음값으로 출력
			$(this).val("");
			$("#mileage").html(AddComma(mbMileage));
			$(".totalHap").html(AddComma(totalHap)+"원");
		}else{
	    x = removeCommas(x);
	    $(this).val(x);
		}
	}).on("keyup", function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"")); //숫자만 입력가능
		var mbMileage = '<c:out value="${member.mbMileage}"/>'; //총적립금
		var x = $(this).val();
		
	 if(x && x.length > 0) { /*사용적립금 입력했을때*/
	     var amount = totalHap-x; //최종결제금액-사용적립금
	     var value = mbMileage-x; //총적립금 - 사용적립금
		 if(amount>=0){ //최종결제>=사용적립
			 if(value>=0){ //총적립>=사용적립
				 $(".totalHap").html(AddComma(amount)+"원");
				 $(".mileageUse").html(AddComma(x)+"원");
			 }else if(value<0){ //총적립<사용적립
				 alert("보유 적립금 이상 사용은 불가능 합니다.");
			 	 $(this).val(mbMileage);
				 $(".mileageUse").html(AddComma(mbMileage)+"원");
				 $(".totalHap").html(AddComma(totalHap-mbMileage)+"원");
			 }
		 }else{ //최종결제<사용적립
			 if(value>=0){ //총적립>=사용적립 ex)총결제 25000원일때 적립금 3만원사용
				 $(this).val(totalHap);
				 $(".mileageUse").html(AddComma(totalHap)+"원");
				 $(".totalHap").html(0+"원");
			 }else if(value<0){ //총적립<사용적립
				 alert("보유 적립금 이상 사용은 불가능 합니다.");
			 	if(mbMileage>=totalHap){ //총적립금>=최종결제
				 $(this).val(totalHap);
				 $(".mileageUse").html(AddComma(totalHap)+"원");
				 $(".totalHap").html(0+"원");
			 	}else if(mbMileage<totalHap){ //총적립금<최종결제
			 	 $(this).val(mbMileage);	
				 $(".mileageUse").html(AddComma(mbMileage)+"원");
				 $(".totalHap").html(AddComma(totalHap-mbMileage)+"원");
			 	}
			 }
		 }
	   } else if(x.length==0){  //입력한 내용을 전부 삭제했을때
		        $("#mileage").html(AddComma(mbMileage));
	 			$(".mileageUse").html(0+"원")
		 		$(".totalHap").html(AddComma(totalHap)+"원");
	 }
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x.length == 0){
	    	$(this).val(0);
	    }else if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        x = addCommas(x); //콤마추가
	        $(this).val(x);
	        $(".mileageUse").html(x+"원");
	    }
	});
	
});
</script>

<section id="form" style="margin-top: 40px; margin-bottom: 130px;">
	<div class="container" style="padding: 0;">
		<h2
			style="margin-bottom: 5px; display: inline-block; vertical-align: bottom; font-size: 35px; width: 260px">주문서작성/결제</h2>
		<p class="orderImg">
			<img src="../images/home/cart1.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/write2.png"><img
				src="../images/home/arrow.png"><img
				src="../images/home/order1.png">
		</p>
	</div>
	<div class="container" style="padding: 0; margin-top: 20px;">
		<div class="row">
			<div class="col-sm-12">
				<div class="order-form">
					<form name="orderForm" action="/order/orderMember.do" method="post">
						<input type="hidden" name="productsCount"> <input
							type="hidden" name="buyerPhone"> <input type="hidden"
							name="buyerTel"> <input type="hidden" name="buyerEmail">
						<input type="hidden" name="recipientPhone"> <input
							type="hidden" name="recipientTel"> <input type="hidden"
							name="productAmount"> <input type="hidden"
							name="finalAmount">
							<input type="hidden" name="mileageAdd">
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
								<input type="hidden" class="pStock" value="${product.pStock}">
								<tr>
									<th width="10%" style="padding-right:50px"><img src="../images/product/${product.pImage}"
										width="110px" height="110px"></th>
									<td class="pName" width="50%">${product.pName }</td>
									<th class="price">${product.price}</th>
									<th><input type="text" name="pQuantity"
										value="${product.pQuantity}" size="1" readonly></th>
									<th class="tot">합계금액</th>
									<th class="mileage">적립금</th>
								</tr>
							</c:forEach>
						</table>
						<div class="tot-div" style="width: 60%; float: right;">
							<table class="tot-tb">
								<tr id="tot-tb-tr1">
									<th width="25%">총 <font id="count"></font>개의 상품금액
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
									<th class="hap"></th>
									<th class="dlv"></th>
									<th class="mileageUse">0원</th>
									<th class="totalHap"></th>
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
									value="${member.mbName}" size="42"></td>
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
								<td id="field">적립금 사용</td>
								<td><input type="text" name="mileageUse" value="0" size="8">&nbsp;원 (총
									사용가능 적립금 : <font id="mileage"></font>원)</td>
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
							<input type="checkbox" id="agree"> 구매하실 상품의 결제정보를 확인하였으며,
							구매진행에 동의합니다.
						</p>
						<p style="text-align: center;">
							<input type="button" id="pay-btn" value="결제하기">
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<%@include file="../includes/footer.jsp"%>