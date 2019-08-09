<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
function read(orderId){
	window.open("/admin/order.do?mode=read&orderId="+orderId, "window", "width=1200,height=950");
}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".productList").each(function(index, item) {
			var orderId = $(".orderId a:eq(" + index + ")").html();
			var value = orderId.substring(0, 1);
			var params = "?orderId=" + orderId + "&index=" + index;
			productService.orderList(params);

			if (value == 'm') {
				$(".member:eq(" + index + ")").html("(회원)");
			} else {
				$(".member:eq(" + index + ")").html("(비회원)");
			}
		});

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

		$("#checkAll").click(function() {
			if ($("#checkAll").prop("checked")) {
				$("input[name='orderState']").prop("checked", true);
			} else {
				$("input[name='orderState']").prop("checked", false);
			}
		});

		$(".admin-btn").click(function() { //검색버튼 클릭
			var type = $("select[name='type']").val();
			var user = $(':radio[name="user"]:checked').val();
			if (type == 'mbId' && user == '비회원') {
				alert("비회원은 주문자 아이디로 검색이 불가능합니다.");
				return false;
			}
		});
		
		$("#checkAll2").click(function(){ /* 전체 체크박스 클릭 */
			 $("input:checkbox[name='orderId']").each(function() {
				 if($("#checkAll2").is(':checked')){ /* 전체체크박스가 체크일때 */
				    $(this).prop('checked', true); /* 상품전체체크하기 */
				    }else{ /* 전체체크박스가 체크x */
				    $(this).prop('checked', false); /* 상품전체체크해제 */
				 }
			 });
				});
		$("#update-btn").click(function() { //변경버튼 클릭
			var count=0;
			var orderState = $("select[name='orderState']").val();
			 $("input:checkbox[name='orderId']").each(function(index, item) { 
				 var check =$("input:checkbox[name='orderId']:eq("+index+")").is(':checked');
				 if(check){
					count++;
				 }
			 });
			 if(count==0){ //선택한 항목이 없을때
				 alert("선택한 항목이 없습니다.");
				 return false;
			 }
			 if(!orderState){
					alert("변경할 상품상태를 선택하세요.");			 
				 return false;
			 }
			 var result = confirm("선택한 항목의 주문상태를 변경하시겠습니까?");
				if(result){
					document.updateForm.submit();
					alert("주문상태가 변경되었습니다.");
				}
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
						console.log("selected:" + selectedDate);
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
		$("#checkAll").prop("checked", true);
		$("input[name='orderState']").prop("checked", true);
	});
</script>
<div class="right">
	<div class="mngList">
		<h1>주문관리</h1>
		<form action="/admin/order.do">
			<table class="search-tb">
				<tr>
					<th>검색어</th>
					<td><select name="type"><option value="orderId">주문번호</option>
							<option value="mbId">주문자 아이디</option>
							<option value="buyerName">주문자명</option>
							<option value="recipientName">수령자명</option></select> <input type="text"
						name="keyword"></td>
				</tr>
				<tr>
					<th>기간</th>
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
					<th>주문상태</th>
					<td><input type="checkbox" id="checkAll"> 전체 <input
						type="checkbox" name="orderState" value="입금대기"> 입금대기 <input
						type="checkbox" name="orderState" value="결제완료"> 결제완료 <input
						type="checkbox" name="orderState" value="상품준비중"> 상품준비중 <input
						type="checkbox" name="orderState" value="배송중"> 배송중 <input
						type="checkbox" name="orderState" value="배송완료"> 배송완료</td>
				</tr>
				<tr>
					<th>회원구분</th>
					<td><input type="radio" name="user" value="전체" checked>
						전체 <input type="radio" name="user" value="회원"> 회원 <input
						type="radio" name="user" value="비회원"> 비회원</td>
				</tr>
				<tr>
					<th colspan="2"><button class="admin-btn">검색</button></th>
				</tr>
			</table>
		</form>
		<form name="updateForm" action="/admin/order.do">
		<input type="hidden" name="mode" value="update">
			<p>
				[총 <font style="color: red">${total}</font>개]
			</p>
			<table>
				<tr>
					<th width="5%"><input type="checkbox" id="checkAll2"></th>
					<th width="10%">주문일</th>
					<th>주문번호</th>
					<th width="8%">주문자명</th>
					<th width="15%">주문상품명</th>
					<th width="12%">결제수단</th>
					<th>상품합계금액</th>
					<th>최종결제금액</th>
					<th>주문상태</th>
					<th>배송메시지</th>
				</tr>
				<c:forEach var="o" items="${order}">
					<tr>
						<td><input type="checkbox" name="orderId" value="${o.orderId}"></td>
						<td><fmt:formatDate value="${o.orderDate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td class="orderId"><a onClick="read('${o.orderId}')">${o.orderId}</a></td>
						<td>${o.buyerName}<br>
						<font class="member"></font></td>
						<td class="productList"></td>
						<td>${o.payType}</td>
						<td>${o.productAmount}</td>
						<td>${o.finalAmount}</td>
						<td>${o.orderState}</td>
						<td>${o.orderMessage}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="10" style="text-align: left">선택한 항목의 주문상태를
					<select name="orderState">
						<option value="">-- 선택 --</option>
						<option>입금대기</option>
							<option>결제완료</option>
							<option>상품준비중</option>
							<option>배송중</option>
							<option>배송완료</option></select>
					로&nbsp;<button type="button" id="update-btn" type="button">변경</button></td>
				</tr>
				<tr>
					<th colspan="10"><ul class="pagination">
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
						</ul></th>
				</tr>
			</table>
		</form>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>