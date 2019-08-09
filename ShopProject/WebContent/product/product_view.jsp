<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
	function AddComma(data_value) {
		return Number(data_value).toLocaleString('en');
	}
	$(document).ready(function() {
		var price = ${product.price};
		var mileage = Math.floor(price / 100);
		$("#mileage").html(AddComma(mileage) + "원");
		$(".total").html(AddComma(price) + "원");

		$('#plus').on('click', function(event) {/* +버튼 */
			var pQuantity = $("input[name=pQuantity]").val();
			var stock = ${product.pStock};
			var price = ${product.price};
			if (pQuantity < stock) {
				pQuantity++;
				$("input[name=pQuantity]").val(pQuantity);
				$(".total").html(AddComma(pQuantity * price) + "원");
			}
		});
		$('#minus').on('click', function(event) { /* -버튼 */
			var pQuantity = $("input[name=pQuantity]").val();
			var price = ${product.price};
			if (pQuantity > 1) {
				pQuantity--;
				$("input[name=pQuantity]").val(pQuantity);
				$(".total").html(AddComma(pQuantity * price) + "원");
			}
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#btn1").click(function() { //장바구니 버튼 클릭
			var pno = ${product.pno};
			var pQuantity = $("input[name=pQuantity]").val();
			var params = '?pno=' + pno + '&pQuantity='+ pQuantity;
			productService.addCart(params);
		});

		$("#cart").click(function() { //모달창 장바구니보기 버튼 클릭
			location.href = "/order/cart.do";
		});

		$("#btn2").click(function() { //구매하기 버튼 클릭
			var mbId = '<c:out value="${sessionScope.mbId}"/>';
			if (mbId) { //로그인했을때
				$("form").attr("action","/order/orderMember.do");
			} else { //로그인x
				$("form").attr("action","/order/orderGuest.do");
				$("form").append("<input type='hidden' name='guest' value='order'>");
			}
		});
	});
</script>
<section>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div style="margin-top: 30px; padding-left: 15px">
					<p style="text-align: left;">
						<a href="/main/list.do">HOME</a>&nbsp;>&nbsp;<a
							href="/product/list.do?mCode=${product.mediumCtgryCode}">${product.mediumCtgryName}</a>&nbsp;>&nbsp;${product.lowCtgryName}
					</p>
				</div>
				<!--product-details-->
				<div class="product-details">
					<div class="col-sm-5" style="width: 39%">
						<div class="view-product">
							<img src="../images/product/${product.pImage}" alt="" />
						</div>
						<div id="similar-product" class="carousel slide"
							data-ride="carousel">
							<p style="text-align: center">
								<a href="#">보기</a> <a id="check" href=#></a>
							</p>
						</div>

					</div>
					<div class="col-sm-7">
						<div class="product-information">
							<div class="product-Info">
								<form method="post">
									<input type="hidden" name="pno" value="${product.pno}">
									<table>
										<tr>
											<td colspan="2"
												style="font-size: 30px; border-bottom: 1px solid #8D8B88;">${product.pName }</td>
										</tr>
										<tr>
											<td id="key">할인판매가</td>
											<td id="price"><fmt:formatNumber type="number"
													maxFractionDigits="3" value="${product.price}" />원</td>
										</tr>
										<tr>
											<td id="key">적립금</td>
											<td id="mileage" colspan="2"></td>
										</tr>
										<tr>
											<td id="key">배송비</td>
											<td>3,000원&nbsp;&nbsp;(30,000원 이상 구매시 무료배송)</td>
										</tr>
										<tr>
											<td id="key">브랜드</td>
											<td>${product.pCompany}</td>
										</tr>
									</table>
									<table class="amount">
										<tr>
											<td>${product.pName}</td>
											<td><button type="button" id="minus">-</button> <input
												type="text" name="pQuantity" value="1">
												<button type="button" id="plus">+</button></td>
											<td><font class="total">${product.price}</font></td>
										</tr>
										<tr>
											<td colspan="3"
												style="border-bottom: 0px; text-align: right;">총
												상품금액&nbsp;&nbsp;<font class="total">${product.price}</font>
											</td>
										</tr>
									</table>
									<div class="product-Btn">
										<button type="button" id="btn1" data-toggle="modal"
											data-target="#myCart">장바구니</button>
										<button type="submit" id="btn2">구매하기</button>
									</div>
								</form>
							</div>
						</div>
						<!--/product-information-->
					</div>
				</div>
				<!--/product-details-->

				<div class="category-tab shop-details-tab">
					<!--category-tab-->
					<div class="col-sm-12">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#details" data-toggle="tab">상품상세정보</a></li>
							<li><a href="#companyprofile" data-toggle="tab">배송안내</a></li>
							<li><a href="#tag" data-toggle="tab">교환 및 반품안내</a></li>
						</ul>
					</div>

					<div class="tab-content">
						<!-- 상품상세정보 -->
						<div class="tab-pane fade active in" id="details">
							<div class="col-sm-3">
								<h3>상품상세정보</h3>
								<img src="../images/product/${product.pContent}" alt="" />
							</div>
						</div>
						<!-- 배송안내 -->
						<div class="tab-pane fade" id="companyprofile">
							<div class="col-sm-12">
								<div class="delivery_cont">
									<h3>배송안내</h3>
									<div class="admin_msg">
										<p>- 배송비&nbsp;:&nbsp;기본배송료는
											3,000원&nbsp;입니다.&nbsp;(도서,산간,오지&nbsp;일부지역은&nbsp;배송비가&nbsp;추가될&nbsp;수&nbsp;있습니다)&nbsp;&nbsp;</p>
										<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
											30,000원&nbsp;이상&nbsp;구매시&nbsp;무료배송입니다.</p>
										<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 일부 부피가 큰 제품의
											경우 제품당 5,000원의 추가 배송비가 부과됩니다.</p>
										<p>&nbsp;</p>
										<p>- 본&nbsp;상품의&nbsp;평균&nbsp;배송일은 2~3일입니다.</p>
										<p>&nbsp;
											(입금&nbsp;확인&nbsp;후)&nbsp;설치&nbsp;상품의&nbsp;경우&nbsp;다소&nbsp;늦어질수&nbsp;있습니다.</p>
										<p>&nbsp;
											[배송예정일은&nbsp;주문시점(주문순서)에&nbsp;따른&nbsp;유동성이&nbsp;발생하므로&nbsp;평균&nbsp;배송일과는&nbsp;차이가&nbsp;발생할&nbsp;수&nbsp;있습니다.]</p>
										<p>&nbsp;</p>
										<p>- 본&nbsp;상품의&nbsp;배송&nbsp;가능일은 2~3일&nbsp;입니다.&nbsp;</p>
										<p>&nbsp;
											배송&nbsp;가능일이란&nbsp;본&nbsp;상품을&nbsp;주문&nbsp;하신&nbsp;고객님들께&nbsp;상품&nbsp;배송이&nbsp;가능한&nbsp;기간을&nbsp;의미합니다.&nbsp;</p>
										<p>&nbsp;
											(단,&nbsp;연휴&nbsp;및&nbsp;공휴일은&nbsp;기간&nbsp;계산시&nbsp;제외하며&nbsp;현금&nbsp;주문일&nbsp;경우&nbsp;입금일&nbsp;기준&nbsp;입니다.)</p>
									</div>
								</div>
							</div>
						</div>
						<!-- 교환및반품안내 -->
						<div class="tab-pane fade" id="tag">
							<div class="col-sm-12">
								<div class="exchange_cont">
									<h3>교환 및 반품안내</h3>
									<div class="admin_msg">
										<p>-
											상품&nbsp;택(tag)제거&nbsp;또는&nbsp;개봉으로&nbsp;상품&nbsp;가치&nbsp;훼손&nbsp;시에는&nbsp;상품수령후&nbsp;7일&nbsp;이내라도&nbsp;교환&nbsp;및&nbsp;반품이&nbsp;불가능합니다.</p>
										<p>-
											저단가&nbsp;상품,&nbsp;일부&nbsp;특가&nbsp;상품은&nbsp;고객&nbsp;변심에&nbsp;의한&nbsp;교환,&nbsp;반품은&nbsp;고객께서&nbsp;배송비를&nbsp;부담하셔야&nbsp;합니다(제품의&nbsp;하자,배송오류는&nbsp;제외)</p>
										<p>-
											일부&nbsp;상품은&nbsp;신모델&nbsp;출시,&nbsp;부품가격&nbsp;변동&nbsp;등&nbsp;제조사&nbsp;사정으로&nbsp;가격이&nbsp;변동될&nbsp;수&nbsp;있습니다.</p>
										<p>-
											신발의&nbsp;경우,&nbsp;실외에서&nbsp;착화하였거나&nbsp;사용흔적이&nbsp;있는&nbsp;경우에는&nbsp;교환/반품&nbsp;기간내라도&nbsp;교환&nbsp;및&nbsp;반품이&nbsp;불가능&nbsp;합니다.</p>
										<p>-
											수제화&nbsp;중&nbsp;개별&nbsp;주문제작상품(굽높이,발볼,사이즈&nbsp;변경)의&nbsp;경우에는&nbsp;제작완료,&nbsp;인수&nbsp;후에는&nbsp;교환/반품기간내라도&nbsp;교환&nbsp;및&nbsp;반품이&nbsp;불가능&nbsp;합니다.&nbsp;</p>
										<p>-
											수입,명품&nbsp;제품의&nbsp;경우,&nbsp;제품&nbsp;및&nbsp;본&nbsp;상품의&nbsp;박스&nbsp;훼손,&nbsp;분실&nbsp;등으로&nbsp;인한&nbsp;상품&nbsp;가치&nbsp;훼손&nbsp;시&nbsp;교환&nbsp;및&nbsp;반품이&nbsp;불가능&nbsp;하오니,&nbsp;양해&nbsp;바랍니다.</p>
										<p>-
											일부&nbsp;특가&nbsp;상품의&nbsp;경우,&nbsp;인수&nbsp;후에는&nbsp;제품&nbsp;하자나&nbsp;오배송의&nbsp;경우를&nbsp;제외한&nbsp;고객님의&nbsp;단순변심에&nbsp;의한&nbsp;교환,&nbsp;반품이&nbsp;불가능할&nbsp;수&nbsp;있사오니,&nbsp;각&nbsp;상품의&nbsp;상품상세정보를&nbsp;꼭&nbsp;참조하십시오.&nbsp;</p>
									</div>
									<h3>환불안내</h3>
									<div class="admin_msg">- 상품 청약철회 가능기간은 상품 수령일로 부터 7일 이내
										입니다.</div>
									<h3>AS안내</h3>
									<div class="admin_msg">
										<p>- 소비자분쟁해결 기준(공정거래위원회 고시)에 따라 피해를 보상받을 수 있습니다.</p>
										<p>- A/S는 판매자에게 문의하시기 바랍니다.</p>
										<p>- 고객센터 1899-9685</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</section>
<!-- Modal -->
<div class="modal fade" id="myCart" role="dialog">
	<div class="modal-dialog" style="width: 400px">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="border: 0">
				<button type="button" class="close" data-dismiss="modal"
					style="font-size: 26px">×</button>
			</div>
			<div class="modal-body"
				style="text-align: center; padding: 20px 20px 0px 20px">
				<p>
					<img src="../images/home/cartPlus.png">
				</p>
				<strong style="font-size: 20px;">장바구니에 상품을 담았습니다.</strong>
			</div>
			<div class="modal-footer"
				style="border: 0; padding: 5px 10px 30px; text-align: center">
				<button type="button" id="shop" class="btn" data-dismiss="modal">계속
					쇼핑</button>
				<button type="button" id="cart" class="btn">장바구니 보기</button>
			</div>
		</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>
