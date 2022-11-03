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
<h1>임시 메인</h1>
	로그인 ID : ${sessionScope.loginId}
<button onclick="location.href='./logout'">로그아웃</button>
</body>
<script></script>
</html>