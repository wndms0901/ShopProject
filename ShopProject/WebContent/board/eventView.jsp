<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<section>
	<div style="padding: 0; width: 100%">
		<img src="../images/home/event.jpg" width="100%">
	</div>
	<div class="container">
		<div class="row">
			<div class="board-view">
				<div class="location-info">
					<a href="/main/list.do">HOME</a>&nbsp;>&nbsp;이벤트
				</div>
				<table class="board-tb">
					<tr>
						<td><font style="font-size: 18px">${e.title}</font></td>
						<td><font>조회수</font>&nbsp;&nbsp;${e.readCount}</td>
					</tr>
					<tr>
						<td><font>작성자</font>&nbsp;&nbsp;${e.writer}</td>
						<td><font>등록일</font>&nbsp;&nbsp;<fmt:formatDate
								value="${e.regDate}" pattern="yyyy.MM.dd HH:mm" /></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; padding: 40px 0"><img
							src="../images/board/${e.content}"></td>
					</tr>
				</table>
				<div style="width: 100%; text-align: right">
					<button
						onClick="location.href='/board/list.do?boardCode=event&period=${board.period}&page=${cri.page}'">목록</button>
				</div>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>