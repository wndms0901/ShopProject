<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="../js/datepicker.js"></script>
<script>
	$(document).ready(function() {
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
		
		var type = '<c:out value="${search.type}"/>';
		var keyword = '<c:out value="${search.keyword}"/>';
		var startDate = '<c:out value="${search.startDate}"/>';
		var endDate = '<c:out value="${search.endDate}"/>';
		var startPage = '<c:out value="${pageMaker.startPage}"/>';
		var endPage = '<c:out value="${pageMaker.endPage}"/>';
		var page ='<c:out value="${pageMaker.cri.page}"/>';
		var bno = '<c:out value="${board.bno}"/>';
		//검색했을때 검색한 조건 출력하기
		if(type){ //검색어 출력
			$("select[name='type']").val(type);
			$("input[name='keyword']").val(keyword);
		}
		if(startDate){ //기간 출력
			$("#startDate").attr("disabled", false);
			$("#endDate").attr("disabled", false);
			$("#startDate").datepicker('setDate', startDate); //startDate 출력
			$("#endDate").datepicker('setDate', endDate); // endDate 출력
		}
		//페이징처리(현재페이지 표시)
		$(".pageNum").each(function(index,item) {
		var pageNum = $(".pageNum i:eq(" +index+ ")").html();
		if(page==pageNum){
		$(".pageNum:eq("+index+")").addClass("active");
		}
		});
		//페이징처리(a태그 href에 page 파라미터 추가)
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