<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("textarea").val($("textarea").val().replace(/<br>/g, "\r\n"));
		
		var image = '<c:out value="${notice.image}"/>';
		if (image!='') {
			$("#img").append("<img src=../images/board/"+image+" width='200px' height='300px'>");
			$("#imgName").append(image);
		}else{
			$("#imgName").append("없음");
			$("#img").append("-");
		}
		
		$("#update-btn").click(function(){
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
				$("form[name='updateForm']").attr("enctype","multipart/form-data");
				$("form[name='updateForm']").attr("method","post");
			}
			var content = $("textarea").val().replace(/\n/g, "<br>");
			$("textarea").val(content);
			alert("게시글이 수정되었습니다.");
			document.updateForm.submit();
			});
	});
</script>
<div class="right">
	<div class="boardUpdate">
		<h1>게시판 관리</h1>
		<div style="background-color: #fff; margin: 0 auto">
			<h2 style="text-align: center">게시글 수정</h2>
			<form name="updateForm" action="/admin/board.do">
			<input type="hidden" name="mode" value="update">
			<input type="hidden" name="boardCode" value="${boardCode}">
			<input type="hidden" name="no" value="${no}">
			<table> 
			<tr>
			<th>게시판</th>
			<td colspan="2" style="font-size:18px;">공지사항</td>
			</tr>
				<tr>
					<th>제목</th>
					<td colspan="2"><input type="text" name="title" value="${notice.title}" size="40"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td colspan="2"><input type="text" name="writer" value="${notice.writer}" size="10"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="2"><textarea name="content" rows="15" cols="100">${notice.content}</textarea>
					</td>
				</tr>
				<tr>
					<th rowspan="2">이미지</th>
					<td width="40%">현재이미지&nbsp;:&nbsp;<font id="imgName"></font></td>
					<td width="40%">변경할 이미지</td>
				</tr>
				<tr><td id="img" style="text-align:center"></td>
				<td><input type="file" name="image"></td></tr>
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