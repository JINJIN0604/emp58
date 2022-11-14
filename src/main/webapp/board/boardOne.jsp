<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*"%>
<%@ page import = "vo.*" %>
<%
	// 1. 요청분석
	request.setCharacterEncoding("utf-8"); // 한글 인코딩
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// 댓글 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//2 요청처리 후 필요하다면 모델데이터 생성
	final int ROW_PER_PAGE = 5; // 변수 선언 앞에 final 붙이면 상수가 된다
	int beginRow = (currentPage-1)*ROW_PER_PAGE; //limit beginRow, ROW_PER_PAGE

	Class.forName("org.mariadb.jdbc.Driver"); //드라이버 로딩
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234"); //DB접속
	String boardSql = "SELECT board_title boardTitle, board_content boardContent, board_writer boardWriter, createdate FROM board WHERE board_no = ?";
	PreparedStatement boardStmt = conn.prepareStatement(boardSql);
	boardStmt.setInt(1, boardNo);
	ResultSet boardRs = boardStmt.executeQuery();
	Board board = null;
	if(boardRs.next()) {
		board = new Board();
		board.boardNo = boardNo;
		board.boardTitle = boardRs.getString("boardTitle");
		board.boardContent = boardRs.getString("boardContent");
		board.boardWriter = boardRs.getString("boardWriter");
		board.createdate = boardRs.getString("createdate");
	}

	//2-1
	String cntSql="SELECT COUNT(*) cnt FROM board";
	PreparedStatement cntStmt = conn.prepareStatement(cntSql);
	ResultSet cntRs= cntStmt.executeQuery();
	int cnt = 0; //전체 행의 수
	if(cntRs.next()){
		cnt = cntRs.getInt("cnt");
	}
	//올림 5.3 -> 6.0, 5.0-> 5.0
	int lastPage = (int)(Math.ceil((double)cnt / (double)ROW_PER_PAGE));
	

	// 2-2. 게시글 댓글 목록
	// 댓글도 페이징 필요함


	// 한 페이지 당 출력할 댓글 목록
	String commentSql = "SELECT comment_no commentNo, comment_content commentContent FROM comment WHERE board_no=? ORDER BY comment_no DESC LIMIT ?,?";
	PreparedStatement commentStmt = conn.prepareStatement(commentSql);
	commentStmt.setInt(1, boardNo);
	commentStmt.setInt(2, beginRow);
	commentStmt.setInt(3, ROW_PER_PAGE);
	ResultSet commentRs= commentStmt.executeQuery();
	ArrayList<Comment> commentList = new ArrayList<Comment>();
	while(commentRs.next()) {
		Comment c = new Comment();
		c.commentNo = commentRs.getInt("commentNo");
		c.commentContent = commentRs.getString("commentContent");
		commentList.add(c);
	}
	
	// 2-3 댓글 전체행의 수 -> lastPage

	// 3. 출력
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne.jsp</title>
<!-- 부트스트랩 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-3">
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<br>
		<h2>게시글 상세보기</h2>
		<table class="table table-hover">
			<tr>
				<td>번호</td>
				<td><%=board.boardNo%></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><%=board.boardTitle%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><%=board.boardContent%></td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td><%=board.boardWriter%></td>
			</tr>
			<tr>
				<td>생성날짜</td>
				<td><%=board.createdate%></td>
			</tr>
		</table>
			<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>">수정</a>
			<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=boardNo%>">삭제</a>
	</div>	
	<br>	
	<!-- 댓글 입력 폼 -->
	<div class="container mt-3">
		<h2>댓글입력</h2>
		<form action="<%=request.getContextPath() %>/board/insertCommentAction.jsp" method="post">
			<input type="hidden" name="boardNo" value="<%=board.boardNo%>">
			<table class="table">
				<tr>
					<td>내용</td>
					<td><textarea rows="3" cols="80" name="commentContent"></textarea></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="commentPw"></td>
				</tr>
			</table>
			<button type="submit">댓글입력</button>
		</form>
	</div>
	
	<!-- 댓글 -->
	<div class="container mt-3">
		<h2>댓글</h2>
		<%
			for(Comment c : commentList) {
		%>
				<div> 
					<div>
						<%=c.commentNo%>
						<%=c.commentContent%>
					
						<a href="<%=request.getContextPath()%>/board/updateCommentForm.jsp?commentNo=<%=c.commentNo%>&boardNo=<%=boardNo%>">[수정]</a>
						<a href="<%=request.getContextPath()%>/board/deleteCommentForm.jsp?commentNo=<%=c.commentNo%>&boardNo=<%=boardNo%>">[삭제]</a>
					</div>
				</div>
		<%
			}		
		%>
		<!-- 페이징 코드 -->
		<div class = "text-center">
			<div>
				현재페이지 : <%=currentPage %>
			</div>
		<div>
		<a href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=1%>">처음</a>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=<%=currentPage-1%>">이전</a>	
		<%
			}
		
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</div>
	</div>
</body>
</html>