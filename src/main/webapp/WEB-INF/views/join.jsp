<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
table, td, tr {
/* 	border: 1px solid black; */
	border-collapse: collapse;
}

td {
	padding: 5px;
/* 	text-align: center; */
}
</style>
</head>
<body>
	<h2>회원가입</h2>
		<table>
			<tr>
				<th>ID</th>
				<td>
				<input type="text" id="mem_id" value="">
				<input type="button" id="id_check" value="중복확인">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" id="mem_pw" value=""> ex) 대소문자 구분없는 문자 + 숫자 6자리 이상</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="mem_pwCheck" value=""></td>
			</tr>
			<tr>
				<th>핸드폰 번호</th>
				<td><input type="text" id="mem_pnum" value=""> ex) 하이픈(`-`)을 입력해주세요</td>
			</tr>
			<tr>
				<th>email</th>
				<td><input type="text" id="mem_email" value=""></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" id="mem_add" value=""></td>
			</tr>
			<tr>
				<th>상세주소</th>
				<td>
				<input type="text" id="mem_detailAdd" value="">
				<input type="button" id="findAdd" value="주소찾기">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" id="mem_name" value=""></td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" id="mem_age" value=""></td>
			</tr>
			<tr>
				<td colspan="2"><input id="join" type="button" value="회원가입"></td>
			</tr>
		</table>
</body>
<script>
var idCheck = false;

$("#id_check").click(function(){
	var id = $("#mem_id").val();
	$.ajax({
		type:'GET',
		url:'idCheck',
		data:{'id':id},//id값 전송
		dataType:'JSON',
		success:function(data){
			if(data.idCheck){ //true
				alert('이미 사용 중인 아이디 입니다.')
				$('#mem_id').val('');
				$('#mem_id').focus();
			}else{//없는 아이디라면
				idCheck=true;
				alert('사용 가능한 아이디 입니다.')
				$('#mem_id').focus();
			}
		},
		error:function(e){
			console.log(e);
		}
	});
});

//아이디 유효성 검사(정규화식 추가해야함)
$("#join").click(function(){
	
	$id = $("#mem_id");
	
	if(idCheck == true){ //아이디가 중복이 아닌 경우
	
		$pw = $("#mem_pw");
		$pwChk = $("#mem_pwCheck");
		$pnum = $("#mem_pnum");
		$email = $("#mem_email");
		$add = $("#mem_add");
		$detailAdd = $("#mem_detailAdd");
		$name = $("#mem_name");
		$age = $("#mem_age");
		
		var reg = /^[0-9]+/g; //숫자만 입력하는 정규식
		
		//폰 번호 정규식
		var phonRule = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/
		
		//아이디 정규식
		var idRule = /^[a-zA-Z0-9]+$/
		
		// 이메일 정규식
		var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		// 비밀번호 정규식
		var pwRule = /^(?=.*?[A-Za-z])(?=.*?\d)[A-Za-z\d]{6,}$/
		
		// 이름 정규식
		const nameRule = /^[가-힣]{2,}$/
		
		if($id.val()==''){
			alert("아이디를 입력해 주세요");
			$id.focus();
		}else if($id.val().match(idRule) == null){
			alert("아이디는 영어&숫자만 입력해 주세요");
			$id.focus();
		}else if($pw.val()==''){
			alert("비밀번호를 입력해 주세요");
			$pw.focus();
		}else if($pw.val().match(pwRule) == null){
			alert("비밀번호를 조건에 맞게 입력해 주세요");
			$pw.focus();
		}else if($pwChk.val()==''){
			alert("비밀번호 확인을 입력해 주세요");
			$pwChk.focus();
		}else if($pw.val()!=$pwChk.val()){ // 비밀번호 확인
			alert("비밀번호가 일치하지 않습니다.");
			document.getElementById("mem_pwCheck").value ='';
			$pwChk.focus();
		}else if($pnum.val()==''){
			alert("핸드폰 번호를 입력해 주세요");
			$pnum.focus();
		}else if($pnum.val().match(phonRule) == null){
			alert("핸드폰 번호에 하이픈(`-`을 넣어주세요\n ex) 010-1234-1234')");
			$pnum.focus();
		}else if($email.val()==''){
			alert("email을 입력해 주세요");
			$email.focus();
		}else if($email.val().match(emailRule) == null){
			alert("email형식을 확인해 주세요");
			$email.focus();
		}else if($add.val()==''){
			alert("주소를 입력해 주세요");
			$add.focus();
		}else if($detailAdd.val()==''){
			alert("상세주소를 입력해 주세요");
			$detailAdd.focus();
		}else if($name.val()==''){
			alert("이름을 입력해 주세요");
			$name.focus();
		}else if($name.val().match(nameRule) == null){
			alert("이름은 한글로 2자 이상 입력해 주세요");
			$name.focus();
		}else if($age.val()==''){
			alert("나이를 입력해 주세요");
			$age.focus();
		}else if($age.val().match(reg) == null){
			alert("나이는 숫자만 입력해 주세요");
			$age.focus();
		}else{
			var param ={}; // json으로 전달하기 위한 object
			param.id = $id.val();
			param.pw = $pw.val();
			param.pnum = $pnum.val();
			param.email = $email.val();
			param.add = $add.val();
			param.detailAdd = $detailAdd.val();
			param.name = $name.val();
			param.age = $age.val();
			
			$.ajax({
				type:'POST',
				url:'Join',
				data:param,
				success:function(data){
					console.log(data);
					if(data.success>0){
						alert("회원 가입에 성공했습니다.");
						location.href="./";
					}else{
						alert("회원 가입에 실패했습니다.");					
					}
				},
				error:function(e){
					console.log(e);
				}
			});
		}
	}else{
		alert('중복 아이디 체크를 진행해 주세요!');
		$id.focus();
	}
	
});

</script>
</html>