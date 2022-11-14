<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import = "vo.*" %>
<%@page import="java.net.URLEncoder"%>

<%
	//1)
	// 요청분석
	request.setCharacterEncoding("utf-8"); // 한글인코딩
	// 값 받기
	String boardPw = request.getParameter("boardPw");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWrite = request.getParameter("boardWriter");
	
	if(boardPw == null || boardTitle == null || boardContent == null || boardWrite == null ||  boardPw.equals("") || boardTitle.equals("") || boardContent.equals("") || boardWrite.equals("")){
		String msg = URLEncoder.encode("빈칸을 입력하세요","utf-8"); // get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?msg="+msg);
		return;	
	}
	//2)
	// 요청처리
	// 이미 존재하는 key(dept_no)값 동일한 값이 입력되면 예외(에러)가 발생한다 -> 동일한 dept_no 값이 입력되었을때 예외가 발생되지 않도록
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");

	String sql="INSERT INTO board(board_pw, board_title, board_content, board_writer, createdate) values(?,?,?,?,CURDATE())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// values 물음표 값 채우기
	stmt.setString(1, boardPw);
	stmt.setString(2, boardTitle);
	stmt.setString(3, boardContent);
	stmt.setString(4, boardWrite);
	// 디버깅 
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>