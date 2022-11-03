<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style></style>
</head>
<body>
<h2>비밀번호 변경하기</h2>
<input type="hidden" id="id" value="${id}">
	<table>
		<tr>
			<th>새 비밀번호</th>
			<td><input type="password" id="mem_pw"></td>
		</tr>
		<tr>
			<th>비밀번호 재확인</th>
			<td><input type="password" id="mem_pwCheck"></td>
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