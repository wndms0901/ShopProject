<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="../js/datepicker.js"></script>
<script>
	$(document).ready(function() {
		$("#startDate").attr("disabled", false);
		$("#endDate").attr("disabled", false);
		
		$("#update-btn").click(function(){
			var title = $("input[name='title']").val();
			var writer = $("input[name='writer']").val();
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			var image = $("input[name='image']").val();
			var content = $("input[name='content']").val();
			
			if(!title){
				alert("제목을 입력해주세요.");
				return false;
			}
			if(!writer){
				alert("작성자를 입력해주세요.");
				return false;
			}
			if(!startDate){
				alert("시작일을 입력해주세요.");
				return false;
			}
			if(!endDate){
				alert("종료일을 입력해주세요.");
				return false;
			}
			$("#startDate").val(startDate+ " 00:00:00");
			$("#endDate").val(endDate+" 23:59:59");
			var image = $('input[name=image]').val();
			var content = $('input[name=content]').val();
			if(image||content){
				$("form[name='updateForm']").attr("enctype","multipart/form-data");
				$("form[name='updateForm']").attr("method","post");
			}
			document.updateForm.submit();
		});
		
		var eventStart ='<fmt:formatDate value="${e.eventStart}" pattern="yyyy-MM-dd"/>';
		var eventEnd ='<fmt:formatDate value="${e.eventEnd}" pattern="yyyy-MM-dd"/>';
		$("#startDate").datepicker('setDate', eventStart);
		$("#endDate").datepicker('setDate', eventEnd); 
		});
</script>

<div class="right">
	<div class="boardUpdate">
		<h1>게시판 관리</h1>
		<div style="background-color: #fff; margin: 0 auto">
			<h2 style="text-align: center">게시글 수정</h2>
		<form name="updateForm" action="/admin/board.do">
	<!-- 	<form name="updateForm" action="test.jsp"> -->
			<input type="hidden" name="mode" value="update">
			<input type="hidden" name="boardCode" value="${boardCode}">
			<input type="hidden" name="no" value="${no}">
			<table>
			<tr>
			<th>게시판</th>
			<td colspan="2" style="font-size:18px;">이벤트</td>
			</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="title" value="${e.title}"></td>
				</tr>
				<tr id="writer">
					<th>작성자</th>
					<td colspan="3"><input type="text" name="writer" value="${e.writer}"></td>
				</tr>
				<tr>
					<th>시작일</th>
					<td  width="30%"><input type="text" name="eventStart" id="startDate"
						readonly> <input type="button" id="calendar"
						onclick="$('#startDate').datepicker('show');" /></td>
					<th>종료일</th>
					<td width="30%"><input type="text" name="eventEnd" id="endDate" readonly>
						<input type="button" id="calendar"
						onclick="$('#endDate').datepicker('show');" /></td>
				</tr>
				<tr>
					<th rowspan="2">목록 이미지</th>
					<td>현재이미지&nbsp;:&nbsp;${e.image}</td>
					<td colspan="2">변경할 이미지</td>
				</tr>
				<tr><td style="text-align:center"><img src="../images/board/${e.image}" width="200px" height="200px"></td>
				<td colspan="2"><input type="file" name="image"></td></tr>
				<tr>
					<th rowspan="2">내용</th>
					<td>현재이미지&nbsp;:&nbsp;${e.content}</td>
					<td colspan="2">변경할 이미지</td>
				</tr>
				<tr><td style="text-align:center"><img src="../images/board/${e.content}" width="200px" height="200px"></td>
				<td colspan="2"><input type="file" name="content"></td></tr>
				</table>
			<div style="text-align: center; padding: 30px 0">
				<button type="button" id="updat-btn">수정</button>&nbsp;&nbsp;
					<button type="button" id="cancel-btn" onClick="history.go(-1)">취소</button>
			</div>
			</form>
		</div>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>