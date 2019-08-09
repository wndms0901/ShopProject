<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script>
	function AddComma(data_value) { //숫자 3자리 단위마다 ,추가하기
		return Number(data_value).toLocaleString('en');
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var used = 0;
		var use = 0;
		var total =0;
		<c:forEach var="m" items="${mileage}">
			var value = ${m.mileage};
			if(value>0){
				total+=value;
			}else{
				used+=value;
			}
		</c:forEach>
		use = total + used;
		if(used<0){
			used = -used;
		}
		$("#total").html(AddComma(total)+"원");
		$("#used").html(AddComma(used)+"원");
		$("#use").html(AddComma(use)+"원");
		
		$(".mileage").each(function(index,item) {
			var mileage = $(".mileage:eq("+index+")").html();
			//mileage = mileage.replace("-","");
			$(".mileage:eq("+index+")").html(AddComma(Number(mileage))+"원");
		});
		
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
					<a href="/member/mypage.do?go=order">주문내역 조회</a><a id="point"
						href="/member/mypage.do?go=mileage">적립금 조회</a><a
						href="/member/mypage.do?go=info">회원 정보</a>
				</div>
				<h3>적립금 조회</h3>
				<table class="mileage-tb1">
					<tr>
						<td>총 적립금</td>
						<td id="total"></td>
					</tr>
					<tr>
						<td>사용된 적립금</td>
						<td id="used"></td>
					</tr>
					<tr>
						<td>사용가능 적립금</td>
						<td id="use"></td>
					</tr>
				</table>
				<table class="mileage-tb2">
					<tr>
						<th width="20%">주문날짜</th>
						<th width="20%">적립금</th>
						<th width="20%">관련 주문</th>
						<th width="40%">적립내용</th>
					</tr>
					<c:forEach var="m" items="${mileage}">
						<tr>
							<th>${m.mileageDate}</th>
							<th class="mileage">${m.mileage}</th>
							<th><a href="/member/mypage.do?orderId=${m.orderId}">${m.orderId}</a></th>
							<th>${m.content}</th>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div style="text-align: center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li id="prev"><a
							href="/member/mypage.do?go=mileage&page=${pageMaker.startPage-1}"><i
								class="fa fa-chevron-left"></i></a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="index">
						<li class="pageNum"><a
							href="/member/mypage.do?go=mileage&page=${index}"><i
								class="fa">${index}</i></a></li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
						<li id="next"><a
							href="/member/mypage.do?go=mileage&page=${pageMaker.endPage+1}"><i
								class="fa fa-chevron-right"></i></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>

<%@include file="../includes/footer.jsp"%>