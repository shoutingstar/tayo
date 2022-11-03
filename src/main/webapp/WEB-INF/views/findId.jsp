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
<h2>아이디 찾기</h2>
<input type="button" value="아이디 찾기">
<input type="button" value="비밀번호 찾기" onclick="location.href='findPwForm'">	
	<table>
		<tr>
			<th>이름</th>
			<td><input type="text" id="mem_name"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" id="mem_email"></td>
		</tr>
		<tr>
			<th>휴대폰 번호</th>
			<td><input type="text" id="mem_pnum"></td>
			<td>ex) 하이픈(`-`)을 입력해주세요 010-0000-0000</td>
		</tr>
		<tr>
			<th colspan="2">
			<input type="button" id="confirm" value="확인">
			<input type="button" value="취소" onclick="location.href='./'">
			</th>
		</tr>
	</table>
</body>
<script>
$("#confirm").click(function(){
	
	// 이름 정규식
	const nameRule = /^[가-힣]{2,}$/
	
	// 이메일 정규식
	var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	//폰 번호 정규식
	var phonRule = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/
	
	$name = $("#mem_name");
	$email = $("#mem_email");
	$pnum = $("#mem_pnum");
	
	if($name.val()==''){
		alert("이름을 입력해 주세요");
		$name.focus();
	}else if($name.val().match(nameRule) == null){
		alert("이름은 한글로 2자 이상 입력해 주세요");
		$name.focus();
	}else if($email.val()==''){
		alert("이메일을 입력해 주세요");
		$email.focus();
	}else if($email.val().match(emailRule) == null){
		alert("email형식을 확인해 주세요");
		$email.focus();
	}else if($pnum.val().match(phonRule) == null){
		alert("핸드폰 번호에 하이픈(`-`을 넣어주세요\n ex) 010-1234-1234')");
		$pnum.focus();
	}else if($pnum.val()==''){
		alert("휴대폰 번호를 입력해 주세요");
		$pnum.focus();
	}else{
		var param ={}; // json으로 전달하기 위한 object
		param.name = $name.val();
		param.email = $email.val();
		param.pnum = $pnum.val();
		$.ajax({
			type:'POST',
			url:'findId',
			data:param,
			success:function(data){
				if(data.id != null){
					alert("아이디 찾기 성공\n"+"아이디 : "+data.id);
					location.href="./";
				}else{
					alert("아이디 찾기에 실패했습니다\n입력하신 내용을 다시 확인해 주세요");					
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