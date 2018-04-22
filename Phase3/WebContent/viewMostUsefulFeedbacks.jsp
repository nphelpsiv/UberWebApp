<%@ page language="java" import="cs5530.*" import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Most Useful Feedback</title>
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
String driverAttribute = request.getParameter("driverAttribute");
if( driverAttribute == null ){

	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	ArrayList<User> drivers = controller.getAllDrivers(connector);
	%>
	<table>
		<tr>
			<th>id</th>
			<th>Driver Name</th>
			<th>Cars</th>
		</tr>
		<%
		int i = 0;
		for (User u: drivers) {
			%>
				<tr>
					<td><%=i %></td>
					<td><%=u.get_username() %></td>
					<td>
						<%
							for (Car c: u.get_cars()) {
								%>
									Vin: <%=c.get_vin() %> | Make: <%=c.get_make() %> | Model: <%=c.get_model() %> | Year: <%=c.get_year() %><br>
								<%
							}
						%>
					</td>
				</tr>
			<%
			i++;
		}
		%>
	</table>
	<br>
	

	<form name="get_driver" method=get onsubmit="return check_all_fields(this)" action="viewMostUsefulFeedbacks.jsp">
		Enter the <b>index</b> of the driver to view most useful feedbacks for:<br>
		<input type=hidden name="driverAttribute" value="driverValue">
		<input type=text name="driverValue" length=10><br><br>
		Enter the limit as a number for how many feedbacks you wish to view:<br>
		<input type=hidden name="limitAttribute" value="limitValue">
		<input type=text name="limitValue" length=10><br><br>
		<input type=submit>
	</form>
	<BR>

<%
}
else {
	String driverValue = request.getParameter("driverValue");
	String limit = request.getParameter("limitValue");
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	ArrayList<User> drivers = controller.getAllDrivers(connector);
	User user = drivers.get(Integer.parseInt(driverValue));
	
	ArrayList<Feedback> feedbacks = controller.getFeedbackOnDriver(user, Integer.parseInt(limit), connector);
	
	%>
	Feedback for <%=user.get_username() %>.<br>
	<table>
		<tr>
			<th>Rating</th>
			<th>User</th>
			<th>Date</th>
			<th>Car vin</th>
			<th>Score</th>
			<th>Feedback</th>
		</tr>
		<%
		for(Feedback f: feedbacks) {
			%>
			<tr>
				<td><%=f.get_rating()%></td>
				<td><%=f.get_user()%></td>
				<td><%=f.get_date() %>
				<td><%=f.get_vin() %>
				<td><%=f.get_score()%></td>
				<td><%=f.get_text()%></td>
			</tr>
			<%
		}
		%>
	</table>
	
	<%
	

 //connector.closeConnection();
}
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>
</body>
</html>