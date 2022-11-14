<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>

<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 1.
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int commentNo = Integer.parseInt(request.getParameter("commenmtNo"));
	String commentPw = request.getParameter("commentPw");
	// 디버깅
	System.out.println(commentNo + "댓글 삭제");
	// 2.
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	//쿼리 문자열 생성
	String sql = "DELETE FROM comment WHERE comment_no=? AND comment_pw=?";
	// 쿼리 셋팅
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, commentNo);
	stmt.setString(2, commentPw); 
	//쿼리 실행
	int row = stmt.executeUpdate();
	//쿼리 실행 결과
	if(row == 1){
		response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+boardNo);
		System.out.println("댓글 삭제 성공");
	} else{
		String msg = URLEncoder.encode("비밀번호를 확인하세요.","utf-8");;
		response.sendRedirect(request.getContextPath()+"/board/deleteCommentForm.jsp?boardNo="+boardNo+"&commentNo="+commentNo+"&msg="+msg);		
		System.out.println("댓글 삭제 실패");
	}
	//3
%>