<%@ page language="java" import="cs5530.*" import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Availability Times</title>
<style>
td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
<script LANGUAGE="javascript">

function check_all_fields(form_obj){
	alert(form_obj.vinAttribute.value+"='"+form_obj.vinValue.value+"'");
	if( form_obj.vinValue.value == ""){
		alert("Search field should be nonempty");
		return false;
	}
	return true;
}

</script> 
</head>
<body>

<%
String pidAttribute = request.getParameter("pidAttribute");
if( pidAttribute == null ){

	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	ArrayList<String> periods = (ArrayList<String>) controller.driverViewPeriods(connector);
	%>
	<b>Available time periods:</b><br>
	<table>
		<tr>
			<th>Pid</th>
			<th>From Hour</th>
			<th>To Hour</th>
		</tr>
		<%
		for(String s: periods) {
			String[] fixed = s.split("\\|");
			%>
			<tr>
				<td><%=fixed[0]%></td>
				<td><%=fixed[1]%></td>
				<td><%=fixed[2]%></td>
			</tr>
			<%
		}
		%>
	</table>
	<br><br>
	<form name="add_car" method=get onsubmit="return check_all_fields(this)" action="addAvailabilityTimes.jsp">
		Enter <b>pid</b> of the time slot you are available for:<br>
		<input type=hidden name="pidAttribute" value="pidValue">
		<input type=text name="pidValue" length=10><br><br>
		<input type=submit>
	</form>
	<BR>

<%
}
else {
	String pidValue = request.getParameter("pidValue");
	
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	if (controller.driverSetAvailability(pidValue, connector)) {
		%>
		<b>Successfully made available for pid #<%=pidValue%></b>
		<%
	}
	else {
		%>
		<b>Failed to make available for pid #<%=pidValue%></b>
		<%
	}
	
 //connector.closeConnection();
}
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>
</body>
</html>