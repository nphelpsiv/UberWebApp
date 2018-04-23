<%@ page language="java" import="cs5530.*" import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservation as Ride</title>
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
String ridAttribute = request.getParameter("ridAttribute");
String confirmAttribute = request.getParameter("confirmAttribute");
String cancelAttribute = request.getParameter("cancelAttribute");

if( ridAttribute == null && confirmAttribute == null && cancelAttribute == null){

	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	ArrayList<Reservation> pastReservations = (ArrayList<Reservation>) controller.getPastReservations(connector);
	%>
	<b>Previous reservations you have made:</b><br>
	<table>
		<tr>
			<th>Reservation ID</th>
			<th>Car Vin</th>
			<th>Date</th>
			<th>Cost</th>
		</tr>
		<%
		int i = 0;
		for(Reservation r: pastReservations) {
			%>
			<tr>
				<td><%=i %></td>
				<td><%=r.get_vin()%></td>
				<td><%=r.get_Date()%></td>
				<td><%=r.get_cost()%></td>
			</tr>
			<%
			i++;
		}
		%>
	</table>
	<br><br>
	<form name="see_reservations" method=get onsubmit="return check_all_fields(this)" action="markResAsRide.jsp">
		Enter <b>Reservation ID</b> of the reservations you want to mark as completed (A ride).<br>
		<b>Important: </b> To mark multiple at once separate the id's by a comma.<br>
		For example: "0,3,5" (without quotes)<br>
		<input type=hidden name="ridAttribute" value="ridValue">
		<input type=text name="ridValue" length=10><br><br>
		<input type=submit>
	</form>
	<BR>

<%
}
else if (confirmAttribute == null && cancelAttribute == null) {
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	ArrayList<Reservation> pastReservations = (ArrayList<Reservation>) controller.getPastReservations(connector);
	String ridValue = request.getParameter("ridValue");
	String[] rids = null;
	session.setAttribute("ridsValues", ridValue);

	rids = ridValue.split(",");

	for (int i = 0; i < rids.length; i++) {
		int index = Integer.parseInt(rids[i]);
		Ride ride = new Ride(pastReservations.get(index).get_vin(), pastReservations.get(index).get_pid(), pastReservations.get(index).get_cost(), pastReservations.get(index).get_Date());
		controller.getRides().add(ride);
	}
	
	ArrayList<Ride> rides = controller.getRides();
	%>
	
	<b>You have selected these to mark as a ride. Are you sure you wish to confirm?</b><br>
	<table>
		<tr>
			<th>Car Vin</th>
			<th>Date</th>
			<th>Cost</th>
		</tr>
		<%
		int i = 0;
		for(Ride r: rides) {
			%>
			<tr>
				<td><%=r.get_vin()%></td>
				<td><%=r.get_Date()%></td>
				<td><%=r.get_cost()%></td>
			</tr>
			<%
			i++;
		}
		%>
	</table>
	
	<form name="confirm_rides" method=get onsubmit="return check_all_fields(this)" action="markResAsRide.jsp">
		Confirm:? or Cancel?<br>
		<input type=submit name="confirmAttribute" value="Confirm"><br>
		<input type=submit name="cancelAttribute" value="Cancel"><br>
	</form>
	
	<%
}
else {
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	String confirmValue = request.getParameter("confirmAttribute");
	String cancelValue = request.getParameter("cancelAttribute");
	
	if (cancelValue != null) {
		controller.getRides().clear();
	}
	else if (confirmValue != null){
		
		if (controller.setRides(connector)) {
			%>
			<b>Successfully marked Reservations as rides!</b>
			<%
		}
		else {
			%>
			<b>Failed<br> to mark Reservations as rides!
			<%
		}
		
		
		/* String ridValue = (String) session.getAttribute("ridsValues");
		String[] rids = null;
		if (ridValue.contains(",")) {
			rids = ridValue.split(",");
		}
		ArrayList<Reservation> pastReservations = (ArrayList<Reservation>) controller.getPastReservations(connector);
		for (int i = 0; i < rids.length; i++) {
			int index = Integer.parseInt(rids[i]);
			pastReservations.remove(index);
		} */
		controller.getReservations().clear();
		controller.getRides().clear(); 	
		
	}
	
 //connector.closeConnection();
}
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>
</body>
</html>