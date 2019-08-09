<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">

$(document).ready(function(){
	var pName ="${pName}";
	var pCompany = "${pCompany}";
	var sort = "${sort}"; 
	if(pName!=''){ /* 상품명으로 검색 */
		$('#type option[value=pName]').attr('selected','selected');
		$('#keyword').html("\""+pName+"\"");
		$('#new').attr('href','search.do?pName='+pName+'&sort=new');
		$('#popular').attr('href','search.do?pName='+pName+'&sort=popular');
		$('#lowPrice').attr('href','search.do?pName='+pName+'&sort=lowPrice');
		$('#highPrice').attr('href','search.do?pName='+pName+'&sort=highPrice');
		$('#word').val(pName);
		var prev =$("#prev a").attr("href");
		var next =$("#next a").attr("href");
		prev+="&pName="+pName;
		$("#prev a").attr("href",prev);
		next+="&pName="+pName;
		$("#next a").attr("href", next);
	 $(".pageNum a").each(function(index,item) {
			var url= $(this).attr("href");
			 url += "&pName="+pName;
			$(this).attr("href",url);
		}); 
	}else if(pCompany!=''){ /* 브랜드로 검색 */
		$('#type option[value=pCompany]').attr('selected','selected');
		$('#keyword').html("\""+pCompany+"\"");
		$('#new').attr('href','search.do?pCompany='+pCompany+'&sort=new');
		$('#popular').attr('href','search.do?pCompany='+pCompany+'&sort=popular');
		$('#lowPrice').attr('href','search.do?pCompany='+pCompany+'&sort=lowPrice');
		$('#highPrice').attr('href','search.do?pCompany='+pCompany+'&sort=highPrice');
		$('#word').val(pCompany);
		var prev =$("#prev a").attr("href");
		var next =$("#next a").attr("href");
		prev+="&pCompany="+pCompany;
		next+="&pCompany="+pCompany;
		$("#prev a").attr("href",prev);
		$("#next a").attr("href",next);
	 $(".pageNum a").each(function(index,item) {
			var url= $(this).attr("href");
			 url += "&pCompany="+pCompany;
			$(this).attr("href",url);
	});
	}
	
	if(sort){
		var prev =$("#prev a").attr("href");
		var next =$("#next a").attr("href");
		prev+="&sort="+sort;
		next+="&sort="+sort;
		$("#prev a").attr("href",prev);
		$("#next a").attr("href",next);
	 $(".pageNum a").each(function(index,item) {
			var url= $(this).attr("href");
			 url += "&sort="+sort;
			$(this).attr("href",url);
	});
	}
	var page ='<c:out value="${pageMaker.cri.page}"/>';
	$(".pageNum").each(function(index,item) {
	var pageNum = $(".pageNum i:eq(" +index+ ")").html();
	if(page==pageNum){
	$(".pageNum:eq("+index+")").addClass("active");
	}
	});
	
	
	$("form").submit(function(){
		var type=$("#type option:selected").val();
		 $("input[type=text]").attr('name',type);
	});

});
</script>
<section>
	<div class="container">
		<div class="row">
		<form action="/product/search.do">
		<h2 style="margin-top:60px;">상품검색</h2>
	<table class="search">
	<tr><th>
	<select id="type">
	<option value="pName">상품명</option>
	<option value="pCompany">브랜드</option>
		</select>
		<input type="text" id="word" name="">
		<input type="submit" value="검색">
		</th></tr>
	</table>
	</form>
	<p><font id="keyword" style="font-size:20px;color:#e92b2b;font-weight:bold;"></font> 
	<font style="font-size:20px;">검색결과</font>
	<font style="font-size:20px;font-weight:bold;">${searchTotal}개</font> </p>
			<div style="margin-bottom:50px">
			<hr style="margin-top:0">
					<a id="new" href="search.do?sort=new">신규상품순</a>
					<font>|</font> <a id="popular"
						href="search.do?sort=popular">판매인기순</a>
					<font>|</font> <a id="lowPrice"
						href="search.do?sort=lowPrice">낮은가격순</a>
					<font>|</font> <a id="highPrice"
						href="search.do?sort=highPrice">높은가격순</a>
			</div>
			<c:choose>
			<c:when test="${fn:length(products)>0}">
			<!--features_items-->
			<div class="features_items" style="display: table;width:100%">
				<c:forEach var="p" items="${products}">
					<div class="col-sm-4">
						<div class="product-image-wrapper">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="/product/view.do?pno=${p.pno}"><img
										src="../images/product/${p.pImage}" alt="" /></a>
									<h2>${p.pName}</h2>
									<p>${p.price}</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>
			<!--features_items-->
			
			</c:when>
			<c:when test="${fn:length(products)==0}">
			<div id="empty"><p>상품이 존재하지 않습니다.</p></div>
			</c:when>
			</c:choose>
			<div style="text-align: center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li id="prev"><a
							href="/product/search.do?page=${pageMaker.startPage-1}"><i
								class="fa fa-chevron-left"></i></a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="index">
						<li class="pageNum"><a
							href="/product/search.do?page=${index}"><i
								class="fa">${index}</i></a></li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
						<li id="next"><a
							href="/product/search.do?page=${pageMaker.endPage+1}"><i
								class="fa fa-chevron-right"></i></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>