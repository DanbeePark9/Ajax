<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>JSP AJAX</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		var request = enw XMLHttpRequest(); //어떤 웹사이트에 요청을 보내는것
		function searchFunction(){
			request.open("Post", "./UserSearchServlet?userName="+encodeURIComponent(document.getElementById("userName").value),true);
			request.onreadystatechange = searchProcess;
			request.send(null);
		}
		function searchProcess(){
			var table = document.getElementById("ajaxTable");
			table.innerHTML = ""; // 안의 내용물을 다 지워주겠다
			if(request.readyState == 4 && request.status ==200){ //성공적으로 통신이 이루어 졌는지 확인
				var object = eval('('+request.responseText+')');
				var result = object.result;
				for(var i=0; i<result.length; i++){
					var row = table.insertRow(0);
					for(var j=0; result[i].length; j++){
						var cell= row.insertCell(j);
						cell.innerHTML= result[i][j].value;
					}
				}
			}
		}
	</script>
</head>
<body>
	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<!-- 입력할때마다 실행되도록 -->
				<input class="form-control" id="userName" onKeyup="searchFunction();" type="text" size="15">
			</div>
			<div class="col-xs-2">
				<!-- 버튼을 눌렀을때 실행되도록 -->
				<button class="btn btn-primary" type="button" onClick="searchFunction();">검색</button>
			</div>
			<table class="table" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#fafafa; text-align:center;">이름</th>
						<th style="background-color:#fafafa; text-align:center;">나이</th>
						<th style="background-color:#fafafa; text-align:center;">성별</th>
						<th style="background-color:#fafafa; text-align:center;">이메일</th>
					</tr>
				</thead>	
				<tbody id="ajaxTable">
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>