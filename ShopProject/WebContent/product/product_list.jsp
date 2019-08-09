<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
	var length = '<c:out value="${fn:length(lowCtgry)}"/>';
	var width = 100/(Number(length)+1);
	$('.lowCtgry li').css('width',width+'%');
	
	var lowNo = '<c:out value="${lowNo}"/>';
	if(lowNo==''){
		$("#all").addClass("active");
	}else{
		$(".low a").each(function(index,item) {
			var href = $(this).attr("href");
			var num = href.split("lowNo=");
			if(lowNo==num[1]){
		$(".low:eq("+index+")").addClass("active");
			}
		});
	}
		
		var page ='<c:out value="${pageMaker.cri.page}"/>';
		$(".pageNum").each(function(index,item) {
		var pageNum = $(".pageNum i:eq("+index+")").html();
		if(page==pageNum){
		$(".pageNum:eq("+index+")").addClass("active");
		}
		});
});
</script>

<section>
	<div class="container">
		<div class="row">
			<!--category-tab-->
			<div class="category-tab"
				style="margin-top: 40px; margin-bottom: 60px;">
				<div class="col-sm-12">
					<h2 style="margin-bottom: 20px;">${lowCtgry[0].mediumCtgryName}</h2>
					<div class="lowCtgry">
						<ul class="nav nav-tabs">
								<li id="all"><a
									href="/product/list.do?mCode=${lowCtgry[0].mediumCtgryCode}">All</a></li>
							<c:forEach var="low" items="${lowCtgry}" varStatus="status">
								<li class="low"><a
										href="/product/list.do?mCode=${low.mediumCtgryCode}&lowNo=${low.lowCtgryNo}">${low.lowCtgryName }</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>

			</div>
			<!--/category-tab-->
			<div style="margin-bottom: 50px;">
				<hr>
				<a href="/product/list.do?mCode=${mCode}&lowNo=${lowNo}&sort=new">신규상품순</a>
				<font>|</font> <a
					href="/product/list.do?mCode=${mCode}&lowNo=${lowNo}&sort=popular">판매인기순</a>
				<font>|</font> <a
					href="/product/list.do?mCode=${mCode}&lowNo=${lowNo}&sort=lowPrice">낮은가격순</a>
				<font>|</font> <a
					href="/product/list.do?mCode=${mCode}&lowNo=${lowNo}&sort=highPrice">높은가격순</a>
			</div>
			<!--features_items-->
			<div class="features_items" style="display: table; width: 100%">
				<c:forEach var="p" items="${products }">
					<div class="col-sm-4">
						<div class="product-image-wrapper">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="/product/view.do?pno=${p.pno }"><img
										src="../images/product/${p.pImage }" alt="" /></a>
									<h2>${p.pName }</h2>
									<p>
										<fmt:formatNumber type="number" maxFractionDigits="3"
											value="${p.price}" />
										원
									</p>
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
						<li><a
							href="/product/list.do?mCode=${mCode}&lowNo=${lowNo}&sort=${sort}&page=${pageMaker.startPage-1 }"><i
								class="fa fa-chevron-left"></i></a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="index">
						<li class="pageNum"><a
							href="/product/list.do?mCode=${mCode}&lowNo=${lowNo}&sort=${sort}&page=${index}"><i
								class="fa">${index}</i></a></li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
						<li><a
							href="/product/list.do?mCode=${mCode}&lowNo=${lowNo}&sort=${sort}&page=${pageMaker.endPage+1}"><i
								class="fa fa-chevron-right"></i></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>