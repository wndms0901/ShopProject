<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(document).ready(function() {
	$("#reg-btn").click(function(){
		var title = $("input[name='title']").val();
		var writer = $("input[name='writer']").val();
		var content = $("textarea").val();
		if(!title){
			alert("제목을 입력하세요.");
			return false;
		}
		if(!writer){
			alert("작성자를 입력하세요.");
			return false;
		}
		if(!content){
			alert("내용을 입력하세요.");
			return false;
		}
		var file = $('input[type=file]').val();
		if(file){
			$("form[name='writeForm']").attr("enctype","multipart/form-data");
			$("form[name='writeForm']").attr("method","post");
		}
		var content = $("textarea").val().replace(/\n/g, "<br>");
		$("textarea").val(content);
		document.writeForm.submit();
	});
});
</script>
<div class="right">
		<h1>게시판 관리</h1>
	<div class="write">
		<form name="writeForm" action="/admin/board.do">
		<input type="hidden" name="mode" value="write">
		<input type="hidden" name="boardCode" value="${boardCode}">
			<h2 style="text-align: center">글쓰기</h2>
			<table>
			<tr>
			<th>게시판</th>
			<td colspan="2" style="font-size:18px;">공지사항</td>
			</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr id="writer">
					<th>작성자</th>
					<td><input type="text" name="writer" value="관리자"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" rows="15" cols="100"></textarea></td>
				</tr>
				<tr>
					<th>이미지</th>
					<td><input type="file" name="image"></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 50px 0">
				<button id="reg-btn" type="button">등록</button>&nbsp;&nbsp;
					<button id="cancel-btn" type="button" onClick="history.go(-1)">취소</button>
			</div>
		</form>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>