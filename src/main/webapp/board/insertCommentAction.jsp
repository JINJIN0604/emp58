<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*"%>
<%@ page import = "vo.*" %>

<%
	// 1. 요청분석(폼에서 받기)
	request.setCharacterEncoding("utf-8"); // 한글인코딩
	// 값 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); //문자열을 정수형으로 변환
	String commentContent = request.getParameter("commentContent");
	String commentPw = request.getParameter("commentPw");
	
	//2. 요청처리(쿼리)
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");

	String sql="INSERT INTO comment(board_no, comment_content, comment_pw, createdate) values(?, ?, ?, CURDATE())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// values 물음표 값 채우기
	stmt.setInt(1, boardNo);
	stmt.setString(2, commentContent);
	stmt.setString(3, commentPw);
	// 디버깅 
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("등록성공");
	} else {
		System.out.println("등록실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+boardNo);
%>