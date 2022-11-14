<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="vo.*" %>
<% 	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 1. 요청 분석
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String msg = request.getParameter("msg"); // 비밀번호 불일치 -> msg 보임
	
	// 2. 요청 처리 불필요
	// 3.

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteCommentForm.jsp</title>
</head>
<body>

	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<h1>댓글삭제</h1>
	<%
		if(msg != null){	
	%>
		<div><%=msg%></div>
	<%
		}
	%>
	
	<form action="<%=request.getContextPath()%>/board/deleteCommentAction.jsp" method="post">
		<table>
			<tr>
				<td>
					<input type="hidden" name="boardNo" value=<%=boardNo%>>
				</td>
			</tr>
			<tr>
				<td>댓글 번호</td>
				<td>
					<input type="text" name="commentNo" value=<%=commentNo%> readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<!-- 비밀번호는 value값 주지 않음 -->
					<input type="password" name="commentPw"> 
				</td>
			</tr>
			<tr>
				<td>
					<button type="submit">삭제</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>