<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>index</title>
	
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-light justify-content-center">
		<ul class="navbar-nav">
			<li class="nav-item">
     			 <a class="nav-link" href="<%=request.getContextPath()%>/dept/deptList.jsp">부서관리</a>
    		</li>
    		<li class="nav-item">
     			 <a class="nav-link" href="<%=request.getContextPath()%>/emp/empList.jsp">사원관리</a>
    		</li>
    		<li class="nav-item">
     			 <a class="nav-link" href="<%=request.getContextPath()%>/board/boardList.jsp">게시판관리</a>
    		</li>
    	</ul>
    </nav>
	<div class="container container p-5 my-5 border">
	
		<h1 class="text-center">INDEX</h1>

	</div>

</body>
</html>