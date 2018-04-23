<%@ page language="java" import="cs5530.*" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservations</title>
<script type="text/javascript">
function alertConfirmed(){
	alert("Confirmation(s) confirmed");
} 
</script> 
</head>
<body>
<%Connector2 con = (Connector2) session.getAttribute("connector2");
UberController ub = (UberController) session.getAttribute("ub"); 
String url = (String) session.getAttribute("url");%>

<BR>Reservation information: <BR>

<% 
String result = request.getParameter("item");
String confirmRes = request.getParameter("confirmResValue");
String anotherRes = request.getParameter("makeAnotherResValue");
String cancelRes = request.getParameter("cancelResValue");
if(cancelRes != null)
{
	System.out.println("clear resos");
	ub.getReservations().clear();
	response.sendRedirect(url + "usermenu.jsp");
}
else if(confirmRes != null)
{
	System.out.println("confirm reses");
	if(ub.setReservations(con))
	 {
		 //controller.getUCSuggestions(con));
		 response.sendRedirect(url + "UCSuggestions.jsp");
	 }
	 else 
	 {
		 System.out.println("Failed to execute confirmation(s)");
	 }
	
	
}
else if(anotherRes != null)
{
	response.sendRedirect(url + "makeCarReservation.jsp");
}
else if(result != null)
{
	System.out.println("another or first reses");
	ub.getReservations().get(ub.getReservations().size() - 1).set_pid(ub.parseForPiD(result));
	String[] split = result.split("\\|");
	ub.getReservations().get(ub.getReservations().size() - 1).set_time(split[1] + "-" + split[2]);
	ArrayList<Reservation> list = ub.getReservations();
	
	%>
	
	<table>
		<tr>
		<th>Car Vin#--|</th>
		<th>--Date of reservation--|</th>
		<th>--Time of reservation--|</th>
		<th>--Cost</th>
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
<BR>Select one of the following options: <BR>
<form name="confirmButton" action="reservationChoices.jsp">
<input type="submit" name="confirmResValue" value="Confirm Reservation(s)" />
</form>
<form name="anotherResButton" action="reservationChoices.jsp">
<input type="submit" name="makeAnotherResValue" value="Make another Reservation" />
</form>
<form name="cancelResButton" action="reservationChoices.jsp">
<input type="submit" name="cancelResValue" value="Cancel Reservation(s)" />
</form>


</body>
</html>