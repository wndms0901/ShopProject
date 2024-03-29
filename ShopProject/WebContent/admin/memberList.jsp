<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="../js/datepicker.js"></script>
<script type="text/javascript">
function read(mbId){
	window.open("/admin/member.do?mode=read&mbId="+mbId, "window", "width=925,height=690");
}
</script>
<script>
$(document).ready(function() {
	$("#checkAll").click(function(){ /* 전체 체크박스 클릭 */
		 $("input:checkbox[name='mbId']").each(function() {
			 if($("#checkAll").is(':checked')){ /* 전체체크박스가 체크일때 */
			    $(this).prop('checked', true); /* 회원전체체크하기 */
			    }else{ /* 전체체크박스가 체크x */
			    $(this).prop('checked', false); /* 회원전체체크해제 */
			 }
		 });
			});
	
	$("#update-btn").click(function() { //변경버튼 클릭
		var count=0;
		 $("input:checkbox[name='mbId']").each(function(index, item) { 
			 var check =$("input:checkbox[name='mbId']:eq("+index+")").is(':checked');
			 if(check){
				 $("input[class='mbMemo']:eq("+index+")").attr("name","mbMemo");
				count++;
			 }
		 });
		 if(count==0){ //선택한 항목이 없을때
			 alert("선택한 항목이 없습니다.");
			 return false;
		 }
		 var result = confirm("선택한 회원의 메모를 수정하시겠습니까?");
			if(result){
				$("input[name='mode']").val("update");
				document.updateForm.submit();
				alert("메모가 수정되었습니다.");
			}
	});
	
	$("#dlt-btn").click(function() { //삭제버튼 클릭
		var count=0;
		 $("input:checkbox[name='mbId']").each(function(index, item) { 
			 var check =$("input:checkbox[name='mbId']:eq("+index+")").is(':checked');
			 if(check){
				count++;
			 }
		 });
		 if(count==0){ //선택한 항목이 없을때
			 alert("선택한 항목이 없습니다.");
			 return false;
		 }
		 var result = confirm("선택한 회원을 삭제하시겠습니까?");
			if(result){
				$("input[name='mode']").val("delete");
				document.updateForm.submit();
				alert("선택한 회원이 삭제되었습니다.");
			}
	});
	
	var type = '<c:out value="${search.type}"/>';
	var keyword = '<c:out value="${search.keyword}"/>';
	var startDate = '<c:out value="${search.startDate}"/>';
	var endDate = '<c:out value="${search.endDate}"/>';
	var page ='<c:out value="${pageMaker.cri.page}"/>';
	var startPage = '<c:out value="${pageMaker.startPage}"/>';
	var endPage = '<c:out value="${pageMaker.endPage}"/>';
	
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

	<div class="right">
		<div class="mngList">
			<h1>회원관리</h1>
			<form action="/admin/member.do">
				<table class="search-tb">
					<tr>
						<th>검색어</th>
						<td><select name="type"><option value="mbId">아이디</option>
								<option value="mbName">이름</option>
								<option value="mbEmail">이메일</option>
								<option value="mbPhone">휴대폰번호</option></select> <input type="text" name="keyword"></td>
					</tr>
					<tr>
						<th>가입일</th>
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
			<form name="updateForm" action="/admin/member.do">
			<input type="hidden" name="mode" value="">
			<p>
				[총 <font style="color: red">${total}</font>개]
			</p>
				<table>
					<tr>
						<th width="5%"><input type="checkbox" id="checkAll"></th>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
						<th>휴대전화</th>
						<th>생년월일</th>
						<th>적립금</th>
						<th>가입일</th>
						<th>최근로그인</th>
						<th>메모</th>
					</tr>
					<c:forEach var="m" items="${member}">
					<tr><td><input type="checkbox" name="mbId" value="${m.mbId}"></td>
						<td><a onClick="read('${m.mbId}')">${m.mbId}</a></td>
						<td>${m.mbName}</td>
						<td>${m.mbEmail}</td>
						<td>${m.mbPhone}</td>
						<td>${m.mbBirth}</td>
						<td>${m.mbMileage}</td>
						<td><fmt:formatDate value="${m.mbRegisterDate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><fmt:formatDate value="${m.mbLoginTime}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><input type="text" class="mbMemo" value="${m.mbMemo}"></td></tr>
						</c:forEach>
					<tr><td colspan="12" style="text-align:left">선택한 회원&nbsp;&nbsp;&nbsp;<button id="update-btn">메모수정</button>&nbsp;&nbsp;<button type="button" id="dlt-btn">삭제</button></td></tr>
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