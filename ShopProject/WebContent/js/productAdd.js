function addCommas(x) { //3자리 단위마다 콤마 생성
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeCommas(x) { //모든 콤마 제거
    if(!x || x.length == 0) return "";
    else return x.split(",").join("");
}
$(document).ready(function() {
	$("#highCtgry").change(function(){ //중분류 출력
	 $("select[id='mediumCtgryNo'] option").not(":first").remove();
	 $("select[id='lowCtgryName'] option").not(":first").remove();
	var value = $("#highCtgry").find(":selected").val();
	if(value){
		var params = "?ctgry=medium&no="+value;
		productService.categoryList(params);
	}
	});
	$("select[id='mediumCtgryNo']").change(function(){ //소분류 출력
	 $("select[id='lowCtgryName'] option").not(":first").remove();
	 var value = $("select[id='mediumCtgryNo']").find(":selected").val();
	 if(value){
		var params = "?ctgry=low&no="+value;
		productService.categoryList(params);
	 }
	});
	
	$("input[name='price']").on("focus", function() { 
	    var x = $(this).val();
		if(Number(x)==0){ // 포커스 됐을때 0제거 또는 값이 ""일때 처음값으로 출력
			$(this).val("");
		}else{
	    x = removeCommas(x);
	    $(this).val(x);
		}
	}).on("keyup", function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"")); //숫자만 입력가능
	}).on("focusout", function() {
	    var x = $(this).val();
	   if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        x = addCommas(x); //콤마추가
	        $(this).val(x);
	    }
	});
	$("input[name='pStock']").on("focus", function() { 
	    var x = $(this).val();
		if(Number(x)==0){ // 포커스 됐을때 0제거 또는 값이 ""일때 처음값으로 출력
			$(this).val("");
		}else{
	    x = removeCommas(x);
	    $(this).val(x);
		}
	}).on("keyup", function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"")); //숫자만 입력가능
	}).on("focusout", function() {
	    var x = $(this).val();
	   if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        x = addCommas(x); //콤마추가
	        $(this).val(x);
	    }
	});
	
	$(".admin-btn").click(function(){
		var highCtgry = $("#highCtgry").val();
		var mediumCtgryNo = $("#mediumCtgryNo").val();
		var lowCtgryName = $("#lowCtgryName").val();
		var pName = $("input[name='pName']").val();
		var price = $("input[name='price']").val();
		var pCompany = $("input[name='pCompany']").val();
		var pStock = $("input[name='pStock']").val();
		var pImage =  $("input[name='pImage']").val();
		var pContent = $("input[name='pContent']").val();
		if(!highCtgry){
			alert("대분류를 선택해주세요.");
			return false;
		}
		if(!mediumCtgryNo){
			alert("중분류를 선택해주세요.");
			return false;
		}
		if(!lowCtgryName){
			alert("소분류를 선택해주세요.");
			return false;
		}
		if(!pName){
			alert("상품명을 입력해주세요.");
			return false;
		}
		if(!price){
			alert("판매가를 입력해주세요.");
			return false;
		}
		if(!pCompany){
			alert("브랜드를 입력해주세요.");
			return false;
		}
		if(!pStock){
			alert("재고수량을 입력해주세요.");
			return false;
		}
		if(!pImage){
			alert("상품 이미지를 선택해주세요.");
			return false;
		}
		if(!pContent){
			alert("상품 설명 이미지를 선택해주세요.");
			return false;
		}
		var value1 = $("input[name='price']").val();
		var value2 = $("input[name='pStock']").val();
		var price = removeCommas(value1);
		var pStock = removeCommas(value2);
		$("input[name='price']").val(price);
		$("input[name='pStock']").val(pStock);
		alert("상품이 저장되었습니다.");
		document.addForm.submit();
	});
});