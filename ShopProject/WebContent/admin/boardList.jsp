<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(document).ready(function() {
		$("#startDate").attr("disabled", true);
		$("#endDate").attr("disabled", true);
		var bno ='<c:out value="${b.bno}"/>';
		var boardCode ='<c:out value="${b.boardCode}"/>';
		
		if(bno){
				$(".board-btn a:eq("+bno+")").attr('id', 'point');
				$("form[name='search-form']").append('<input type="hidden" name="bno" value='+bno+'>');
				$("form[name='search-form']").append('<input type="hidden" name="boardCode" value='+boardCode+'>');
				if(boardCode=='notice' || boardCode=='event'){
				$("#write").append("<button type='button'>글쓰기</button>")
				}
		}else{
				$(".board-btn a:first-child").attr('id', 'point');
		}
		var board = $("#point").html();
		$("#board").html(board);
		
		$("#write button").click(function(){
			location.href='/admin/board.do?mode=write&boardCode='+boardCode;
		});
		
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
				$("input[name='boardCode']").prop("checked", true);
			} else {
				$("input[name='boardCode']").prop("checked", false);
			}
		});
		
		$("#dlt-btn").click(function(){
			var count=0;
			 $("input:checkbox[name='boardCode']").each(function(index, item) { 
				 var check =$("input:checkbox[name='boardCode']:eq("+index+")").is(':checked');
				 if(check){
					count++;
				 }
			 });
			 if(count==0){ //선택한 게시물이 없을때
				 alert("삭제할 게시물을 선택해 주세요.");
				 return false;
			 }
			 
			var result = confirm("선택한 게시물을 삭제하시겠습니까?")
			if(result){
			$("input:checkbox[name='boardCode']").each(function(index,item) {
				if($("input:checkbox[name='boardCode']:eq("+index+")").is(":checked")){
					$(".no:eq("+index+")").attr("name","no");
				}
			});
			document.boardForm.submit();
			}
		});
		
		var page ='<c:out value="${pageMaker.cri.page}"/>';
		var startPage = '<c:out value="${pageMaker.startPage}"/>';
		var endPage = '<c:out value="${pageMaker.endPage}"/>';
		var type = '<c:out value="${search.type}"/>';
		var bno = '<c:out value="${board.bno}"/>';
		$(".pageNum").each(function(index,item) {
		var pageNum = $(".pageNum i:eq(" +index+ ")").html();
		if(page==pageNum){
		$(".pageNum:eq("+index+")").addClass("active");
		}
		});

		var loc = $(location).attr('href'); 
		if(type!='' || bno>0){
			var href = loc.split("&page");
			var i = startPage;
			$(".pageNum a").each(function(index,item) {
				var url = href[0]+"&page="+(i);
				$(this).attr("href",url); 
				i++;
			});
			$("#prev a").attr("href",href[0]+"&page="+(Number(startPage)-1)); 
			$("#next a").attr("href",href[0]+"&page="+(Number(endPage)+1)); 
		}else{
			var href =loc.split("?");
			var i = startPage;
			 $(".pageNum a").each(function(index,item) {
				var url = href[0]+"?page="+(i);
				$(this).attr("href",url); 
				i++;
			}); 
			$("#prev a").attr("href",href[0]+"?page="+(Number(startPage)-1)); 
			$("#next a").attr("href",href[0]+"?page="+(Number(endPage)+1)); 
		}	
});
		
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
	});
</script>
<div class="right">
	<div class="mngList">
		<h1>게시판 관리</h1>
		<div class="board-btn">
			<a href="/admin/board.do">전체</a><c:forEach var="l" items="${list}"><a href="/admin/board.do?bno=${l.bno}&boardCode=${l.boardCode}">${l.boardName}</a></c:forEach>
		</div>
		<form name="search-form" action="/admin/board.do">
			<table class="search-tb">
				<tr>
					<th>검색어</th>
					<td><select name="type"><option value="title">제목</option>
							<option value="content">내용</option></select> <input type="text" name="keyword"></td>
				</tr>
				<tr>
					<th>등록일</th>
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
					<th colspan="2"><button class="admin-btn">검색</button></th>
				</tr>
			</table>
		</form>
		<form name="boardForm" action="/admin/board.do">
		<!-- <form name="boardForm" action="test.jsp"> -->
		<input type="hidden" name="mode" value="delete">
			<p style="display: inline-block; width:15%">
				<font id="board" style="font-size:28px"></font>&nbsp;&nbsp;[총 <font style="color: red">${total}</font>개]
			</p>
			<p id="write" style="display: inline-block; width: 69%; text-align: right">
				
			</p>
			<table>
				<tr>
					<th width="5%"><input type="checkbox" id="checkAll"></th>
					<th>No</th>
					<th>게시판 이름</th>
					<th>게시글 번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
					<th>보기</th>
					<th>수정</th>
				</tr>
				<c:forEach var="p" items="${post}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="boardCode" value="${p.boardCode}"></td>
					<td>${fn:length(post)-status.index}</td>
					<td>${p.boardName}</td>
					<td>${p.no}</td>
					<td>${p.title}</td>
					<td>${p.writer}</td>
					<td><fmt:formatDate value="${p.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>${p.readCount}</td>
					<td><a href="/admin/board.do?mode=read&boardCode=${p.boardCode}&no=${p.no}">보기</a></td>
					<td><a href="/admin/board.do?mode=update&boardCode=${p.boardCode}&no=${p.no}">수정</a></td>
				</tr>
				<input type="hidden" class="no" value="${p.no}">
				</c:forEach>
				<tr><td colspan="12" style="text-align:left">선택한 게시물 <button type="button" id="dlt-btn">삭제</button></td></tr>
				<tr>
					<th colspan="12"><ul class="pagination">
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