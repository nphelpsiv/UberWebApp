<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User menu</title>

</head>
<body>
<b>USER MENU</b><br>
<%
UberController ub = (UberController) session.getAttribute("ub");
%>
<a href="declareFavCar.jsp">Declare a favorite car</a><br> <!-- mckay -->
<a href="denoteTrustUser.jsp">Denote a user as trusted</a><br> <!-- neal -->
<a href="makeCarReservation.jsp">Make a car reservation</a><br>
<a href="giveCarFeedback.jsp">Give car feedback</a><br>
<a href="markResAsRide.jsp">mark a reservation as ride</a><br>
<a href="rateCarFeedback.jsp">Rate car feedback</a><br>
<a href="viewMostUsefulFeedbacks.jsp">View most useful feedbacks on driver</a><br>
<a href="searchForACar.jsp">search for a car</a><br>
<% 
if(ub.currentUser.get_isDriver()) 
{
%>
<b>Driver options: </b><br>
<a href="addNewCar.jsp">Add new car</a><br>
<a href="editCar.jsp">Edit car</a><br>
<a href="addAvailabilityTimes.jsp">Add availability times</a><br>

<% 	
}
%>
<a href="login.jsp">EXIT</a><br>
</body>
</html>