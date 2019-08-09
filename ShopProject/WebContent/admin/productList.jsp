<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
function update(pno){
	window.open("/admin/product.do?mode=update&pno="+pno, "window", "width=925,height=950");
}
</script>
<script type="text/javascript">
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
				
				$("#dlt-btn").click(function(){
					var count=0;
					 $("input:checkbox[name='pno']").each(function(index, item) { 
						 var check =$("input:checkbox[name='pno']:eq("+index+")").is(':checked');
						 if(check){
							count++;
						 }
					 });
					 if(count==0){ //선택한 상품이 없을때
						 alert("삭제할 상품을 선택해 주세요.");
						 return false;
					 }
					 
					var result = confirm("선택한 상품을 삭제하시겠습니까?");
					if(result){
						document.productForm.submit();
					}
				});
				
$("#highCtgry").change(function() { //중분류 출력
	$("select[id='mediumCtgryNo'] option").not(":first").remove();
	$("select[id='lowCtgryName'] option").not(":first").remove();
	var value = $("#highCtgry").find(":selected").val();
	if (value) {
		var params = "?ctgry=medium&no="+ value;
		productService.categoryList(params);
	}
});

$("select[id='mediumCtgryNo']").change(
		function() { //소분류 출력
			$("select[id='lowCtgryName'] option").not(":first").remove();
			var value = $("select[id='mediumCtgryNo']").find(":selected").val();
			if (value) {
				var params = "?ctgry=low&no=" + value;
				productService.categoryList(params);
			}
		});
		
$("#checkAll").click(function(){ /* 전체 체크박스 클릭 */
	 $("input:checkbox[name='pno']").each(function() {
		 if($("#checkAll").is(':checked')){ /* 전체체크박스가 체크일때 */
		    $(this).prop('checked', true); /* 상품전체체크하기 */
		    }else{ /* 전체체크박스가 체크x */
		    $(this).prop('checked', false); /* 상품전체체크해제 */
		 }
	 });
		});
		
var page ='<c:out value="${pageMaker.cri.page}"/>';
var startPage = '<c:out value="${pageMaker.startPage}"/>';
var endPage = '<c:out value="${pageMaker.endPage}"/>';
var type = '<c:out value="${search.type}"/>';
$(".pageNum").each(function(index,item) {
var pageNum = $(".pageNum i:eq(" +index+ ")").html();
if(page==pageNum){
$(".pageNum:eq("+index+")").addClass("active");
}
});

var loc = $(location).attr('href'); 
if(type==''){
	var href =loc.split("?");
	var i = startPage;
	 $(".pageNum a").each(function(index,item) {
		var url = href[0]+"?page="+(i);
		$(this).attr("href",url); 
		i++;
	}); 
	$("#prev a").attr("href",href[0]+"?page="+(Number(startPage)-1)); 
	$("#next a").attr("href",href[0]+"?page="+(Number(endPage)+1)); 
}else{
	var href = loc.split("&page");
	var i = startPage;
	$(".pageNum a").each(function(index,item) {
		var url = href[0]+"&page="+(i);
		$(this).attr("href",url); 
		i++;
	});
	$("#prev a").attr("href",href[0]+"&page="+(Number(startPage)-1)); 
	$("#next a").attr("href",href[0]+"&page="+(Number(endPage)+1)); 
}	
});
</script>
<script>
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
$(function() {
	$("#startDate").datepicker({
		onSelect : function(dateText, inst) {
		}
	});
	$("#endDate").datepicker({
		onSelect : function(dateText, inst) {
		}
	});

	$("#startDate").datepicker('setDate', new Date()); //startDate 기본날짜
	$("#endDate").datepicker('setDate', new Date()); // endDate 기본날짜
	});
</script>

<div class="right">
	<div class="mngList">
		<h1>상품 목록</h1>
		<form action="/admin/product.do">
			<table class="search-tb">
				<tr>
					<th>검색어</th>
					<td><select name="type"><option value="p.pName">상품명</option>
							<option value="p.pno">상품번호</option>
							<option value="p.pCompany">브랜드</option></select> <input type="text"
						name="keyword"></td>
				</tr>
				<tr>
					<th>상품 분류</th>
					<td><select id="highCtgry" name="high">
							<option value="">- 대분류 선택 -</option>
							<c:forEach var="h" items="${high}">
								<option value="${h.highCtgryNo}">${h.highCtgryName}</option>
							</c:forEach>
					</select>&nbsp;&nbsp; <select name="medium" id="mediumCtgryNo"><option
								value="">- 중분류 선택 -</option>
					</select>&nbsp;&nbsp; <select name="low" id="lowCtgryName"><option
								value="">- 소분류 선택 -</option>
					</select></td>
				</tr>
				<tr>
					<th>상품 등록일</th>
					<td><button type="button" id="today">오늘</button>
						<button type="button" id="week">7일</button>
						<button type="button" id="month">1개월</button>
						<button type="button" id="thrMonth">3개월</button>
						<button type="button" id="year">1년</button>
						<button type="button" id="total">전체</button> <input type="text"
						name="startDate" id="startDate" readonly> <input
						type="button" id="calendar"
						onclick="$('#startDate').datepicker('show');" />&nbsp;~&nbsp; <input
						type="text" name="endDate" id="endDate" readonly> <input
						type="button" id="calendar"
						onclick="$('#endDate').datepicker('show');" /></td>
				</tr>
				<tr>
					<th>상품 상태</th>
					<td><input type="radio" name="pStatus" value="" checked>
						전체 <input type="radio" name="pStatus" value="정상"> 정상 <input
						type="radio" name="pStatus" value="품절"> 품절 <input
						type="radio" name="pStatus" value="판매중단"> 판매중단</td>
				</tr>
				<tr>
					<th colspan="2"><button class="admin-btn">검색</button></th>
				</tr>
			</table>
		</form>
		<form name="productForm" action="/admin/product.do">
			<input type="hidden" name="mode" value="delete">
			<p>
				[총 <font style="color: red">${total}</font>개]
			</p>
			<table>
				<tr>
					<th width="5%"><input type="checkbox" id="checkAll"></th>
					<th>상품번호</th>
					<th>대분류</th>
					<th>중분류</th>
					<th>소분류</th>
					<th width="20%">상품명</th>
					<th>가격</th>
					<th>브랜드</th>
					<th>재고수량</th>
					<th>판매수량</th>
					<th>상품상태</th>
					<th>등록일</th>
				</tr>
				<c:if test="${fn:length(product)==0}">
					<tr>
						<td colspan="12">상품내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${fn:length(product)>0}">
					<c:forEach var="p" items="${product}">
						<tr>
							<td><input type="checkbox" name="pno" value="${p.pno}"></td>
							<td>${p.pno}</td>
							<td>${p.highCtgryName}</td>
							<td>${p.mediumCtgryName}</td>
							<td>${p.lowCtgryName}</td>
							<td><a onClick="update(${p.pno})">${p.pName}</a></td>
							<td>${p.price}원</td>
							<td>${p.pCompany}</td>
							<td>${p.pStock}</td>
							<td>${p.pBuyNum}</td>
							<td>${p.pStatus}</td>
							<td><fmt:formatDate value="${p.pRegisterDate}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
					</c:forEach>
				</c:if>
				<tr>
					<td colspan="12" style="text-align: left">선택한 상품
						<button type="button" id="dlt-btn">삭제</button>
					</td>
				</tr>
				<tr>
					<th colspan="12">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li id="prev"><a
									href="#"><i
										class="fa fa-chevron-left"></i></a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="index">
								<li class="pageNum"><a
									href="#"><i
										class="fa">${index}</i></a></li>
							</c:forEach>
							<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								<li id="next"><a
									href="#"><i
										class="fa fa-chevron-right"></i></a></li>
							</c:if>
						</ul>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>