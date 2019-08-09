$(document).ready(function(){
	$("input[name='mbId']").focusout(function(){ //아이디 중복체크
		var mbId = $("input[name='mbId']").val();
		if(mbId!=""){
		var params = "?mbId="+mbId;
		var result= productService.mbIdCheck(params);
		if(result==1){ //아이디 중복
			$(".fail").remove();
			$(".success").remove();
			$("input[name='mbId']").after("<p class='fail' style='margin:10px 0 0 0;color:red'>이미 사용중인 아이디입니다.</p>");
		}else{ //아이디 가능
			$(".fail").remove();
			$(".success").remove();
			$("input[name='mbId']").after("<p class='success' style='margin:10px 0 0 0;color:#428bca'>사용 가능한 아이디입니다.</p>");
		}
	}
	});
	
	
	$("#pwd-fail").hide();
	$("input[type='password']").focusout(function(){ /* 비밀번호 확인 */
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
		if(pwd=="" && pwdCheck==""){
			$("#pwd-fail").hide();
		}
	});
	
	
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
			$(".check:eq("+index+") .fail").remove();
			$(".check:eq("+index+") .success").remove();
			$(".check:eq("+index+")").append("<p class='warning' style='margin:10px 0 0 0;color:red'>필수 정보입니다.</p>");
			}
		}else{ //필수항목을 입력했을때
			$(".check:eq("+index+") .warning").remove();
		}
		
		var pwd=$(".check:eq("+index+") input[type='password']").val();
		if(pwd==""){
			$(".check:eq("+index+")").append("<p class='warning' style='margin:10px 0 0 0;color:red'>필수 정보입니다.</p>");
		}
		});
		});
	
	$("#email3").change(function(){ /* 이메일  */
	var email3 =$("#email3").find(":selected").val();
	$("#email2").val(email3);
	});
	
$("#join").click(function(){ /* 회원가입 */
	var check = $(".fail").html();
	if(check){
		alert("이미 사용중인 아이디입니다.");
		$("input[name='mbId']").focus();
		return false;
	}
	$("td").each(function(index,item) { // 필수정보를 다 입력했는지 확인
		$("td:eq("+index+") p:last-child").remove();
		$("td:eq("+index+")").focus();
		$("td:eq("+index+")").blur();
	});
	var warning =$(".warning").length;
	if(warning!=0){ //입력하지 않은 필수항목이 있을때
		alert("필수 정보를 입력해주세요.");
		return false;
	}
	
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
 	document.join.submit();
});
$("#cancel").click(function(){ /* 취소 */
	location.href="/main/list.do";
});	
});