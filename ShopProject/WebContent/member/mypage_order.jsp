<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		var orderDate = new Array();
		var orderId = new Array();
		var orderState = new Array();
		var list = new Array(); //orderList 개수 
		
		<c:forEach var="order" items="${orderList}">
			orderDate.push("${order.orderDate}");
			orderId.push("${order.orderId}");
			orderState.push("${order.orderState}");
			list.push("${fn:length(order.orderList)}");
		</c:forEach>
		
		var page ='<c:out value="${pageMaker.cri.page}"/>';
		var index = 0;
		for (var i = 0; i < list.length; i++) {
			var date = orderDate[i].substr(orderDate[i].length - 2, 2);
		$(".content:eq(" + index + ")").prepend("<td class='orderDate' rowspan='"+list[i]+"' style='border-bottom:1px solid #ccc'>"
			+ orderDate[i].substr(0,orderDate[i].length - 2)+ "</td>");
		$(".content:eq(" + index + ")").append("<td style='border-left:1px solid #ccc;border-bottom:1px solid #ccc' rowspan='"+list[i]+"'>"
			+ orderState[i] + "</td>");
		$(".orderDate:eq(" + i + ")").after("<td style='border-left:1px solid #ccc;border-bottom:1px solid #ccc' rowspan='"
				+list[i]+"'><a href='/member/mypage.do?orderId="+ orderId[i] + "&page="+page+"'>" + orderId[i]+ "</a></td>");
		index += Number(list[i]);
	}
		$(".orderList-tb tr:last-child").css("border-bottom","1px solid #ccc");
		
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
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="mypage-btn">
					<a id="point" href="/member/mypage.do?go=order">주문내역 조회</a><a
						href="/member/mypage.do?go=mileage">적립금 조회</a><a href="/member/mypage.do?go=info">회원 정보</a>
				</div>
				<h3>주문내역 조회</h3>
				<table class="orderList-tb">
					<tr>
						<th width="15%">주문일자</th>
						<th width="15%">주문번호</th>
						<th colspan="2">주문상품</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>주문상태</th>
					</tr>
					<c:if test="${fn:length(orderList) > 0}">
					<c:forEach var="order" items="${orderList}">
						<c:forEach var="list" items="${order.orderList}">
							<tr class="content">
								<td width="5%" style="border-left: 1px solid #ccc;padding:7px"><img src="../images/product/${list.pImage}"
									width="110px" height="110px"></td>
								<td style="text-align: left; padding-left: 20px"><a
									href="/product/view.do?pno=${list.pno}">${list.pName}</a></td>
								<td>${list.pQuantity}</td>
								<td>${list.price}</td>
								<%-- 	<td>${order.orderState}</td> --%>
							</tr>
						</c:forEach>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(orderList) == 0}">
					<tr id="empty"><td colspan="7">주문내역이 없습니다.</td></tr>
					</c:if>
				</table>
			</div>
			<div style="text-align: center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li id="prev"><a
							href="/member/mypage.do?go=order&page=${pageMaker.startPage-1}"><i
								class="fa fa-chevron-left"></i></a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="index">
						<li class="pageNum"><a
							href="/member/mypage.do?go=order&page=${index}"><i
								class="fa">${index}</i></a></li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
						<li id="next"><a
							href="/member/mypage.do?go=order&page=${pageMaker.endPage+1}"><i
								class="fa fa-chevron-right"></i></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>