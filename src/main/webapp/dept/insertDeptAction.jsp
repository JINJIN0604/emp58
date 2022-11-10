<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="java.net.URLEncoder"%>

<%
	//1)
	// 요청분석
	request.setCharacterEncoding("utf-8"); // 한글인코딩
	// 값 받기
	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName");
	
	if(deptNo == null || deptName == null || deptNo.equals("") || deptName.equals("")){
		String msg = URLEncoder.encode("부서번호와 부서이름을 입력하세요","utf-8"); // get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp"+msg);
		return;	
	}
	//2)
	// 요청처리
	// 이미 존재하는 key(dept_no)값 동일한 값이 입력되면 예외(에러)가 발생한다 -> 동일한 dept_no 값이 입력되었을때 예외가 발생되지 않도록
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	// 쿼리
	//2-1 dept_no 중복검사
	String sql1 = "SELECT * FROM departments WHERE dept_no = ? OR dept_name = ?"; //입력하기전에 같은 dept_no가 존재하는지
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, deptNo);
	stmt1.setString(2, deptNo);
	ResultSet rs = stmt1.executeQuery();
	if(rs.next()){ //결과몰랐다 -> 같은 dept_no가 이미 존재한다
		String msg = URLEncoder.encode(deptNo+"는 사용할 수 없습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp?msg"+msg);
		return;
	}
	//2-2 입력
	String sql2="INSERT INTO departments(dept_no, dept_name) values(?, ?)";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	// values 물음표 값 채우기
	stmt2.setString(1, deptNo);
	stmt2.setString(2, deptName);
	// 디버깅 
	int row = stmt2.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
%>