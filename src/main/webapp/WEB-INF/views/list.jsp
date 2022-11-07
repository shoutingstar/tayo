<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<!-- script 순서 중요!, script 자동생성시 type/src 주의!!  -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script src="resources/js/jquery.twbsPagination.js"></script>

<!-- <link rel="stylesheet" href="resources/common.css" type="text/css"> -->
<style>
	table,th,td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	} 
</style>
</head>
<body>
	<button onclick="location.href='writeForm'">글 작성하기</button>
	<h3>같이가볼래</h3>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
		</tr>
		
		<c:if test="${list.size()<1}">
		<tr><td colspan="6">작성된 글이 없습니다.</td></tr>
		</c:if>
		
		<c:forEach items="${list}" var="total">
			<tr>
				<td>${total.num}</td>
				<td><a href="detail?num=${total.num}">${total.title}</a></td>
				<td>${total.mem_id}</td>
				<td>${total.cnt}</td>
				<td>${total.to_date}</td>
			</tr>
		</c:forEach>
	</table>
</body>
<script></script>
</html>
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<!-- script 순서 중요!, script 자동생성시 type/src 주의!!  -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script src="resources/js/jquery.twbsPagination.js"></script>


<!-- <link rel="stylesheet" href="resources/common.css" type="text/css"> -->
<style>
	table,th,td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	} 
</style>
</head>
<body>
	<button onclick="location.href='writeForm'">글 작성하기</button>
	<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody id="list">	
	</tbody>
	<tr>
		<td colspan="5" id="paging">
			<div class="container">
				<nav aria-label="Page navigation" style="text-align:center">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
		</td>
	</tr>
	</table>
	<tr>
		<td>
			<select name="search">
				<option value="title">제목</option>
				<option value="mem_id">작성자</option>
			</select>
		</td>
		<td colspan="2">
			<input type="text" name="searchValue">
		</td>
		<td>
			<input type="submit" value="검색">
		</td>
	</tr>
</body>
<script>
var showPage=1;
listCall(showPage);

function listCall(page){
	$.ajax({
		type:'GET',
		url:'listCall',
		data:{page:page}, // page라는 이름으로 page넣기
		dataType:'JSON',
		success:function(data){
			console.log(data);
			drawList(data.list);
			// 플러그인 적용
			$('#pagination').twbsPagination({
				startPage:1, // 시작페이지
				totalPages:data.total, // 총 페이지 수
				visiblePages:5, // 기본으로 보여줄 페이지 수
				onPageClick:function(e,page){ //클릭했을 때 실행 내용
					//console.log(e);
					//console.log(page);
					listCall(page);
				}				
			});			
		},
		error:function(e){
			console.log(e);
		}		
	});	
}

function drawList(list){
	var content='';
	for(var i=0;i<list.length;i++){
		//console.log(list[i]);
		content +='<tr>';
		content +='<td>'+list[i].num+'</td>';
		
		content +='<td><a href="detail?num='+list[i].num+'">'+list[i].title+'</a></td>';
		
		content +='<td>'+list[i].mem_id+'</td>';
		content +='<td>'+list[i].cnt+'</td>';		
	
		
		var date=new Date(list[i].to_date);
		//console.log(date);
		//console.log(date.toLocaleDateString('ko-KR'));
		content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';
		content +='</tr>';
	}
	$('#list').empty();
	$('#list').append(content);
}

</script>
</html>









