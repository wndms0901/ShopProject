<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Home | PET MART</title>
<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery.scrollUp.min.js"></script>
<script src="../js/price-range.js"></script>
<script src="../js/jquery.prettyPhoto.js"></script>
<script src="../js/main.js"></script>
<script src="../js/ajax.js"></script>

<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/font-awesome.min.css" rel="stylesheet">
<link href="../css/prettyPhoto.css" rel="stylesheet">
<link href="../css/price-range.css" rel="stylesheet">
<link href="../css/animate.css" rel="stylesheet">
<link href="../css/main.css" rel="stylesheet"> 
<link href="../css/responsive.css" rel="stylesheet">
<link href="../css/modify.css" rel="stylesheet">
<link rel="shortcut icon" href="../images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="../images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="../images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="../images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="../images/ico/apple-touch-icon-57-precomposed.png">
</head>
<!--/head-->

<body>
	<header id="header">

		<div class="header-middle" style="height: 170px;">
			<!--header-middle-->
			<div class="container" style="padding: 0px;">
				<div class="row" style="height: 135px; line-height: 135px">
					<div class="col-sm-4"
						style="width: 28%; float: left; padding-top: 10px">
						<div class="logo pull-left" style="margin-left: 0px;">
							<a href="../main/list.do"><img src="../images/home/logo1.png"
								width="175px" height="125px" alt="" /></a>
						</div>
					</div>
					<form action="/product/search.do">
						<div class="search_box">
							<input type="text" name="pName" placeholder="Search" /><input type="submit" value="">
						</div>
					</form>
					<div class="col-sm-8"
						style="float: left; width: 33%; padding-top: 55px;">
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
								<c:if test="${empty sessionScope.mbId}">
									<li><a href="/member/login.do"><img
											src="../images/home/로그인.png"></a></li>
									<li><a href="/member/join.do"><img
											src="../images/home/회원가입.png"></a></li>
								</c:if>
								<c:if test="${!empty sessionScope.mbId}">
									<li><a href="/member/logout.do"><img
											src="../images/home/로그아웃.png"></a></li>
									<li><a href="/member/mypage.do"><img src="../images/home/마이페이지.png"></a></li>
								</c:if>
								<li><a href="/member/mypage.do?go=order"><img src="../images/home/주문배송.png"></a></li>
								<li><a href="/order/cart.do"><img
										src="../images/home/장바구니.png"></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--/header-middle-->
		<div class="header-bottom">
			<!--header-bottom-->
			<div class="container">
				<div class="row">
					<div class="col-sm-9" style="padding: 0px;">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
						</div>
						<div class="mainmenu pull-left"
							style="width: 100%; margin-left: 0px;">
							<ul class="nav navbar-nav collapse navbar-collapse"
								style="width:100%;">
								<li class="dropdown" id="totalCtgry">
								<button data-toggle="modal" data-target="#menu"><img src="../images/home/menu.png"><font>전체카테고리</font></button>
								</li>
								<c:forEach var="h" items="${high}">
									<!-- 대분류 -->
									<li class="dropdown" style="width: 12%; padding-left: 30px;">
										<c:choose>
											<c:when test="${h.highCtgryCode == 'small'}">
												<!-- 소동물 -->
												<a
													href="/product/list.do?mCode=${small[0].mediumCtgryCode }">${h.highCtgryName}<i
													class="fa fa-angle-down"></i></a>
											</c:when>
											<c:otherwise>
												<!-- 강아지, 고양이 -->
												<a href="/product/list.do?mCode=${h.highCtgryCode}">${h.highCtgryName}<i
													class="fa fa-angle-down"></i></a>
											</c:otherwise>
										</c:choose>
										<ul role="menu" class="sub-menu">
											<!-- 소분류 -->
											<c:if test="${h.highCtgryNo == 1 }">
												<!-- 강아지 카테고리 -->
												<li><c:forEach var="l" items="${low1 }">
														<a id="subMenu"
															href="/product/list.do?mCode=${h.highCtgryCode}&lowNo=${l.lowCtgryNo}">${l.lowCtgryName }</a>
													</c:forEach></li>
											</c:if>
											<c:if test="${h.highCtgryNo == 2 }">
												<!-- 고양이 카테고리 -->
												<li><c:forEach var="l" items="${low2 }">
														<a id="subMenu"
															href="/product/list.do?mCode=${h.highCtgryCode}&lowNo=${l.lowCtgryNo}">${l.lowCtgryName }</a>
													</c:forEach></li>
											</c:if>
											<c:if test="${h.highCtgryNo == 3 }">
												<!-- 소동물 종류 -->
												<c:forEach var="s" items="${small }">
													<li><a
														href="/product/list.do?mCode=${s.mediumCtgryCode}">${s.mediumCtgryName }</a></li>
												</c:forEach>
											</c:if>
										</ul>
									</li>
								</c:forEach>
								<li style="width: 12%"><a href="/product/new.do">신상품</a></li>
								<li style="width: 12%"><a href="/product/best.do">베스트</a></li>
								<li style="width: 12%"><a href="/board/list.do?boardCode=event">이벤트</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--/header-bottom-->
	</header>
	<!--/header-->
	
	<!-- Modal -->
  <div class="modal fade" id="menu" role="dialog">
    <div class="modal-dialog" style="width:70%;">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="border:0">
          <button type="button" class="close" data-dismiss="modal" style="font-size:25px">×</button>
        </div>
        <div class="modal-body" style="height:450px;">
        <c:forEach var="ctgry" items="${list}">
        <div class="allCtgry">
        <a href="/product/list.do?mCode=${ctgry[0].mediumCtgryCode}">${ctgry[0].mediumCtgryName}</a>
        <hr>
        <ul>
        <c:forEach var="c" items="${ctgry}">
        <li><a href="/product/list.do?mCode=${c.mediumCtgryCode}&lowNo=${c.lowCtgryNo}">${c.lowCtgryName}</a></li>
        </c:forEach>
        </ul>
        </div>
        </c:forEach>
        </div>
        <div class="modal-footer" style="text-align:left;margin:0">
        <div class="allCtgry">
        <a>공지사항</a>
        <hr>
        <ul>
        <li><a href="/board/list.do?boardCode=notice">공지사항</a></li>
        </ul>
        </div>
         <div class="allCtgry">
        <a>게시판</a>
        <hr>
        <ul>
        <li><a href="/product/new.do">신상품</a></li>
        <li><a href="/product/best.do">베스트</a></li>
        <li><a href="/board/list.do?boardCode=event">이벤트</a></li>
        </ul>
        </div>
        </div>
      </div>
    </div>
  </div>