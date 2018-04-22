<%@ page language="java" import="cs5530.*" import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search For Car</title>
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
	alert(form_obj.trustedAttribute.value+"='"+form_obj.trustedValue.value+"'");
	if( form_obj.trustedValue.value == ""){
		alert("Search field should be nonempty");
		return false;
	}
	return true;
}

</script> 
</head>
<body>

<%
String trustedAttribute = request.getParameter("trustedAttribute");
if( trustedAttribute == null ){
	%>
	You can leave any of these blank to not include them in the search.<br>
	<form name="car_search" method=get onsubmit="return check_all_fields(this)" action="searchForACar.jsp">
		Select the Category to search by:<br>
		<input type=hidden name="categoryAttribute" value="categoryValue">
		<select name="categoryValue">
			 <option value=""></option>
			 <option value="Luxury">Luxury</option>
			 <option value="Standard">Standard</option>
			 <option value="Comfort">Comfort</option>
		</select><br>
		Enter the make you want to search by: <br>
		<input type=hidden name="makeAttribute" value="makeValue">
		<input type=text name="makeValue" length=10><br>
		Enter the City or Address you want to search by: <br>
		<input type=hidden name="addressAttribute" value="addressValue">
		<input type=text name="addressValue" length=10><br>
		Should these be AND or OR'd together? OR will broaden your search based on filter(s) selected. AND will constrain your search based on filter(s) selected:
		<input type=hidden name="andorAttribute" value="andorValue">
		<select name="andorValue">
			  <option value="AND">AND</option>
			  <option value="OR">OR</option>
		</select><br>
		Filter results based on trusted user reviews? Or just all reviews?<br>
		<input type=hidden name="trustedAttribute" value="trustedValue">
		<select name="trustedValue">
			<option value="all">All</option>
		  	<option value="trusted">Trusted</option>
		</select><br>
		<input type=submit>
	</form>
	<BR>

<%
}
else {
	
	String categoryValue = request.getParameter("categoryValue");
	String makeValue = request.getParameter("makeValue");
	String addressValue = request.getParameter("addressValue");
	String andorValue = request.getParameter("andorValue");
	String trustedValue = request.getParameter("trustedValue");
	Boolean wantsTrusted = false;
	if (trustedValue.equals("trusted"))
		wantsTrusted = true;
	
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	ArrayList<Car> cars = controller.getCarsBySearch(addressValue, makeValue, categoryValue, wantsTrusted, andorValue, connector);
	%>
	
	<table>
		<tr>
			<th>Owner</th>
			<th>Vin</th>
			<th>Category</th>
			<th>Make</th>
			<th>Model</th>
			<th>Year</th>
		</tr>
		<%
		for(Car c: cars) {
			%>
			<tr>
				<td><%=c.get_owner()%></td>
				<td><%=c.get_vin()%></td>
				<td><%=c.get_category() %>
				<td><%=c.get_make() %>
				<td><%=c.get_model()%></td>
				<td><%=c.get_year()%></td>
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