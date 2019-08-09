<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	var page ='<c:out value="${pageMaker.cri.page}"/>';
		$(".pageNum").each(function(index,item) {
		var pageNum = $(".pageNum i:eq(" +index+ ")").html();
		if(page==pageNum){
		$(".pageNum:eq("+index+")").addClass("active");
		}
		});
});
</script>
<section>
	<div style="padding: 0;width:100%">
		<img src="../images/home/new.jpg" width="100%">
	</div>
	<div class="container">
		<div class="row">
			<div style="margin-top: 100px;margin-bottom:50px">
			<hr>
					<a href="new.do?sort=new">신규상품순</a>
					<font>|</font> <a
						href="new.do?sort=popular">판매인기순</a>
					<font>|</font> <a
						href="new.do?sort=lowPrice">낮은가격순</a>
					<font>|</font> <a
						href="new.do?sort=highPrice">높은가격순</a>
			</div>
			<!--features_items-->
			<div class="features_items" style="display: table; width: 100%">
				<c:forEach var="p" items="${products}">
					<div class="col-sm-4">
						<div class="product-image-wrapper">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="/product/view.do?pno=${p.pno}"><img
										src="../images/product/${p.pImage}" alt="" /></a>
									<h2>${p.pName}</h2>
									<p>${p.price}원</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>
			<!--features_items-->
			<div style="text-align: center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li id="prev"><a
							href="/product/new.do?sort=${sort}&page=${pageMaker.startPage-1}"><i
								class="fa fa-chevron-left"></i></a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="index">
						<li class="pageNum"><a
							href="/product/new.do?sort=${sort}&page=${index}"><i
								class="fa">${index}</i></a></li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
						<li id="next"><a
							href="/product/new.do?sort=${sort}&page=${pageMaker.endPage+1}"><i
								class="fa fa-chevron-right"></i></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>