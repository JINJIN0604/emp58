<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	// 요청분석
	if(request.getParameter("boardNo") == null) { 
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	return;	
	}
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// deptList의 링크로 호출하지 않고 updateDeptForm.jsp 주소창에 직접 호출하면 boardNo는 null이다

	// 요청 처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
	String sql = "SELECT board_pw boardPw, board_title boardTitle, board_content boardContent, board_writer boardWriter, createdate FROM board WHERE board_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs= stmt.executeQuery();
	Board board = null;
	if(rs.next()){
		board = new Board();
		board.boardNo = boardNo;
		board.boardTitle = rs.getString("boardPw");
		board.boardTitle = rs.getString("boardTitle");
		board.boardContent = rs.getString("boardContent");
		board.boardWriter = rs.getString("boardWriter");
		board.createdate = rs.getString("createdate");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" style="width:500px;">
	<div class="head" >
	<h1>부서수정</h1>
	</div>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- 상대주소 적지말기 -->
	</div>
	<form action="<%=request.getContextPath()%>/board/updateBoardAction.jsp" method="post" >
		<table border="1">
			<tr>
				<td>번호</td>
				<td><input type="text" name="boardNo" value="<%=board.boardNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="boardPw"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="boardTitle" value="<%=board.boardTitle%>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><input type="text"  name="boardContent" value="<%=board.boardContent%>"></td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="boardWriter" value="<%=board.boardWriter%>"></td>
			</tr>
			<tr>
				<td>생성날짜</td>
				<td><input type="text" name="createdate" value="<%=board.createdate%>" readonly="readonly"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	</div>
</body>
</html>