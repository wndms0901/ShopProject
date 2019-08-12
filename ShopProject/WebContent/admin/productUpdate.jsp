<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="../css/admin.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="../js/ajax.js"></script>
<script src="../js/productUpdate.js"></script>

<script type="text/javascript">
$(document).ready(function() {
		//상품 카테고리 출력
		var mCtgryNo = '<c:out value="${product.mediumCtgryNo}"/>';
		var mCtgryName = '<c:out value="${product.mediumCtgryName}"/>';
		var lowCtgryName = '<c:out value="${product.lowCtgryName}"/>';
		var mediumCtgryNo = new Array();
		var mediumCtgryName = new Array();
		var lowName = new Array();
	
	if(mCtgryNo =='1'){
		$("#highCtgry").val(mCtgryNo).prop("selected", true); //대분류 선택
		//중분류 name, no 배열에 담기
		<c:forEach items="${medium}" var="m">
		<c:forEach items="${m}" var="list">
		mediumCtgryNo.push("${list.mediumCtgryNo}");
		mediumCtgryName.push("${list.mediumCtgryName}");
		</c:forEach>
		</c:forEach>
		// 소분류 name 배열에 담기
		<c:forEach items="${low[0]}" var="l">
		lowName.push("${l.lowCtgryName}");
		</c:forEach>
		//중분류 option append
		$("#mediumCtgryNo").append("<option value='"+mediumCtgryNo[mCtgryNo-1]+"'>"+mediumCtgryName[mCtgryNo-1]+"</option>")
		//소분류 option append
		for (var i = 0; i <lowName.length; i++) {
		$("#lowCtgryName").append("<option value='"+lowName[i]+"'>"+lowName[i]+"</option>")
		}
		
		$("#mediumCtgryNo").val(mCtgryNo).prop("selected", true);
		$("#lowCtgryName").val(lowCtgryName).prop("selected", true);
	}else if(mCtgryNo =='2'){
		$("#highCtgry").val(mCtgryNo).prop("selected", true); //대분류 선택
		//중분류 name, no 배열에 담기
		<c:forEach items="${medium}" var="m">
		<c:forEach items="${m}" var="list">
		mediumCtgryNo.push("${list.mediumCtgryNo}");
		mediumCtgryName.push("${list.mediumCtgryName}");
		</c:forEach>
		</c:forEach>
		// 소분류 name 배열에 담기
		<c:forEach items="${low[1]}" var="l">
		lowName.push("${l.lowCtgryName}");
		</c:forEach>
		//중분류 option append
		$("#mediumCtgryNo").append("<option value='"+mediumCtgryNo[mCtgryNo-1]+"'>"+mediumCtgryName[mCtgryNo-1]+"</option>")
		//소분류 option append
		for (var i = 0; i <lowName.length; i++) {
		$("#lowCtgryName").append("<option value='"+lowName[i]+"'>"+lowName[i]+"</option>")
		}
		
		$("#mediumCtgryNo").val(mCtgryNo).prop("selected", true);
		$("#lowCtgryName").val(lowCtgryName).prop("selected", true);
	}else{
		$("#highCtgry").val(3).prop("selected", true); //대분류 선택
		//중분류 name, no 배열에 담기
		<c:forEach items="${medium}" var="m">
		<c:forEach items="${m}" var="list">
		mediumCtgryNo.push("${list.mediumCtgryNo}");
		mediumCtgryName.push("${list.mediumCtgryName}");
		</c:forEach>
		</c:forEach>
		//중분류 option append
		for (var i = 2; i <mediumCtgryNo.length; i++) {
		$("#mediumCtgryNo").append("<option value='"+mediumCtgryNo[i]+"'>"+mediumCtgryName[i]+"</option>")
		}
		
		if(mCtgryNo=='3'){ //햄스터 소분류
			// 소분류 name 배열에 담기
			<c:forEach items="${low[2]}" var="l">
			lowName.push("${l.lowCtgryName}");
			</c:forEach>
		}
		if(mCtgryNo=='4'){ //고슴도치 소분류
			// 소분류 name 배열에 담기
			<c:forEach items="${low[3]}" var="l">
			lowName.push("${l.lowCtgryName}");
			</c:forEach>
		}
		if(mCtgryNo=='5'){ //토끼 소분류
			// 소분류 name 배열에 담기
			<c:forEach items="${low[4]}" var="l">
			lowName.push("${l.lowCtgryName}");
			</c:forEach>
		}
		//소분류 option append
		for (var i = 0; i <lowName.length; i++) {
		$("#lowCtgryName").append("<option value='"+lowName[i]+"'>"+lowName[i]+"</option>")
		}
		
		$("#mediumCtgryNo").val(mCtgryNo).prop("selected", true);
		$("#lowCtgryName").val(lowCtgryName).prop("selected", true);
	}
	
	//상품상태 선택
	var pStatus = '<c:out value="${product.pStatus}"/>';
	$("select[name='pStatus']").val(pStatus);
	
});

</script>
</head>
<body style="min-width:800px;max-width:920px;background-color:#ECF0F7">
<div class="product-update">
		<h1>상품 수정</h1>
		<form name="updateForm">
		<input type="hidden" name="mode" value="update">
		<input type="hidden" name="pno" value="${product.pno}">
			<table>
			<tr>
			<th>상품번호</th>
			<td colspan="2">${product.pno}</td>
			</tr>
				<tr>
					<th>상품 분류</th>
					<td colspan="2"><select id="highCtgry">
							<option value="">- 대분류 선택 -</option>
							<c:forEach var="h" items="${high}">
								<option value="${h.highCtgryNo}">${h.highCtgryName}</option>
							</c:forEach>
					</select>&nbsp;&nbsp; <select name="mediumCtgryNo" id="mediumCtgryNo"><option value="">- 중분류 선택 -</option>
					</select>&nbsp;&nbsp; <select name="lowCtgryName" id="lowCtgryName"><option
								value="">- 소분류 선택 -</option>
					</select></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td colspan="2"><input type="text" name="pName" value="${product.pName}" size="40"></td>
				</tr>
				<tr>
					<th>판매가</th>
					<td colspan="2"><input type="text" name="price" value="${product.price}">&nbsp;원</td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td colspan="2"><input type="text" name="pCompany" value="${product.pCompany}"></td>
				</tr>
				<tr>
					<th>재고수량</th>
					<td colspan="2"><input type="text" name="pStock" value="${product.pStock}"></td>
				</tr>
				<tr>
				<th>상품상태</th>
				<td colspan="2"><select name="pStatus">
				<option>정상</option>
				<option>품절</option>
				<option>판매중단</option>
				</select></td>
				</tr>
				<tr>
					<th rowspan="2">상품 이미지</th>
					<td>현재이미지&nbsp;:&nbsp;${product.pImage}</td>
					<td>변경할 이미지</td>
				</tr>
				<tr><td style="text-align:center"><img src="../images/product/${product.pImage}" width="200px" height="200px"></td>
				<td><input type="file" name="pImage"></td></tr>
				<tr>
					<th rowspan="2">상품 설명</th>
					<td>현재이미지&nbsp;:&nbsp;${product.pContent}</td>
					<td>변경할 이미지</td>
				</tr>
				<tr>
					<td style="text-align:center">
					<button type="button" data-toggle="modal" data-target="#pContent">이미지 보기</button>
				
					</td>
					<td><input type="file" name="pContent"></td>
				</tr>
			</table>
			<div>
				<button class="admin-btn">상품수정</button>
			</div>
		</form>
	</div>
	<div class="modal fade" id="pContent" role="dialog">
	<div class="modal-dialog" style="margin:20px;width:850px">
	<!-- Modal content-->
		<div class="modal-content" >
			<div class="modal-header" style="border: 0;padding:15px 22px">
				<button type="button" class="close" data-dismiss="modal"
					style="font-size: 30px">×</button>
			</div>
			<div class="modal-body"
				style="text-align: center; padding: 0px 20px 0px 20px">
				<p>
				<img src="../images/product/${product.pContent}" width="800px">
				</p>
			</div>
		</div>
		</div>
		</div>
</body>
</html>