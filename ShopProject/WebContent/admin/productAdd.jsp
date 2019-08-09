<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="../js/productAdd.js"></script>

<div class="right">
	<div class="product-add">
		<h1>상품 등록</h1>
		<form name="addForm" action="/admin/product.do" enctype="multipart/form-data" method="post">
		<input type="hidden" name="mode" value="register">
			<table style="margin-bottom: 50px">
				<tr>
					<th>상품 분류</th>
					<td><select id="highCtgry">
							<option value="">- 대분류 선택 -</option>
							<c:forEach var="h" items="${high}">
								<option value="${h.highCtgryNo}">${h.highCtgryName}</option>
							</c:forEach>
					</select>&nbsp;&nbsp; <select name="mediumCtgryNo" id="mediumCtgryNo"><option value="">-
								중분류 선택 -</option>
					</select>&nbsp;&nbsp; <select name="lowCtgryName" id="lowCtgryName"><option
								value="">- 소분류 선택 -</option>
					</select></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="pName"></td>
				</tr>
				<tr>
					<th>판매가</th>
					<td><input type="text" name="price">&nbsp;원</td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td><input type="text" name="pCompany"></td>
				</tr>
				<tr>
					<th>재고수량</th>
					<td><input type="text" name="pStock"></td>
				</tr>
				<tr>
					<th>상품 이미지</th>
					<td><input type="file" name="pImage"></td>
				</tr>
				<tr>
					<th>상품 설명</th>
					<td><input type="file" name="pContent"></td>
				</tr>
			</table>
			<div style="width: 100%">
				<button class="admin-btn" type="button">상품등록</button>
			</div>
		</form>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>