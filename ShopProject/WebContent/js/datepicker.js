$(function() {
	$("#startDate").datepicker(
			{
				dateFormat : 'yy-mm-dd',
				prevText : '이전 달',
				nextText : '다음 달',
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
						'8월', '9월', '10월', '11월', '12월' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				showMonthAfterYear : true,
				yearSuffix : '년',
				onClose : function(selectedDate) {
					// 시작일(startDate) datepicker가 닫힐때
					// 종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
					$("#endDate").datepicker("option", "minDate",
							selectedDate);
				}
			});
	$("#endDate").datepicker(
			{
				dateFormat : 'yy-mm-dd',
				prevText : '이전 달',
				nextText : '다음 달',
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
						'8월', '9월', '10월', '11월', '12월' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				showMonthAfterYear : true,
				yearSuffix : '년',
				onClose : function(selectedDate) {
					// 종료일(endDate) datepicker가 닫힐때
					// 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
					$("#startDate").datepicker("option", "maxDate",
							selectedDate);
				}
			});
});

$(document).ready(function() {
$("#startDate").attr("disabled", true);
$("#endDate").attr("disabled", true);

$("#today").click(function() {
	$("#startDate").attr("disabled", false);
	$("#endDate").attr("disabled", false);
	$("#startDate").datepicker('setDate', new Date());
	$("#endDate").datepicker('setDate', new Date());
});
$("#week").click(function() {
	$("#startDate").attr("disabled", false);
	$("#endDate").attr("disabled", false);
	var today = new Date();
	$("#endDate").datepicker('setDate', today);
	today.setDate(today.getDate() - 7);
	$("#startDate").datepicker('setDate', today);
});
$("#month").click(function() {
	$("#startDate").attr("disabled", false);
	$("#endDate").attr("disabled", false);
	var today = new Date();
	$("#endDate").datepicker('setDate', today);
	today.setMonth(today.getMonth() - 1);
	$("#startDate").datepicker('setDate', today);
});
$("#thrMonth").click(function() {
	$("#startDate").attr("disabled", false);
	$("#endDate").attr("disabled", false);
	var today = new Date();
	$("#endDate").datepicker('setDate', today);
	today.setMonth(today.getMonth() - 3);
	$("#startDate").datepicker('setDate', today);
});
$("#year").click(function() {
	$("#startDate").attr("disabled", false);
	$("#endDate").attr("disabled", false);
	var today = new Date();
	$("#endDate").datepicker('setDate', today);
	today.setYear(today.getFullYear() - 1);
	$("#startDate").datepicker('setDate', today);
});
$("#total").click(function() {
	$("#startDate").attr("disabled", true); //입력불가, 값 안넘어감
	$("#endDate").attr("disabled", true); //입력불가, 값 안넘어감
});
$("#calendar").click(function() {
	$("#startDate").attr("disabled", false);
	$("#endDate").attr("disabled", false);
});

$("#startDate").datepicker('setDate', new Date()); //startDate 기본날짜
$("#endDate").datepicker('setDate', new Date()); // endDate 기본날짜
});

