<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
	<%
		//1
		// 페이지 알고리즘
		int currentPage = 1;
		if(request.getParameter("currentPage")!= null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
		}
		
		//2
		int rowPerPage = 10;
		
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
		// lastPage 처리
		String countSql = "SELECT COUNT(*) FROM employees";
		PreparedStatement countStmt = conn.prepareStatement(countSql);
		
		ResultSet countRs = countStmt.executeQuery();
		int count = 0;
		if(countRs.next()) {
			count = countRs.getInt("COUNT(*)");
		}

		
		//마지막 페이지 설정
		int lastPage = count / rowPerPage;
		if(count % rowPerPage != 0){
			lastPage = lastPage + 1; 
			
		}
		
	
		// 한페이지당 출력할 emp목록
		String empSql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY emp_no ASC LIMIT ?,?";
		PreparedStatement empStmt = conn.prepareStatement(empSql);
		empStmt.setInt(1, rowPerPage *(currentPage -1));
		empStmt.setInt(2, rowPerPage);
		ResultSet empRs= empStmt.executeQuery();
		
		ArrayList<Employee> empList = new ArrayList<Employee>();
		while(empRs.next()) {
			Employee e = new Employee();
			e.empNo = empRs.getInt("empNo");
			e.firstName = empRs.getString("firstName");
			e.lastName = empRs.getString("lastName");
			empList.add(e);
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<title>empList.jsp</title>
</head>
<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- 상대주소 적지말기 -->
	</div>
	<div class="container mt-3">
	<h2 class="text-center">사원목록</h2>
	<div>현재 페이지: <%=currentPage%></div>	
	<table class="table table-hover">
		<tr>
			<th>사원번호</th>
			<th>퍼스트네임</th>
			<th>라스트네임</th>
		</tr>
		<%
			for(Employee e : empList) {
	
		%>
			<tr>
				<td><%=e.empNo%></td>
				<td><%=e.firstName%></td>
				<td><%=e.lastName%></td>
			</tr>
		<%
			}
		%>	
			
	</table>
	
	<!-- 페이징 코드 -->
	<div>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=1%>">처음</a>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage-1%>">이전</a>	
		<%
			}
		
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
	</div>	
</body>
</html>