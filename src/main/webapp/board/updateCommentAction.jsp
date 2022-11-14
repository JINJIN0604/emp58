<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*"%>
<%@ page import = "vo.*" %>
<% 
	// 1. 요청분석
	request.setCharacterEncoding("utf-8"); //한글 인코딩

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String commentPw = request.getParameter("commentPw");
	String commentContent = request.getParameter("commentContent");
	String createdate = request.getParameter("createdate");
	
	if(request.getParameter("boardNo") == null || request.getParameter("commentNo") == null || request.getParameter("commentPw") == null || request.getParameter("commentContent") == null || 
		request.getParameter("commentPw").equals("") || ("commentContent").equals("")){
		String msg = URLEncoder.encode("수정할 내용을 입력하세요","utf-8"); // get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/board/updateCommentForm.jsp");
		return;	
	}
	Comment c = new Comment();
	c.commentNo = commentNo;
	c.boardNo = boardNo;
	c.commentPw = commentPw;
	c.commentContent = commentContent;
	c.createdate = createdate;

	// 2. 요청처리
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	// DB접속
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql = "UPDATE comment SET comment_content=? WHERE comment_no=? AND comment_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, c.commentContent);
	stmt.setInt(2, c.boardNo);
	stmt.setString(3, c.commentPw);

	//디버깅
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("수정성공");
	} else {
		System.out.println("수정실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+boardNo);
%>