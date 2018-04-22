<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Declare Favorite Car</title>
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
String vinAttribute = request.getParameter("vinAttribute");
if( vinAttribute == null ){
%>

	Declare a car as your favorite:<br>
	<form name="declare_car" method=get onsubmit="return check_all_fields(this)" action="declareFavCar.jsp">
		<input type=hidden name="vinAttribute" value="vin">
		<input type=text name="vinValue" length=10>
		<input type=submit>
	</form>
	<BR>

<%

} else {

	String vinValue = request.getParameter("vinValue");
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	if(controller.declareFavCar(vinValue, controller.currentUser.get_username(), connector)) {
		%>
		<b>Successfully favorited vin: #<%=vinValue%></b>
		<%
	}
	else {
		%>
		<b>Failed to favorite vin: #<%=vinValue%></b>
		<%
	}
	

 //connector.closeConnection();
}  // We are ending the braces for else here
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>

</body>
</html>