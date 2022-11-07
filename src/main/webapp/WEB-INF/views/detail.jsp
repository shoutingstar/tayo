<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="resources/common.css" type="text/css">
<style></style>
</head>
<body>
		<table>
			<tr>
				<td colspan="2">${total.title}</td>
			</tr>
			<tr>
				<td>${total.mem_id}</td>
				<td>${total.to_date}</td>
			</tr>			
			<tr>
				<td  colspan="2">${total.content}</td>
			</tr>
			<tr>
				<td colspan="2" class="btn_area">
					<button type="button" onclick="location.href='./updateForm?num=${total.num}'">수정하기</button>
					<button type="button" onclick="location.href='./'">목록</button>
					<button type="button" onclick="location.href='./delete?num=${total.num}'">삭제</button>
				</td>
			</tr>		
		</table>

</body>
<script></script>
</html>







