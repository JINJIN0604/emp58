<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.Department" %>
<%@page import="java.net.URLEncoder"%>
<% 
	// 요청분석
	request.setCharacterEncoding("utf-8"); //한글 인코딩

	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName");
	
	if(deptNo == null || deptName == null || deptNo.equals("") || deptName.equals("")){
		String msg = URLEncoder.encode("부서번호와 부서이름을 입력하세요","utf-8"); // get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/dept/updateDeptForm.jsp");
		return;	
	}
	Department dept = new Department();
	dept.deptNo = deptNo;
	dept.deptName = deptName;

	// 요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	// 중복검사
	String sql = "UPDATE departments set dept_name=? WHERE dept_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, deptName);
	stmt.setString(2, deptNo);
	//디버깅
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("수정성공");
	} else {
		System.out.println("수정실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
%>
