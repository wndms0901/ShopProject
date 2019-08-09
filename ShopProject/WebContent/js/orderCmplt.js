function AddComma(data_value) { //숫자 3자리 단위마다 ,추가하기
		return Number(data_value).toLocaleString('en');
	}
$(document).ready(function() {
	$(".price").each(function(index,item) {
		var price = $(".price:eq("+index+")").html();
		var mileage =Math.floor(Number(price)/100);
		var pQuantity =$(".pQuantity:eq("+index+")").html();
		var tot = Number(price)*Number(pQuantity);
		$(".price:eq("+index+")").html(AddComma(price)+"원");
		$(".mileage:eq("+index+")").html(AddComma(mileage*Number(pQuantity))+"원");
		$(".tot:eq("+index+")").html(AddComma(tot)+"원");
	});
	
	var dlv = 3000;
	var mileageAdd = $(".mileageAdd").html();
	var mileageUse = $(".mileageUse").html();
	var hap = $(".hap").html();
	var totalHap = $(".totalHap").html();
	if(Number(hap)>=30000){
		dlv = 0;
	}
	$(".mileageAdd").html(AddComma(mileageAdd)+"원");
	$(".mileageUse").html(AddComma(mileageUse)+"원");
	$(".hap").html(AddComma(Number(hap))+"원");
	$(".totalHap").html(AddComma(Number(totalHap))+"원");
	$(".dlv").html(AddComma(dlv)+"원");
});
