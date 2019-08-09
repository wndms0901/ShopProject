<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	var image = '<c:out value="${notice.image}"/>';
	if(image != ''){
		$("#img").append("<img src=../images/board/"+image+">");
		$("#img").css("margin-bottom","30px");
	}
	
	$("#url").click(function(){
	var page ='<c:out value="${cri.page}"/>';
	var keyword = '<c:out value="${board.keyword}"/>';
	var type = '<c:out value="${board.type}"/>';
	var url = "/board/list.do?boardCode=notice&page="+page;
		if(keyword){
			 url += "&type="+type+"&keyword="+keyword;
		}
		location.href=url;
	});
});
</script>
<section>
	<div class="container">
		<div class="row">
			<div class="notice-list">
				<div class="location-info">
					<a href="/main/list.do">HOME</a>&nbsp;>&nbsp;공지사항
				</div>
				<h2>공지사항</h2>
				<div class="board-view">
					<table>
						<tr>
							<td style="font-size: 18px; text-align: left"><font>${notice.title}</font></td>
							<td><font>조회수</font>&nbsp;&nbsp;${notice.readCount}</td>
						</tr>
						<tr>
							<td style="text-align: left"><font>작성자</font>&nbsp;&nbsp;${notice.writer}</td>
							<td><font>등록일</font>&nbsp;&nbsp;<fmt:formatDate
									value="${notice.regDate}" pattern="yyyy.MM.dd HH:mm" /></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: left;padding: 30px 15px">
							<p id="img"></p>
							<p id="content">${notice.content}</p>
							</td>
						</tr>
					</table>
					<div style="width: 100%; text-align: right">
						<button id="url" onClick="location.href='/board/list.do?boardCode=notice&page=${cri.page}'">목록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>