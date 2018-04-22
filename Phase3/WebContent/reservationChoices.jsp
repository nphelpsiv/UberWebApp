<%@ page language="java" import="cs5530.*" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%Connector2 con = (Connector2) session.getAttribute("connector2");
UberController ub = (UberController) session.getAttribute("ub"); %>

<BR>Reservation information: <BR>

<% 
String result = request.getParameter("item");
if(result != null)
{
	ub.getReservations().get(ub.getReservations().size() - 1).set_pid(ub.parseForPiD(result));
	ub.getReservations().get(ub.getReservations().size() - 1).set_time(result.split("|")[1] +"|"+ result.split("|")[2]);
	ArrayList<Reservation> list = ub.getReservations();
	
	%>
	
	<table>
		<tr>
		<th>Car Vin#</th>
		<th>Date of reservation</th>
		<th>Time of reservation</th>
		<th>Cost</th>
		</tr>
	
	<%
	for(Reservation res: list)
	{
		Reservation reserv = res;
	%>
		<tr>
		<td>"<%=res.get_vin()%>"</td>
		<td>"<%=res.get_Date()%>"</td>
		<td>"<%=res.get_Time()%>"</td>
		<td>"<%=res.get_cost()%>"</td>
		</tr>
	<%}%>
	</table>
<%}%>

</body>
</html>