<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@page import="java.net.URLEncoder"%>
<% 
	// 요청분석
	request.setCharacterEncoding("utf-8"); //한글 인코딩

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWriter = request.getParameter("boardWriter");
	String createdate = request.getParameter("createdate");
	
	if(request.getParameter("boardNo") == null || boardTitle == null || boardContent == null || boardWriter == null || createdate == null ||
		request.getParameter("boardNo").equals("") || boardContent.equals("") || boardWriter.equals("") || createdate.equals("")){
		String msg = URLEncoder.encode("수정할 내용을 입력하세요","utf-8"); // get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp");
		return;	
	}
	Board board = new Board();
	board.boardNo = boardNo;
	board.boardPw = boardPw;
	board.boardTitle = boardTitle;
	board.boardContent = boardContent;
	board.boardWriter = boardWriter;
	board.createdate = createdate;

	// 요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql = "UPDATE board SET board_title=?, board_content=?, board_writer=? WHERE board_no=? AND board_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, board.boardTitle);
	stmt.setString(2, board.boardContent);
	stmt.setString(3, board.boardWriter);
	stmt.setInt(4, board.boardNo);
	stmt.setString(5, board.boardPw); 
	
	//디버깅
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("수정성공");
	} else {
		System.out.println("수정실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>