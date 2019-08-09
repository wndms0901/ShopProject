<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
history.pushState(null, null, location.href);
window.onpopstate = function () {
    history.go(1);
};

//새로고침 금지
function noRefresh()
{
    if (event.keyCode == 116) 
    {
        event.keyCode = 2;
        return false;
    } 
    else if(event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) 
    {
        return false;
    }
}
document.onkeydown = noRefresh;
</script>
<body oncontextmenu="return false">
<section id="form" style="margin-top: 70px; margin-bottom: 100px;">
	<p>${mbEmail}</p>
	<!--form-->
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="join-form">
					<h2>회원가입</h2>
					<p>
						<font style="color: #8D8B88">01&nbsp;&nbsp;정보입력&nbsp;&nbsp;></font>
						<font style="color: #323232; font-weight: bold;">&nbsp;&nbsp;02&nbsp;&nbsp;가입완료</font>
					</p>
					<br>
					<p>
						<img src="../images/home/point3.png">
					</p>
					<div class="join-Info">
					<h2>${mb.mbName}님 회원가입을 축하합니다!</h2>
					<p>즉시 사용할 수 있는 적립금 2,000원이 지급되었습니다.</p>
					<p>(20,000원 이상 구매시 사용가능)</p>
					<p id="info">아이디 : ${mb.mbId}</p>
					<p id="info">
						( 가입일 :
						<fmt:formatDate value="${mb.mbRegisterDate}" pattern="yyyy년 MM월 dd일" />
						)
					</p><br><br>
					<p><button type="button" style="background:#FEBA0F" onclick="location.href='login.do'">로그인</button>
					&nbsp;&nbsp;<button type="button" onclick="location.href='/main/list.do'">메인</button></p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<%@include file="../includes/footer.jsp"%>