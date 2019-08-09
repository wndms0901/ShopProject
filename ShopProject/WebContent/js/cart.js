function AddComma(data_value) { //숫자 3자리 단위마다 ,추가하기
	return Number(data_value).toLocaleString('en');
	}	

$(document).ready(function() {
		var length = $("input[class='check']").length; //상품개수
	    var hap =0; //전체 상품 합계
				
			$("input[class='check']").each(function(index,item) {/* 처음화면에서 전체상품 선택 */
			    $(this).prop('checked', true);
				var dlv =0; /* 배송비 */
			    var price= $(".price:eq("+index+")").html(); /* 가격 */
			    var mileage =price/100; //적립금
			    mileage =Math.floor(mileage); //적립금 
			    var quantity = $("input[class='pQuantity']:eq("+index+")").val();  /* 수량 */
			    var tot = price * quantity; /* 합계금액 */
			    	hap+=tot;
			      if(hap<30000){
			    	  dlv=3000;
			      }
			    $(".price:eq("+index+")").html(AddComma(price)+"원"); /* 상품가격 */
			    $(".mileage:eq("+index+")").html(AddComma(quantity*mileage)+"원"); /* 적립금 */
			    $(".tot:eq("+index+")").html(AddComma(tot)+"원"); /* 상품가격*개수 */
			      $("#hap").html(AddComma(hap)+"원"); /* 전체상품 총합계 */
			      $("#dlv").html(AddComma(dlv)+"원"); /* 배송비 */
			      $("#totalHap").html(AddComma(hap+dlv)+"원"); /* 전체상품+배송비 총합계 */
			      $("#count").html(length); /* 상품 개수 출력 */
			      
			
			$(".plus:eq("+index+")").on('click',function(event) { /* +버튼 */
				var plusHap =0; /* 선택된 상품들 합계금액 */
				var count =0; /* 선택된 상품개수 */
				var dlv = 3000; /* 배송비 */
				var stock=$("input[class='pStock']:eq("+index+")").val();
				quantity =Number(quantity); /* 숫자타입으로 변환 */
				stock =Number(stock); /* 숫자타입으로 변환 */
				if(quantity < stock){
					quantity++;
					var mlg = AddComma(quantity*mileage);
					var total = AddComma(quantity*price);
					$("input[class='pQuantity']:eq("+index+")").val(quantity);
					 $(".mileage:eq("+index+")").html(mlg+"원");
					 $(".tot:eq("+index+")").html(total+"원");
				}
				/* 변경된 수량 저장 */
				 var pno=$("input[name='pno']:eq("+index+")").val();
				var params ="?pno="+pno+"&pQuantity="+quantity;
				productService.chgCart(params);
				
				// $("input[class='check']:eq("+index+")").prop(!$("input[class='check']:eq("+index+")").prop('checked'),'checked' ); 
				 for(var i =0 ; i<length;i++){ /* 선택된 상품만 전체합계 출력 */
				 var check= $("input[class='check']:eq("+i+")").is(':checked');
				 if(check){
					 var tot = $(".tot:eq("+i+")").html();
					 tot=tot.substr(0,tot.length-1);
					 tot =Number(tot.replace(/,/g,""));
					 plusHap+=tot;
					 count++;
				 }
				 }
				 if(plusHap>=30000){
					 dlv=0;
				 }
				 $("#hap").html(AddComma(plusHap)+"원"); /* 전체상품 총합계 */
				 $("#dlv").html(AddComma(dlv)+"원"); /* 배송비 */
				 $("#totalHap").html(AddComma(plusHap+dlv)+"원"); /* 전체상품+배송비 총합계 */
				 $("#count").html(count); /* 상품 개수 출력 */
				
			});
			
			$(".minus:eq("+index+")").on('click',function(event) { /* -버튼 */
				var minusHap =0; /* 선택된 상품들 합계금액 */
				var count =0; /* 선택된 상품개수 */
				var dlv = 3000; /* 배송비 */
				quantity =Number(quantity); /* 숫자타입으로 변환 */
				if(quantity>1){
					quantity--;
					var mlg = AddComma(quantity*mileage);
					var total = AddComma(quantity*price);
					 $("input[class='pQuantity']:eq("+index+")").val(quantity);
					 $(".mileage:eq("+index+")").html(mlg+"원");
					 $(".tot:eq("+index+")").html(total+"원");
				}
				/* 변경된 수량 저장 */
				 var pno=$("input[name='pno']:eq("+index+")").val();
				var params ="?pno="+pno+"&pQuantity="+quantity;
				productService.chgCart(params);
				
				//$("input[class='check']:eq("+index+")").prop(!$("input[class='check']:eq("+index+")").prop('checked'),'checked' );
				 for(var i =0 ; i<length;i++){ /* 선택된 상품만 전체합계 출력 */
				 var check= $("input[class='check']:eq("+i+")").is(':checked');
				 if(check){
					 var tot = $(".tot:eq("+i+")").html();
					 tot=tot.substr(0,tot.length-1);
					 tot =Number(tot.replace(/,/g,""));
					 minusHap+=tot;
					 count++;
				 }
				 }
				 if(minusHap>=30000){
					 dlv=0;
				 }
				 $("#hap").html(AddComma(minusHap)+"원"); /* 전체상품 총합계 */
				 $("#dlv").html(AddComma(dlv)+"원"); /* 배송비 */
				 $("#totalHap").html(AddComma(minusHap+dlv)+"원"); /* 전체상품+배송비 총합계 */
				 $("#count").html(count); /* 상품 개수 출력 */
			});
		});
		
		 $("#checkAll").click(function(){ /* 전체 체크박스 클릭 */
			 $("input[class='check']").each(function() {
					 var dlv =0;
				 if($("#checkAll").is(':checked')){ /* 전체체크박스가 체크일때 */
				    $(this).prop('checked', true); /* 상품전체체크하기 */
				    if(hap<30000){
				    	dlv=3000;
				    }
				    $("#hap").html(AddComma(hap)+"원"); /* 전체상품 총합계 */
				    $("#dlv").html(AddComma(dlv)+"원"); /* 배송비 */
				    $("#totalHap").html(AddComma(hap+dlv)+"원"); /* 전체상품+배송비 총합계 */    
			 		$("#count").html(length); /* 상품 개수 출력 */
				 }else{ /* 전체체크박스가 체크x */
				    $(this).prop('checked', false); /* 상품전체체크해제 */
				    $("#hap").html(0+"원"); /* 전체상품 총합계 */
				    $("#dlv").html(dlv+"원"); /* 배송비 */
				    $("#totalHap").html(0+"원"); /* 전체상품+배송비 총합계 */    
			 		$("#count").html(0); /* 상품 개수 0개 출력 */
				 }
				});
		 });
		 
		 $("input[class='check']").each(function(index, item) { /* 체크박스 클릭 */
			 $("input[class='check']:eq("+index+")").click(function(){ 
				 var count =0;
				 var hap =0 ;
				 var dlv=3000;
				 $("input[id='checkAll']").prop('checked', false);
				 $("input[class='check']:eq("+index+")").prop(!$("input[class='check']:eq("+index+")").prop('checked'),'checked' );
				 for(var i =0 ; i<length;i++){ /* 선택된 상품만 출력 */
				 var check= $("input[class='check']:eq("+i+")").is(':checked');
				 if(check){ // 원, 세자리수 , 제거하기
					 var tot = $(".tot:eq("+i+")").html();
					 tot=tot.substr(0,tot.length-1);
					 tot =Number(tot.replace(/,/g,""));
					 hap+=tot;
					 count++;
				 }
				 }
				 if(hap>=30000){
					 dlv=0;
				 }
				 $("#hap").html(AddComma(hap)+"원"); /* 전체상품 총합계 */
				 $("#dlv").html(AddComma(dlv)+"원"); /* 배송비 */
				 $("#totalHap").html(AddComma(hap+dlv)+"원"); /* 전체상품+배송비 총합계 */
				 $("#count").html(count); /* 상품 개수 출력 */
				 if(count==length){ /* 전체상품이 체크되어있으면 checkAll도 체크 */
					 $("input[id='checkAll']").prop('checked', true);
				 }else if(count==0){ /* 선택된 상품이 없음 */
					 $("#dlv").html(0+"원"); /* 배송비 */
					    $("#totalHap").html(0+"원"); /* 전체상품+배송비 총합계 */    
				 }
			});
			});
			
	$("#dlt-btn").click(function(e){ /* 선택한 상품 삭제 */
		e.preventDefault();
		var result = confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?");
		if(result){
		$("#cartForm").attr("action","cartDlt.do");
		$("#cartForm").submit();
		}
	});
	$("#orderSlct").click(function(e){ /* 선택한 상품 주문 */
		e.preventDefault();
		var count=0;
		 $("input[class='check']").each(function(index, item) { 
			 var check =$("input[class='check']:eq("+index+")").is(':checked');
			 if(check){
				 //class로 이용하고 name속성 추가하는 이유: 선택한 상품만 주문할때 
				 //선택안한 상품도 pQuantity값이 넘어가기때문에 submit할때만 값을 받기위해
				 //submit할때 name속성 추가
				 $("input[class='pQuantity']:eq("+index+")").attr("name","pQuantity");
				count++;
			 }
		 });
		 if(count==0){ //선택한 상품이 없을때
			 alert("선택하신 상품이 없습니다.");
			 return;
		 }
		 $("#cartForm").submit();  
	});
	$("#orderAll").click(function(e){ /* 전체상품 주문 */
		 $("input[class='check']").prop('checked', true);
		 $("input[class='pQuantity']").attr("name","pQuantity");
		 $("#cartForm").submit(); 
	});
	
	});