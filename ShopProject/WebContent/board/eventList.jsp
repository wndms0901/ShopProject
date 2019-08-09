<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
				var period = '<c:out value="${board.period}"/>';
				if (period == 'end') {
					$('.event-btn>a:last').attr('id', 'point');
				} else {
					$('.event-btn>a:first').attr('id', 'point');
				}
				$("input[type='hidden']").each(function(index,item) {
					var no = $("input[type='hidden']:eq("+index+")").val();
					if(period==''){
					$(".read").attr("href","/board/list.do?boardCode=event&period=current&no="+ no);
					}
				});
				
				var page ='<c:out value="${pageMaker.cri.page}"/>';
				$(".pageNum").each(function(index,item) {
				var pageNum = $(".pageNum i:eq(" +index+ ")").html();
				if(page==pageNum){
				$(".pageNum:eq("+index+")").addClass("active");
				}
				});
				
				if(page){
					$(".single-products a").each(function(index,item) {
						var url= $(this).attr("href");
						url += "&page="+page;
						$(this).attr("href",url);
					});
				}				
	});
</script>
<section>
	<div style="padding: 0; width: 100%">
		<img src="../images/home/event.jpg" width="100%">
	</div>
	<div class="container">
		<div class="row">
			<div class="event-btn">
				<a href="/board/list.do?boardCode=event&period=current">진행중 이벤트</a><a
					href="/board/list.do?boardCode=event&period=end">종료된 이벤트</a>
			</div>

			<div class="features_items">
				<c:forEach var="e" items="${eventList}">
				<input type="hidden" name="no" value="${e.no}">
					<div class="col-sm-4" style="padding: 0 10px">
						<div class="product-image-wrapper" style="border: 1px solid #ddd">
							<div class="single-products">
								<div class="productinfo text-center">
									<a class="read" href="/board/list.do?boardCode=event&period=${board.period}&no=${e.no}"><img
										src="../images/board/${e.image}" alt="" height="158" /></a>
									<div class="event-info">
										<a class="read" href="/board/list.do?boardCode=event&period=${board.period}&eno=${e.no}">${e.title}</a> <font><fmt:formatDate
												value="${e.eventStart}" pattern="yyyy.MM.dd HH:mm" /> ~ <fmt:formatDate
												value="${e.eventEnd}" pattern="yyyy.MM.dd HH:mm" /></font>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
				<!-- <div class="col-sm-4" style="padding:0 10px">
						<div class="product-image-wrapper" style="border:1px solid #ddd">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="#"><img
										src="../images/event/201904_01image.jpg" alt="" 
										 height="158"/></a>
										 <div class="event-info">
									<a href="#">2019년 4월 이벤트</a>
									<font>2019.04.01 00:00 ~ 2019.04.01 00:00</font>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div class="col-sm-4" style="padding:0 10px">
						<div class="product-image-wrapper" style="border:1px solid #ddd">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="#"><img
										src="../images/event/201904_01image.jpg" alt="" 
										 height="158"/></a>
										 <div class="event-info">
									<a href="#">2019년 4월 이벤트</a>
									<font>2019.04.01 00:00 ~ 2019.04.01 00:00</font>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div class="col-sm-4" style="padding:0 10px">
						<div class="product-image-wrapper" style="border:1px solid #ddd">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="#"><img
										src="../images/event/201904_01image.jpg" alt="" 
										 height="158"/></a>
										 <div class="event-info">
									<a href="#">2019년 4월 이벤트</a>
									<font>2019.04.01 00:00 ~ 2019.04.01 00:00</font>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div class="col-sm-4" style="padding:0 10px">
						<div class="product-image-wrapper" style="border:1px solid #ddd">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="#"><img
										src="../images/event/201904_01image.jpg" alt="" 
										 height="158"/></a>
										 <div class="event-info">
									<a href="#">2019년 4월 이벤트</a>
									<font>2019.04.01 00:00 ~ 2019.04.01 00:00</font>
								</div>
							</div>
						</div>
					</div>
					</div> -->
			</div>
			<div style="text-align: center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li id="prev"><a
							href="/board/list.do?boardCode=event&period=${board.period}&page=${pageMaker.startPage-1}"><i
								class="fa fa-chevron-left"></i></a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="index">
						<li class="pageNum"><a
							href="/board/list.do?boardCode=event&period=${board.period}&page=${index}"><i
								class="fa">${index}</i></a></li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
						<li id="next"><a
							href="/board/list.do?boardCode=event&period=${board.period}&page=${pageMaker.endPage+1}"><i
								class="fa fa-chevron-right"></i></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>