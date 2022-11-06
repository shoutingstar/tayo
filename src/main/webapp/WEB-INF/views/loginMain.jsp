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
/* The Modal (background) */
.modal {
 	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 7% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 30%; /* Could be more or less, depending on screen size */
}

#modal-notice {
font-size: 13pt;
text-align: center;
}

#input-body {
font-size: 13pt;
font-weight: bold;
}

div.left {
    width: 50%;
    float: left;
    text-align: center;
    box-sizing: border-box;
}
div.right {
    width: 50%;
    float: right;
    box-sizing: border-box;
}

</style>
</head>
<body>
	<h1>임시 메인</h1>
	로그인 ID : ${sessionScope.loginId}
	<button onclick="location.href='./logout'">로그아웃</button>
	<!-- Modal -->
	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<button type="button" class="close" data-dismiss="modal" onClick="close_pop();" 
			style="float: right; width: 35px; height: 35px; font-size: 22pt;" >
			&times;
			</button>
			<br>
			<div class="modal-header">
				<p style="font-size: 24pt; text-align: center;">이벤트</p>
			</div>	
		<div class="modal-body">
			<p id="modal-notice">
				<span>타볼래 첫 번째 이벤트!!</span>
				<br>
				<span>설문에 참여해 주시면 추첨을 통해</span>
				<br>
				<span>소정의 상품을 드려요!</span>
			</p>
			<p id="modal-notice">
				<span>맥북 (1명)</span>
				<br>
				<span>네이버 포인트 10만원 (1명)</span>
				<br>
				<span>비비큐 황금 올리브 유 (3명)</span>
				<br>
			</p>
			<br>
			<!-- 입력 칸 -->
			<div id = "input-body">
				<div class="left" style="line-height:30px">
					결혼 유무
				</div>
				<div class="right" style="line-height:30px">
					<input type="radio" name="marry" value="기혼"> 기혼
					&nbsp; &nbsp; &nbsp;
					<input type="radio" name="marry" value="미혼"> 미혼
				</div>
				<br>
				<div class="left" style="line-height:30px">
					자녀 유무
				</div>
				<div class="right" style="line-height:30px">
					<input type="radio" name="children" value="유"> 유
					&nbsp; &nbsp; &nbsp; &nbsp; 
					<input type="radio" name="children" value="무"> 무
				</div>
				<br>	
				<div class="left" style="line-height:30px">
					가족 구성원 수
				</div>	
				<div class="right" style="line-height:30px">
					<input type="text" id="familly">
				</div>	
				<br>
				<div class="left" style="line-height:30px">
					MBTI
				</div>
				<div class="right" style="line-height:30px">
					<input type="text" id="mbti">
				</div>	
				<br>
				<br>
				<br>
				<br>
			</div>
		</div>
		<div style="text-align: center;">
			<button id="submit" type="submit" 
			style="background-color: gray; cursor: pointer; text-align: center; 
			padding-top: 10px; padding-bottom: 10px; border-color: gray;
			width: 200px; height: 50px; font-size: 14pt; color: white;">
			제출
			</button>
		</div>
		</div>
	</div>
</body>
<script>
// var familly;
// var mbti;
var seMbti = '<%=(String)session.getAttribute("mbti")%>';
var reg = /^[0-9]+/g; //숫자만 입력하는 정규식
var mbtiRule = /^[a-zA-Z]{4}$/;


jQuery(document).ready(function() {
	if(seMbti=='null'){
   		$('#myModal').show();
	}else{
		close_pop();
	}
});

function close_pop(flag) {
 $('#myModal').hide(); //모달 닫기
};

// 전송
$("#submit").click(function(){
	$marry = $("input[name='marry']:checked");
	$children = $("input[name='children']:checked");
	var familly = document.getElementById("familly").value;
	var mbti = document.getElementById("mbti").value;
	
	if($marry.val()==null){
		alert("결혼 여부를 선택해 주세요");
	}else if($children.val()==null){
		alert("자녀 여부를 선택해 주세요");
	}else if(familly=='' || familly==null){
		alert("가족 구성원 수를 입력해 주세요");
		document.getElementById("familly").focus();
	}else if(familly.match(reg) == null){
		alert("가족 구성원 수는 숫자만 입력해 주세요");
		document.getElementById("familly").focus();
	}else if(mbti=='' || mbti==null){ // 여긴 수정중
		alert("MBTI를 입력해 주세요");
		document.getElementById("mbti").focus();
	}else if(mbti.match(mbtiRule) == null){
		alert("영어만 입력해 주세요.(4글자)");
		document.getElementById("familly").focus();
	}else {
		var param ={};
		param.marry = $marry.val();
		param.children = $children.val();
		param.familly = familly;
		param.mbti = mbti;
	 	$.ajax({
			type:'POST',
			url:'eventPage',
			data:param, //object 형태로 담은 데이터를 보냄
			dataType:'JSON',
			success:function(data){
				if(data.row>0){
					alert("이벤트 응모가 완료되었습니다.");
					location.href="./index";
				}else{
					alert("오류 발생\n이벤트 응모에 실패했습니다.\n이 현상이 반복된다면 관리자에게 문의해 주세요");					
				}
				close_pop();
			},
			error:function(e){
				console.log(data);
			}
		});
	}
});


</script>
</html>