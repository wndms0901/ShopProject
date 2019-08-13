function AddComma(data_value) { //숫자 3자리 단위마다 ,추가하기
		return Number(data_value).toLocaleString('en');
	}
function addCommas(x) { //3자리 단위마다 콤마 생성
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeCommas(x) { //모든 콤마 제거
    if(!x || x.length == 0) return "";
    else return x.split(",").join("");
}

$(document).ready(function() {
		var length = $(".price").length; //상품개수
		var hap =0; //전체 상품 합계
		$("#count").html(length);
		$("input:radio[name='input'][value='direct']").prop('checked', true);
		$("input:radio[name='payType'][value='실시간 계좌이체']").prop('checked', true);
		$(".price").each(function(index,item) {
			var dlv =0; /* 배송비 */
			var price = $(".price:eq("+index+")").html();
			var mileage =Math.floor(Number(price)/100);
			var pQuantity =$("input[name='pQuantity']:eq("+index+")").val();
			var tot = Number(price)*Number(pQuantity);
			hap+=tot;
			if(hap <30000){
				dlv=3000;
			}
			$(".price:eq("+index+")").html(AddComma(price)+"원"); //상품가격
			$(".mileage:eq("+index+")").html( AddComma(Number(pQuantity)*mileage)+"원"); //적립금
			$(".tot:eq("+index+")").html( AddComma(tot)+"원"); //합계금액
			$(".hap").html( AddComma(hap)+"원"); //전체 상품 합계
			$(".dlv").html( AddComma(dlv)+"원"); //전체 상품 합계
			$(".totalHap").html( AddComma(hap+dlv)+"원"); //전체상품+배송비 총합계
		});
		
		
		$("#email3").click(function() { //이메일 주소 선택
			var value = $("#email3").val();
			$("#email2").val(value);
		});
		$("input[name='input']").change(function(){
			var value= $("input:radio[name='input']:checked").val();
			if(value=="same"){ //주문자 정보와 동일
				var name = $("input[name='buyerName']").val();
				var phone1 = $("select[id='bPhone1']").val();
				var phone2 = $("input[id='bPhone2']").val();
				var phone3 = $("input[id='bPhone3']").val();
				var tel1 = $("input[id='bTel1']").val();
				var tel2 = $("input[id='bTel2']").val();
				var tel3 = $("input[id='bTel3']").val();
				$("input[name='recipientName']").val(name);
				$("select[id='rPhone1']").val(phone1);
				$("input[id='rPhone2']").val(phone2);
				$("input[id='rPhone3']").val(phone3);
				$("input[id='rTel1']").val(tel1);
				$("input[id='rTel2']").val(tel2);
				$("input[id='rTel3']").val(tel3);
			}else{ //직접입력
				$("input[name='recipientName']").val("");
				$("select[id='rPhone1']").val("010");
				$("input[id='rPhone2']").val("");
				$("input[id='rPhone3']").val("");
				$("input[id='rTel1']").val("");
				$("input[id='rTel2']").val("");
				$("input[id='rTel3']").val("");
			}
		});
		
		$(".check").each(function(index,item) { //필수항목이 비어있을 때
			$(".check:eq("+index+")").focusout(function(){
			var count =0;
			var length= $(".check:eq("+index+") input[type='text']").length; //td의 input개수
			$(".check:eq("+index+") input[type='text']").each(function(i,item) {
			var value=$(".check:eq("+index+") input[type='text']:eq("+i+")").val(); //td의 input value
			if(value!=""){
				count++;
			}
			});
			if(count!=length){ //필수항목이 비어있으면 경고문구 추가
				$(".check:eq("+index+")").append("<p class='warning' style='margin:10px 0 0 0;color:red'>필수 정보입니다.</p>");
			}
			});
			
			$(".check:eq("+index+")").focusin(function(){ //경고문구 제거
				$(".check:eq("+index+") input[type='text']").each(function(i,item) {
					$(".check:eq("+index+") p:last-child").remove();
			});
			});
		});	
		
		$("#checkBank").focusout(function(){ //계좌이체은행을 선택하지 않았을때
			var value = $("select[name='bankName']").val();
			if(value==""){
				$("#checkBank").append("<p class='warning' style='margin:10px 0 0 0;color:red'>필수 정보입니다.</p>");
			}
		});
		$("#checkBank").focusin(function(){ //경고문구 제거
			$("#checkBank p:last-child").remove();
		});
		$("#pay-btn").click(function(){ //결제하기 버튼
			
			$("td").each(function(index,item) {
				$("td:eq("+index+") p:last-child").remove();
				$("td:eq("+index+")").focus();
				$("td:eq("+index+")").blur();
			});
			var warning =$(".warning").length;
			if(warning!=0){ //입력하지 않은 필수항목이 있을때
				alert("필수 정보를 입력해주세요.");
				return false;
			}
			 var agree= $("input[id='agree']").is(':checked');
			 if(!agree){ //구매진행 동의 체크 안했을때
				 alert("구매진행에 동의가 필요합니다.");
				 return false;
			 }
			 var mbId = loginCheck();
			 var stockCheck= false;
			 $("input[name='pno']").each(function(index,item) {
				var pno = $("input[name='pno']:eq("+index+")").val();
				var pQuantity = $("input[name='pQuantity']:eq("+index+")").val();
				var pName = $(".pName:eq("+index+")").html();
			    var params = "?pno="+pno+"&pQuantity="+pQuantity;
				var result= productService.pStockCheck(params);
				if(result==1){ //상품 재고가 없을때
					alert(pName+" 상품이 품절되었습니다. 다시 주문해주세요.");
					stockCheck= true;
				}
				else if(result==2){ //상품재고<주문수량일때
					var param = "?pno="+pno;
					 var pStock = productService.pStock(param);
					alert(pName+" 상품의 최대 주문수량은 "+pStock+"개 입니다. 다시 주문해주세요.");
					stockCheck= true;
				}
			 });
			 if(stockCheck){ //품절된 상품이 존재할때
				 if(mbId){ //로그인 했을때
					 history.go(-1);
					 window.location = document.referrer;
				 }else{
					 history.go(-2);
				 }
				 return false;
			 }
			 
				 var buyerPhone = $("select[id='bPhone1']").val() +"-"+$("input[id='bPhone2']").val() +"-"+$("input[id='bPhone3']").val();
					var buyerTel = $("input[id='bTel1']").val() +"-"+$("input[id='bTel2']").val() +"-"+$("input[id='bTel3']").val();
					var buyerEmail = $("input[id='email1']").val() +"@"+$("input[id='email2']").val();
					var recipientPhone = $("select[id='rPhone1']").val() +"-"+$("input[id='rPhone2']").val() +"-"+$("input[id='rPhone3']").val();
					var recipientTel = $("input[id='rTel1']").val() +"-"+$("input[id='rTel2']").val() +"-"+$("input[id='rTel3']").val();
					var productAmount = $(".hap").html();
					productAmount=productAmount.substr(0,productAmount.length-1); //원 제거
					productAmount =Number(productAmount.replace(/,/g,"")); //콤마 제거
					var finalAmount =$(".totalHap").html();
					finalAmount=finalAmount.substr(0,finalAmount.length-1); //원 제거
					finalAmount =Number(finalAmount.replace(/,/g,"")); //, 제거
					if(buyerTel=="--"){
						buyerTel = "";
					}
					if(recipientTel=="--"){
						recipientTel = "";
					}
					$("input[name='productsCount']").attr("value",length);
					$("input[name='buyerPhone']").attr("value",buyerPhone);
					$("input[name='buyerTel']").attr("value",buyerTel);
					$("input[name='buyerEmail']").attr("value",buyerEmail);
					$("input[name='recipientPhone']").attr("value",recipientPhone);
					$("input[name='recipientTel']").attr("value",recipientTel);
					$("input[name='productAmount']").attr("value",productAmount);
					$("input[name='finalAmount']").attr("value",finalAmount); 
					
					//적립금 사용 했을때
					 var mileageUse =$("input[name='mileageUse']").val(); 
					 	if(mileageUse != undefined){
					 		mileageUse = mileageUse.replace(/,/g,"");
					 	}	
					 $("input[name='mileageUse']").val(Number(mileageUse));
					 document.orderForm.submit();
		});
});