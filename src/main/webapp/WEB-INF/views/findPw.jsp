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
<h2>비밀번호 찾기</h2>
<input type="button" value="아이디 찾기" onclick="location.href='findIdForm'">
<input type="button" value="비밀번호 찾기">	
<form action="findPw" method="post">
	<table>
		<tr>
			<th>이름</th>
			<td><input type="text" name="mem_name"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="mem_email"></td>
		</tr>
		<tr>
			<th>휴대폰 번호</th>
			<td><input type="text" name="mem_pnum"></td>
		</tr>
		<tr>
			<th colspan="2">
			<input type="submit" value="확인">
			<input type="button" value="취소" onclick="location.href='./'">
			</th>
		</tr>
	</table>
</form>
</body>
<script></script>
</html>