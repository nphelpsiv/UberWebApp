<%@ page language="java" import="cs5530.*" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Uber car suggestions</title>
</head>
<body>
<%Connector2 con = (Connector2) session.getAttribute("connector2");
UberController ub = (UberController) session.getAttribute("ub"); 
String url = (String) session.getAttribute("url");%>

<BR>Suggested Cars: <BR>
	<table>
		<tr>
		<th>--Car Vin#--|</th>
		<th>--Owner--|</th>
		<th>--Make--|</th>
		<th>--Model--|</th>
		<th>--Category--</th>
		</tr>
	
	<%
	for(Car car: ub.getUCSuggestions(con))
	{
	%>
		<tr>
		<td>"<%=car.get_vin()%>"</td>
		<td>"<%=car.get_owner()%>"</td>
		<td>"<%=car.get_make()%>"</td>
		<td>"<%=car.get_model()%>"</td>
		<td>"<%=car.get_category()%>"</td>
		</tr>
	<%}
	System.out.println("Reservations cleared after confirmed reservations");
	ub.getReservations().clear();
	%>
	</table>

<a href="usermenu.jsp">return to user menu</a><br>
</body>
</html>