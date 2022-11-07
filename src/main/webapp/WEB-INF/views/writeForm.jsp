<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style></style>
</head>
<body>
	<h3>같이가볼래</h3>
	<form action="write" method="post">
		<table>
			<tr>
				<td><input type="text" name="title" placeholder="제목" /></td>
			</tr>
			<tr>
				<td><input type="text" name="mem_id" /></td>
				<td><input type="text" name="to_date" /></td>
			</tr>
			<tr>
				<td><textarea name="content" placeholder="내용을 입력해주세요"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="btn_area">
					<button type="button" onclick="location.href='./'">취소</button>
					<button class="reg">등록하기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
<script>
$(".reg").click(function() {
    if(confirm("등록하시겠습니까?")) {
        alert("등록이 완료되었습니다");
    }
})
</script>
</html>

