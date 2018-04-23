<%@ page language="java" import="cs5530.*" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Car Reservation</title>
<script LANGUAGE="javascript">

function check_all_fields(form_obj){
	alert(form_obj.userAttribute.value+"='"+form_obj.userValue.value+"'");
	if( form_obj.userValue.value == ""){
		alert("Search field should be nonempty");
		return false;
	}
	return true;
}

</script> 
</head>
<body>
<% 
String vinAttribute = request.getParameter("vinAttribute");
String dateAttribute = request.getParameter("dateAttribute");
String costAttribute = request.getParameter("costAttribute");
if(vinAttribute == null || dateAttribute == null || costAttribute == null)
{

%>
<form name="car_res" method=get onsubmit="return check_all_fields(this)" action="makeCarReservation.jsp">
		<BR> All fields are required: <BR>
		<BR> Vin # for car you wish to reserve: : <BR>
		<input type=hidden name="vinAttribute" value="vin">
		<input type=text name="vinValue" length=20>
		<BR>Date of reservation (Required Format: 'DD-MM-YYYY'): : <BR>
		<input type=hidden name="dateAttribute" value="date">
		<input type=text name="dateValue" length=20>
		<BR>Cost: <BR>
		<input type=hidden name="costAttribute" value="cost">
		<input type=text name="costValue" length=20>
		<input type=submit>
</form>
<%}
else{
	String vin = request.getParameter("vinValue");
	String date = request.getParameter("dateValue");
	String cost = request.getParameter("costValue");
	//UberController ub = new UberController();
	Connector2 con = (Connector2) session.getAttribute("connector2");
	UberController ub = (UberController) session.getAttribute("ub");
	String url = (String) session.getAttribute("url");
	
	
	ArrayList<String> reservetimes = ub.getAvailableReservationTimes(vin, con);
	Reservation res = new Reservation(vin, "-1", Integer.parseInt(cost), ub.stringToDate(date));
	if(reservetimes.size() <= 0)
	{
%>
	  <BR> No times available for this car <BR>
<%
	}
	ub.getReservations().add(res);
%>	
	<BR> Select from one of the available times: <BR>
	<form action="reservationChoices.jsp">
	<select name="item">
  	<%  for(int i = 0; i < reservetimes.size(); i++) { %>
  	<% String result = reservetimes.get(i);%>
   <option value="<%=result%>"><%=result%></option>
  	<% } %>
	</select>
	<input type="submit"/>
	</form>


<% }%>
<a href="usermenu.jsp">return to user menu</a><br>
</body>
</html>