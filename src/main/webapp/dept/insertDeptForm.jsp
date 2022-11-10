<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			h1 {
				
				font-size: 40px;
  				color: #FF5E00;
			}

			td {
				text-align: center;
				font-weight: bold
			}
		
		</style>



<meta charset="UTF-8">
<title>inertDeptForm</title>
</head>
<body>
	<div class="container" style="width:500px;">
	<div class="head">
	<h1>부서추가</h1>
	</div>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		if(request.getParameter("msg") != null) {
	%>
		<div><%=request.getParameter("msg")%></div>
	<%
		}
	%>
		<form action="<%=request.getContextPath()%>/dept/insertDeptAction.jsp" method="post">
			<table class=" table table-bordered">
				<tr>
					<td>부서번호</td>
					<td><input type="text" name="dept_no"></td>
				</tr>
				<tr>
					<td>부서이름</td>
					<td><input type="text" name="dept_name"></td>
				</tr>
				
			</table>
				<button type="submit" >추가</button>		
		</form>
	</div>
</body>
</html>
