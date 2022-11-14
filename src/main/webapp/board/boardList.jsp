<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	//1 요청분석
 
 	int currentPage = 1;
	if(request.getParameter("currentPage")!= null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
	}
 
 	//2 요청처리 후 필요하다면 모델데이터 생성
	final int ROW_PER_PAGE = 10; // 변수 선언 앞에 final 붙이면 상수가 된다
	int beginRow = (currentPage-1)*ROW_PER_PAGE; //limit beginRow, ROW_PER_PAGE
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
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
	
	//2-2
	String listSql="SELECT board_no boardNo, board_title boardTitle FROM board ORDER BY board_no ASC LIMIT ?,?";
	PreparedStatement listStmt = conn.prepareStatement(listSql);
	listStmt.setInt(1, beginRow);
	listStmt.setInt(2, ROW_PER_PAGE);
	ResultSet listRs= listStmt.executeQuery(); //모델 source data
	ArrayList<Board> boardList = new ArrayList<Board>();
	while(listRs.next()) { //ResultSet의 API(사용방법)을 모른다면 사용할 수 없는 반복문
		Board b = new Board();
		b.boardNo = listRs.getInt("boardNo");
		b.boardTitle = listRs.getString("boardTitle");
		boardList.add(b);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<title>boardOne.jsp</title>
</head>
<body>
	<!-- 메뉴 partial jsp 구성-->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<div class="container mt-3">
	<h2 class="text-center">자유게시판</h2>
	<!-- 3-1. 모델데이터(ArrayList<Board>) 출력 -->
	<table class="table table-hover">
			<tr>
				<th>번호</th>
				<th>내용</th>
			</tr>
			
			<%
				for(Board b : boardList){
		
			%>
					<tr>
						<td><%=b.boardNo%></td>
						<!-- 제목을 클릭시 상세보기 이동 -->
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>"> <%=b.boardTitle%></a></td>
					</tr>
			<%
				}
			%>
	</table>
	
	<!--3-2 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=1">처음</a>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>">이전</a>	
		<%
			}
		%>
			<span><%=currentPage%></span>
		<% 
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>	
</div>
</body>
</html>