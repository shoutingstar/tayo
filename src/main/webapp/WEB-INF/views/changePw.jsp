<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
#checkPwd, #pwr {
	color : red;
	font-size: 14px;
	font-weight: bold;
}
</style>
</head>
<body>
<h2>비밀번호 변경하기</h2>
<input type="hidden" id="id" value="${id}">
	<table>
		<tr>
			<th>새 비밀번호</th>
			<td>
				<input type="password" id="mem_pw" onkeyup="pwr()" value="" placeholder="비밀번호를 입력해 주세요" >
				<div id="pwr" style="color: gray;">6자 이상 영문, 숫자를 사용하세요</div>
			</td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td>
				<input type="password" id="mem_pwCheck" onkeyup="checkPwd()" placeholder="비밀번호 확인을 입력해 주세요">
				<div id="checkPwd"></div>
			</td>
		</tr>
		<tr>
			<th colspan="2">
			<input id="changePw" type="button" value="확인">
			<input type="button" value="취소" onclick="location.href='./'">
			</th>
		</tr>
	</table>
</body>
<script>
$id = $("#id");
if($id.val() ==''){
	alert("비밀번호를 찾지 못했습니다.\n 다시 입력해 주세요.");
	location.href="./findPwForm";
}else{
	alert("비밀번호를 찾았습니다 \n 비밀번호를 변경해 주세요")
}

var pwRule = /^(?=.*?[A-Za-z])(?=.*?\d)[A-Za-z\d]{6,}$/
//비밀번호 실시간 검증
function pwr(){
	var pw = document.getElementById('mem_pw').value;
	
	if(pw.match(pwRule) == null){
		document.getElementById('pwr').style.color = 'red';
		document.getElementById('pwr').innerHTML = "! 6자 이상 영문, 숫자를 사용하세요"+"<br>"+"예)abc123";
	}else{
		document.getElementById('pwr').style.color = "green";
		document.getElementById('pwr').innerHTML = "비밀번호 조건에 충족하였습니다."; 
	}
}

//비밀번호 확인 실시간 검증
function checkPwd(){
	var pw = document.getElementById('mem_pw').value;
	var pwChk = document.getElementById('mem_pwCheck').value;
	
	if(pw!=pwChk){
		document.getElementById('checkPwd').style.color = 'red';
		document.getElementById('checkPwd').innerHTML = "! 동일한 암호를 입력하세요.";
	}else{
		document.getElementById('checkPwd').style.color = "green";
		document.getElementById('checkPwd').innerHTML = "암호가 일치합니다."; 
	}
}

$("#changePw").click(function(){
	$pw = $("#mem_pw");
	$pwChk = $("#mem_pwCheck");
	
	if($pw.val()==''){
		alert("비밀번호를 입력해 주세요");
		$pw.focus();
	}else if($pwChk.val()==''){
		alert("비밀번호 확인을 입력해 주세요");
		$pwChk.focus();
	}else if($pw.val()!=$pwChk.val()){ // 비밀번호 체크
		alert("비밀번호가 일치하지 않습니다.");
		document.getElementById("mem_pwCheck").value ='';
		$pwChk.focus();
	}else{
		var param ={}; // json으로 전달하기 위한 object
		param.id = $id.val();
		param.pw = $pw.val();
		$.ajax({
			type:'POST',
			url:'changePw',
			data:param,
			success:function(data){
				if(data.changePw>0){
					alert("비밀번호 변경 완료");
					location.href="./loginForm";
				}else{
					alert("비밀번호 변경 실패\n 다시 시도해주세요\n 지속적으로 문제 발생 시 관리자에게 문의해주세요");			
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
});
</script>
</html>