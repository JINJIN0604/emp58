<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	// 요청분석
	String deptNo = request.getParameter("deptNo");
	// deptList의 링크로 호출하지 않고 updateDeptForm.jsp 주소창에 직접 호출하면 deptNo는 null이다
	if(deptNo == null) { 
		response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
		return;	
	}
	// 요청 처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
	String sql = "SELECT dept_name deptName FROM departments WHERE dept_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, deptNo);
	ResultSet rs = stmt.executeQuery(); 
	
	Department dept = null;
	if(rs.next()) { //Requ
		dept = new Department();
		dept.deptNo = deptNo;
		dept.deptName = rs.getString("deptName");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateDeptForm</title>
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
	<form action="<%=request.getContextPath()%>/dept/updateDeptAction.jsp" method="post" >
		<table class=" table table-bordered">
			<tr>
				<td>부서번호</td>
				<td><input type="text" name="deptNo" value="<%=dept.deptNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>부서이름</td>
				<td><input type="text" name="deptName" value="<%=dept.deptName%>"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	</div>
</body>
</html>