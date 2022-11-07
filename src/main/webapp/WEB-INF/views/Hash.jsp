<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>

   table,th,td{
      border: 1px solid black;
      border-collapse: collapse;
      padding: 5px 10px;
      font-size: 5pt;
   }
</style>
</head>
<body>
	<div>
		<p>해시태그 관리(관리자)</p>
	</div>
	<form action="write" method="post">
	<table>
		<tr>
		<th>차량 명</th>
		<th>해시태그 이름</th>
		<th>해시태그 값</th>
		</tr>
		<tr>
		<td>
			<input type="text" name="ca_name" value=""/><button >찾기</button>
		</td>
		<td>
			<input type="text" name="ha_name" value=""/>		
		</td>
		<td>
			<input type="text" name="ha_value" value=""/>		
			
		</td>
		</tr>
		<tr>
			<th colspan="3"><button>등록</button></th>
		</tr>
	</table>
	</form> 
	
	
	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="all"/></th>
				<th>태그등록순서</th>
				<th>차량이름</th>
				<th>해시태그 이름</th>
				<th>해시태그 값</th>
				<th>버튼</th>	
			</tr>
		</thead>
			
				<tbody id="list">
			</tbody>
	</table>
	<div><button onclick="del()">삭제</button></div>
<!-- <form action="search" method="post"> -->
	<div>
			<!-- <select class="form-control form-control-sm" name="searchType" id="searchType"> -->
			<select name="searchname">
					<option value="title">차 이름</option>
					<option value="Content">해시태그 이름</option>
			</select>
		<!-- <input type="text" class="form-control form-control-sm" name="keyword" id="keyword"> -->
		
			<input type="text" name="searchvalue" value=""/>
		<button onclick="search()">조회</button>	
		<!-- <button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" >조회</button> -->
	</div>
 	<!-- </form>  -->

</body>
<script>
listCall();

$("#all").click(function(){
var $chk= $('input[type="checkbox"]');

if($(this).is(':checked')){
$chk.prop('checked',true);
}else{
$chk.prop('checked',false);
}

});         

function listCall() { 
$.ajax({
type:'GET',
url:'listCall',
data:{},
datatype:'JSON',
success:function(data){
   console.log(data);

   	drawList(data.list);
   
},
error:function(e){
   console.log(e);
}      
});
}
function drawList(list){
var content='';
for(var i=0; i<list.length; i++){
console.log(list[i]);
content+='<tr>';
content+='<td><input type="checkbox" value="'+list[i].ha_num+'"</td>';
content+='<td>'+list[i].ha_num+'</td>'
content+='<td>'+list[i].ca_name+'</td>';
content+='<td>'+list[i].ha_name+'</td>';
content+='<td>'+list[i].ha_value+'</td>';
content+='<td><a href="updateForm?ha_num='+list[i].ha_num+'">수정</a></td>';
/* content+='<td><button type="button" onclick="location.href='./updateForm?idx=+list[i].ha_num+'">수정</button></td>'; */
content+='</tr>';
}
$('#list').empty();
$('#list').append(content);	
}   

function del(){

var chkArr=[];

$('input[type="checkbox"]:checked').each(function(ha_num,item){

if($(this).val()!='on'){
	
chkArr.push($(this).val());
}
});
console.log(chkArr);

$.ajax({
type:'GET',
url:'del',
data:{'delList':chkArr},
dataType:'JSON',
success:function(data){
	console.log(data);
	if(data.msg !=""){
		alert(data.msg);

		listCall();
	}
},
error:function(e){
	console.log(e);
}
});

}



function search(){
	if($('select[name=searchname]').val()=='title'){
	var ca_name =$('input[name=searchvalue]').val();		
	}else{
		var ha_name=$('input[name=searchvalue]').val();
	}
	$.ajax({
		type:'GET',
		url:'search',
		data:{ca_name,ha_name},
		datatype:'JSON',
		success:function(data){
		   console.log(data);
		
		   drawList(data.list);
		  
		   
		},
		error:function(e){
		   console.log(e);
		}      
		});	 
}
</script>
</html>