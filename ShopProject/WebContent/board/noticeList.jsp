<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
		var keyword = '<c:out value="${board.keyword}"/>';
		var type = '<c:out value="${board.type}"/>';
		if(keyword){
			$(".url a").each(function(index,item) {
				var url= $(this).attr("href");
				 url += "&type="+type+"&keyword="+keyword;
				$(this).attr("href",url);
			});
			$("select[name='type']").val(type);
		}
		
		var page ='<c:out value="${pageMaker.cri.page}"/>';
		$(".pageNum").each(function(index,item) {
		var pageNum = $(".pageNum i:eq(" +index+ ")").html();
		if(page==pageNum){
		$(".pageNum:eq("+index+")").addClass("active");
		}
		});
		
		if(page){
			$(".url a").each(function(index,item) {
				var url= $(this).attr("href");
				 url += "&page="+page;
				$(this).attr("href",url);
			});
		}		
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
				<table>
					<tr>
						<th width="10%">번호</th>
						<th width="60%">제목</th>
						<th width="20%">날짜</th>
						<th width="10%">작성자</th>
					</tr>
					<c:if test="${fn:length(noticeList) > 0}">
					<c:forEach var="notice" items="${noticeList}" varStatus="status">
					<tr>
						<td>${fn:length(noticeList)-status.index}</td>
						<td class="url" style="text-align:left"><a href="/board/list.do?boardCode=notice&no=${notice.no}">${notice.title}</a></td>
						<td><fmt:formatDate value="${notice.regDate}" pattern="yyyy.MM.dd" /></td>
						<td>${notice.writer}</td>
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(noticeList) == 0}">
					<tr id="empty"><td colspan="4">등록된 게시글이 없습니다.</td></tr>
					</c:if>
				</table>
				<div style="text-align: center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li id="prev"><a
							href="/board/list.do?boardCode=notice&page=${pageMaker.startPage-1}"><i
								class="fa fa-chevron-left"></i></a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="index">
						<li class="pageNum"><a
							href="/board/list.do?boardCode=notice&page=${index}"><i
								class="fa">${index}</i></a></li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
						<li id="next"><a
							href="/board/list.do?boardCode=notice&page=${pageMaker.endPage+1}"><i
								class="fa fa-chevron-right"></i></a></li>
					</c:if>
				</ul>
			</div>
				<form action="/board/list.do" method="post">
				<input type="hidden" name="boardCode" value="notice">
				<input type="hidden" name="page" value="${pageMaker.cri.page}">
					<select name="type"><option value="title" selected>제목</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="keyword" value="${board.keyword}">
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>