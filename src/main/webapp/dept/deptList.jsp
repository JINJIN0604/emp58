<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	// 요청분석(Controller)
	
	// 요청처리(Model) -> 모델데아터(단일값 or 자료구조형태(배열,리스트,...))
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234"); //localhost:33006
	String sql="SELECT dept_no deptNO, dept_name deptName FROM departments ORDER BY dept_no ASC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs= stmt.executeQuery(); //모델값(데이터)로 ResultSet은 일반적인 타입이 아니고 독립적인 타입도 아니다.
	//ResultSet rs라는 모델자료구조를 좀더 일반적이고 독립적인 자료구조 변경을 하자
	ArrayList<Department> list = new ArrayList<Department> ();
	while(rs.next()) { //ResultSet의 API(사용방법)을 모른다면 사용할 수 없는 반복문
		Department d = new Department();
		d.deptNo = rs.getString("deptNo");
		d.deptName = rs.getString("deptName");
		list.add(d);
	}
	// 출력(View) -> 모델데이터를 고객이 원하는 형태로 출력 -> 뷰리포트(보고서)
%>
<!DOCTYPE html>
	<html>
		<head>
			<style>
			h1 {
				text-align: center;
				font-size: 40px;
  				color: #FF5E00;
			}
			
			#customers {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 100%;
			}
			
			#customers td, #customers th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}
			
			#customers tr:nth-child(even){background-color: #f2f2f2;}
			
			#customers tr:hover {background-color: #ddd;}
			
			#customers th {
			  padding-top: 12px;
			  padding-bottom: 12px;
			  text-align: left;
			  background-color: #FFFFFF;
			  color: black;
			}
			</style>

	<meta charset="UTF-8">
	<title>deptList</title>
	</head>
	<body>
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- 상대주소 적지말기 -->
		</div>
		<h1>DEPT LIST</h1>
		<table id="customers" >
			<!-- 부서목록출력(부서번호 내림차순으로) -->
			<tr>
				<th>부서번호</th>
				<th>부서이름</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Department d : list) { //자바문법에서 제공하는 foreach문
					
			%>
			<tr>
				<td><%=d.deptNo%></td>
				<td><%=d.deptName%></td>
				<td><a href="<%=request.getContextPath()%>/dept/updateDeptForm.jsp?deptNo=<%=d.deptNo%>">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/dept/deleteDept.jsp?deptNo=<%=d.deptNo%>">삭제</a></td>
			</tr>
			<%
				}
			%>
			<tr>
			<p><a href="<%=request.getContextPath()%>/dept/insertDeptForm.jsp">부서추가</a></p>
			</tr>
		</table>
	</body>
</html>