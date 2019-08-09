<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	var image = '<c:out value="${notice.image}"/>';
	if(image != ''){
		$("#img").append("<img src=../images/board/"+image+">");
		$("#img").css("margin-bottom","30px");
	}
});
</script>
<div class="right">
	<div class="boardRead">
		<h1>게시판 관리</h1>
		<div style="background-color:#fff;margin:0 auto">
			<h2 style="text-align:center">공지사항</h2>
			<table>
				<tr>
					<td style="font-size: 18px; text-align: left"><font>${notice.title}</font></td>
					<td style="width:220px; text-align:right"><font>조회수</font>&nbsp;&nbsp;${notice.readCount}</td>
				</tr>
				<tr>
					<td style="text-align: left"><font>작성자</font>&nbsp;&nbsp;${notice.writer}</td>
					<td style="text-align:right"><font>등록일</font>&nbsp;&nbsp;<fmt:formatDate
							value="${notice.regDate}" pattern="yyyy.MM.dd HH:mm" /></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: left; padding: 30px 15px">
						<p id="img"></p>
						<p id="content">${notice.content}</p>
					</td>
				</tr>
			</table>
			<div style="width: 90%; text-align: right;padding:20px 0">
				<button onClick="history.go(-1)">목록</button>
			</div>
		</div>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>