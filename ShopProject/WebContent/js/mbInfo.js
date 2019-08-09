$(document).ready(function(){
	$(".check").each(function(index,item) { //필수항목이 비어있을 때
		$(".check:eq("+index+")").focusout(function(){
		var count =0;
		var length= $(".check:eq("+index+") input[type='text']").length; //td의 input개수
		$(".check:eq("+index+") input[type='text']").each(function(i,item) {
		var value=$(".check:eq("+index+") input[type='text']:eq("+i+")").val(); //td의 input value
		if(value!=""){
			count++;
		}
		});
		if(count!=length){ //필수항목이 비어있으면 경고문구 추가
			var warning = $(".check:eq("+index+") .warning").html();
			if(!warning){ //경고문구가 없을때 추가
			$(".check:eq("+index+")").append("<p class='warning' style='margin:10px 0 0 0;color:red'>필수 정보입니다.</p>");
			}
		}else{ //필수항목을 입력했을때
			$(".check:eq("+index+") .warning").remove();
		}
		});
		});
	
	$("#pwd-fail").hide();
	$("input").focusout(function(){ /* 비밀번호 확인 */
		var pwd =$("#mbPwd").val();
		var pwdCheck =$("#pwdCheck").val();
		if(pwd!="" && pwdCheck!=""){
			if(pwd==pwdCheck){
				$("#pwd-fail").hide();
			}else{
				$("#pwd-fail").show();
				$("#pwdCheck").focus();
			}
		}
	});
	
	$("#email3").change(function(){ /* 이메일  */
	var email3 =$("#email3").find(":selected").val();
	$("#email2").val(email3);
	});
$("#ok").click(function(){ /* 회원정보수정 */
	var email =$("#email1").val()+"@"+$("#email2").val();
 	$("input[name=mbEmail]").attr("value",email);
 	var phone =$("#phone1").val()+"-"+$("#phone2").val()+"-"+$("#phone3").val();
 	$("input[name=mbPhone]").attr("value",phone);
 	var tel =$("#tel1").val()+"-"+$("#tel2").val()+"-"+$("#tel3").val();
 	if(tel.length!=2){
	$("input[name=mbTel]").attr("value",tel);
 	}
	var birth3 = $("#birth3").val();
	if(birth3.length==1){ /* 일이 한자리숫자일때 앞에 0붙이기 */
		birth3 = "0"+birth3;
	}
	var birth = $("#birth1").val()+"-"+$("#birth2").val()+"-"+birth3;
	if(birth.length==2){
		$("input[name=mbBirth]").remove();
	}else if(birth.length!=2 && birth.length!=10){
		alert("생년월일을 정확히 입력해주세요.");
		return;
	}else if(birth.length==10){
	$("input[name=mbBirth]").attr("value",birth);
	}
 	document.info.submit();
});
$("#cancel").click(function(){ /* 취소 */
	location.href="/member/mypage.do";
});	
});