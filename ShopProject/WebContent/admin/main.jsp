<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
	<div class="right">
		<h2>오늘 쇼핑몰 현황&nbsp;<font style="font-size:20px;color:#777">(${now})</font></h2>
		<table>
			<tr>
				<td width="33.3%"><p>
						<img src="../images/home/admin_icon1.png">
					</p>
					<p style="font-size: 20px">주문</p>
					<p style="margin: 0">
						<font style="font-size: 30px">${todayOrderCount}</font><font
							style="font-size: 18px">건</font>
					</p></td>
				<td width="33.3%"><p>
						<img src="../images/home/admin_icon2.png">
					</p>
					<p style="font-size: 20px">주문금액</p>
					<p style="margin: 0">
						<font style="font-size: 30px">${todayOrderSum}</font><font
							style="font-size: 18px">원</font>
					</p></td>
				<td width="33.3%"><p>
						<img src="../images/home/admin_icon3.png">
					</p>
					<p style="font-size: 20px">신규회원수</p>
					<p style="margin: 0">
						<font style="font-size: 30px">${todayJoin}</font><font
							style="font-size: 18px">건</font>
					</p></td>
			</tr>
		</table>
		<h2>이번달 쇼핑몰 현황</h2>
		<table>
			<tr>
				<td width="33.3%"><p>
						<img src="../images/home/admin_icon1.png">
					</p>
					<p style="font-size: 20px">주문</p>
					<p style="margin: 0">
						<font style="font-size: 30px">${monthOrderCount}</font><font
							style="font-size: 18px">건</font>
					</p></td>
				<td width="33.3%"><p>
						<img src="../images/home/admin_icon2.png">
					</p>
					<p style="font-size: 20px">주문금액</p>
					<p style="margin: 0">
						<font style="font-size: 30px">${monthOrderSum}</font><font
							style="font-size: 18px">원</font>
					</p></td>
				<td width="33.3%"><p>
						<img src="../images/home/admin_icon3.png">
					</p>
					<p style="font-size: 20px">신규회원수</p>
					<p style="margin: 0">
						<font style="font-size: 30px">${monthJoin}</font><font
							style="font-size: 18px">건</font>
					</p></td>
			</tr>
		</table>
	</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>