<%@ page contentType="application/vnd.ms-excell; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*"%>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%

	Date date = new Date();  
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddhhmmss");  
	String filname = URLEncoder.encode("게시글관리_"+dayTime.format(date),"UTF-8");
	
	String excelHtml = request.getParameter("excelHtml");
	
	ArrayList list = (ArrayList)request.getAttribute("memberList");
	out.println("list ::: "+list);
	
	response.setHeader("Content-Disposition", "attachment; filename="+filname+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
body,th,td,select,input,option,textarea,h1,h2,h3 {
	font-size: 12px;
	font-family: Arial;
/* 	line-height: 16px; */
}

table {
	table-layout: fixed;
	border-collapse: collapse;
	width: 100%;
}

table,th,td {
	border: 1px solid #656565;
}
</style>
</head>
<body>
	<table>
		<thead>
			<tr style="background-color: #000; height:30px; color: #fff;">
				<th>번호</th>
				<th>이름</th>
				<th>제목</th>
				<th>내용</th>
				<th>조회</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(int i = 0; i < list.size(); i++) {
				Map obj = (Map) list.get(i);
				
		%>
		<tr>
				<td style='mso-number-format: "@"'><%=obj.get("NUM")%></td>
				<td style='mso-number-format: "@"'><%=obj.get("NAME")%></td>
				<td style='mso-number-format: "@"'><%=obj.get("TITLE")%></td>
				<td style='mso-number-format: "@"'><%=obj.get("CONTENT")%></td>
				<td style='mso-number-format: "@"'><%=obj.get("READ_COUNT")%></td>
				<td style='mso-number-format: "@"'><%=obj.get("WRITE_DATE")%></td>
			</tr>
		<% } %>
		</tbody>
	</table>
</body>
</html>
