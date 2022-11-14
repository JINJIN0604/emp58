<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% 	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 요청 분석
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String msg = request.getParameter("msg"); // 수정실패시 리다이렉시에는 null값이 아니고 메세지가 있다
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<h1>게시글 삭제</h1>
	<%
		if(msg!=null){	
	%>
		<div><%=msg %></div>
	<%
		}
	%>
	
	<form action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp" method="post">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		삭제할 비밀번호:
		<input type="password" name="boardPw">
		<button type="submit">삭제</button>
	</form>
</body>
</html>