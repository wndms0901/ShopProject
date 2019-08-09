<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$(".category-tab li").each(function(index,item) { /* 강아지, 고양이 베스트 상품 출력 */
			var value= $(".category-tab li a:eq("+index+")").attr("href");
			value= value.replace("#","");
			var mCode = value.substr(0,3);
			var lowCode = value.substr(3);
			var params = "?mCode="+mCode+"&lowCode="+lowCode;
			productService.bestProduct(params);
		});
	$("#btn2").click(function(){ //강아지 버튼 클릭
		$( "#btn2" ).css( "background-color", "#FEBA0F" );
		$( "#btn2" ).css( "color", "white" );
		$( "#btn3" ).css( "background-color", "white" );
		$( "#btn3" ).css( "color", "gray" );
		$(".dog").css("display","block"); /* 강아지 카테고리, 상품 보기 */
		$(".cat").css("display","none"); /* 고양이 카테고리, 상품 숨김 */
	});
	
	$("#btn3").click(function(){ //고양이 버튼 클릭
		$( "#btn3" ).css( "background-color", "#FEBA0F" );
		$( "#btn3" ).css( "color", "white" );
		$( "#btn2" ).css( "background-color", "white" );
		$( "#btn2" ).css( "color", "gray" );
		$(".cat").css("display","block"); /* 고양이 카테고리, 상품 보기 */
		$(".dog").css("display","none"); /* 강아지 카테고리, 상품 숨김 */
	});
	
});
</script>
<section id="slider">
	<!--slider-->
	<!-- <div class="container"> -->
	<div class="row" style="margin: 0">
		<div class="col-sm-12" style="padding: 0">
			<div id="slider-carousel" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#slider-carousel" data-slide-to="0" class="active"></li>
					<li data-target="#slider-carousel" data-slide-to="1"></li>
					<li data-target="#slider-carousel" data-slide-to="2"></li>
				</ol>

				<div class="carousel-inner">
					<div class="item active">
						<div class="col-sm-12"
							style="padding-right: 0px; padding-left: 0px;">
							<img src="../images/home/slide01.jpg" class="girl img-responsive"
								alt="" onclick="location.href='#'" />
						</div>
					</div>
					<div class="item">
						<div class="col-sm-12"
							style="padding-right: 0px; padding-left: 0px;">
							<img src="../images/home/slide02.jpg" class="girl img-responsive"
								alt="" />
						</div>
					</div>

					<div class="item">
						<div class="col-sm-12"
							style="padding-right: 0px; padding-left: 0px;">
							<img src="../images/home/slide03.jpg" class="girl img-responsive"
								alt="" />
						</div>
					</div>

				</div>

				<a href="#slider-carousel" class="left control-carousel hidden-xs"
					data-slide="prev" style="top: 45%; margin: 0 50px;"> <i
					class="fa fa-angle-left"></i>
				</a> <a href="#slider-carousel" class="right control-carousel hidden-xs"
					data-slide="next" style="top: 45%; margin: 0 50px;"> <i
					class="fa fa-angle-right"></i>
				</a>
			</div>

		</div>
	</div>
	<!-- </div> -->
</section>
<!--/slider-->

<section>
	<div class="container">
		<div class="row">

			<!--features_items-->
			<div class="features_items">
				<div class="more">
					<p>
						<button id="btn1" onclick="location.href='../product/new.do'">+
							더보기</button>
					</p>
				</div>
				<h2 class="title text-center">NEW 신상품</h2>
				<c:forEach var="nw" items="${newProduct}">
					<div class="col-sm-4">
						<div class="product-image-wrapper">
							<div class="single-products">
								<div class="productinfo text-center">
									<a href="/product/view.do?pno=${nw.pno }"><img
										src="../images/product/${nw.pImage }" alt="" /></a>
									<h2>${nw.pName }</h2>
									<p id="price">
										<fmt:formatNumber type="number" maxFractionDigits="3"
											value="${nw.price}"/>원
									</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!--features_items-->
			<!--category-tab-->
			<div class="category-tab">
				<div class="more">
					<p>
						<button id="btn2">강아지</button><button id="btn3">고양이</button>
					</p>
				</div>
				<h2 class="title text-center">BEST 상품</h2>
				<div class="col-sm-12">
				
				<div class="dog"> <!-- 강아지 카테고리 -->
					<ul class="nav nav-tabs">
						<li class="active" style="width: 16.6%;"><a href="#dogfeed"
							data-toggle="tab"
							style="padding: 40px; text-align: center;">사료</a></li>
						<li style="width: 16.6%;"><a href="#dogsnack"
							data-toggle="tab" style="padding: 40px; text-align: center;">간식</a></li>
						<li style="width: 16.6%;"><a href="#dogcleanliness"
							data-toggle="tab" style="padding: 40px; text-align: center;">위생</a></li>
						<li style="width: 17%;"><a href="#dogbath" data-toggle="tab"
							style="padding: 40px; text-align: center;"
							>미용/목욕</a></li>
						<li style="width: 16.6%;"><a href="#doghouse"
							data-toggle="tab" style="padding: 40px; text-align: center;"
						 	>하우스</a></li>
						<li style="width: 16.6%;"><a href="#dogtoy"
							data-toggle="tab" style="padding: 40px; text-align: center;"
							>장난감</a></li>
					</ul>
					</div>
					<div class="cat" style="display:none"> <!-- 고양이 카테고리 -->
					<ul class="nav nav-tabs">
						<li class="active" style="width: 16.6%;"><a href="#catfeed"
							data-toggle="tab"
							style="padding: 40px; text-align: center;">사료</a></li>
						<li style="width: 16.6%;"><a href="#catsnack"
							data-toggle="tab" style="padding: 40px; text-align: center;">간식</a></li>
						<li style="width: 16.6%;"><a href="#catcleanliness"
							data-toggle="tab" style="padding: 40px; text-align: center;">위생</a></li>
						<li style="width: 17%;"><a href="#catbath" data-toggle="tab"
							style="padding: 40px; text-align: center;"
							>미용/목욕</a></li>
						<li style="width: 16.6%;"><a href="#cathouse"
							data-toggle="tab" style="padding: 40px; text-align: center;"
						 	>하우스</a></li>
						<li style="width: 16.6%;"><a href="#cattoy"
							data-toggle="tab" style="padding: 40px; text-align: center;"
							>장난감</a></li>
					</ul>
					</div>
				</div>
				<div class="dog"> <!-- 강아지 베스트 상품목록 -->
				<div class="tab-content">
				<div class='tab-pane fade active in' id='dogfeed'></div>
				<div class='tab-pane fade' id='dogsnack'></div>
				<div class='tab-pane fade' id='dogcleanliness'></div>
				<div class='tab-pane fade' id='dogbath'></div>
				<div class='tab-pane fade' id='doghouse'></div>
				<div class='tab-pane fade' id='dogtoy'></div>
				</div>
				</div>
				<div class="cat" style="display:none"> <!-- 고양이 베스트 상품목록 -->
				<div class="tab-content">
				<div class='tab-pane fade active in' id='catfeed'></div>
				<div class='tab-pane fade' id='catsnack'></div>
				<div class='tab-pane fade' id='catcleanliness'></div>
				<div class='tab-pane fade' id='catbath'></div>
				<div class='tab-pane fade' id='cathouse'></div>
				<div class='tab-pane fade' id='cattoy'></div>
				</div>
				</div>
			</div>
			<!--/category-tab-->
		</div>
	</div>
</section>
<%@include file="../includes/footer.jsp"%>
