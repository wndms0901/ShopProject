<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<div class="right">
	<div class="boardRead">
		<h1>게시판 관리</h1>
		<div style="background-color: #fff; margin: 0 auto">
			<h2 style="text-align: center">이벤트</h2>
			<table>
				<tr>
					<td style="font-size: 18px; text-align: left"><font>${e.title}</font></td>
					<td style="width:220px; text-align:right"><font>조회수</font>&nbsp;&nbsp;${e.readCount}</td>
				</tr>
				<tr>
					<td style="text-align: left"><font>이벤트 기간</font>&nbsp;&nbsp;&nbsp;<fmt:formatDate
							value="${e.eventStart}" pattern="yyyy.MM.dd HH:mm" />&nbsp;~&nbsp;<fmt:formatDate
							value="${e.eventEnd}" pattern="yyyy.MM.dd HH:mm" /></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: left"><font>작성자</font>&nbsp;&nbsp;${e.writer}</td>
					<td style="text-align:right"><font>등록일</font>&nbsp;&nbsp;<fmt:formatDate
							value="${e.regDate}" pattern="yyyy.MM.dd HH:mm" /></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center; padding: 40px 0"><img
						src="../images/board/${e.content}"></td>
				</tr>
			</table>
			<div style="width: 90%; text-align: right; padding: 20px 0">
				<button onClick="history.go(-1)">목록</button>
			</div>
		</div>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>