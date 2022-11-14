<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="vo.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	// 1. 요청분석
	String commentNo = request.getParameter("commentNo");

	// 2. 요청 처리
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	// DB 접속
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
	String sql = "SELECT board_no boardNo, comment_pw commentPw, comment_content commentContent, createdate FROM comment WHERE comment_no = ?";
	//쿼리 실행할 객체 생성
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(commentNo));
	ResultSet rs = stmt.executeQuery(); 
	
	Comment c = null;
	if(rs.next()) { 
		c = new Comment();
		c.commentNo = Integer.parseInt(commentNo);
		c.boardNo = rs.getInt("boardNo");
		c.commentPw = rs.getString("commentPw");
		c.commentContent = rs.getString("commentContente");
		c.createdate = rs.getString("createdate");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCommentForm</title>
</head>
<body>
	<div class="container" style="width:500px;">
	<div class="head" >
	<h1>댓글수정</h1>
	</div>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- 상대주소 적지말기 -->
	</div>
	<form action="<%=request.getContextPath()%>/board/updateCommentAction.jsp" method="post" >
		<table class=" table table-bordered">
			<tr>
				<td>번호</td>
				<td><input type="text" name="commentNo" value="<%=c.commentNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><input type="text" name="commentContent" value="<%=c.commentContent%>"></td>
			</tr>
			<tr>
				<td>등록일</td>
				<td><textarea rows="3" cols="40"  name="createdate"<%=c.createdate%>></textarea></td>
			</tr>
			<tr>
				<td>비말번호</td>
				<td><input type="password" name="commentPw" value="<%=c.commentPw%>"></td>
			</tr>
		</table>
		<button type="submit">댓글수정</button>
	</form>
	</div>
</body>
</html>