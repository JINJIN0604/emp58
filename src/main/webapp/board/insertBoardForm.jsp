<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
</head>
<body>
<div class="container">
		<!-- 메뉴 partial jsp 구성-->
		<div class="text-center">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>

	<h1>글작성</h1>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		if(request.getParameter("msg") != null) {
	%>
		<div><%=request.getParameter("msg")%></div>
	<%
		}
	%>
		<form action="<%=request.getContextPath()%>/board/insertBoardAction.jsp" method="post">
			<table class=" table table-bordered">
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="boardPw"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="boardTitle"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><input type="text" name="boardContent"></td>
				</tr>
				<tr>
					<td>글쓴이</td>
					<td><input type="text" name="boardWriter"></td>
				</tr>
			</table>
				  <button type="button" class="btn btn-success">추가</button>	
		</form>
</div>
</body>
</html>