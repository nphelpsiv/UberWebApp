<%@ page language="java" import="cs5530.*" import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Car</title>
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
	<form name="add_car" method=get onsubmit="return check_all_fields(this)" action="addNewCar.jsp">
		Enter the <b>vin</b> of the new car:<br>
		<input type=hidden name="vinAttribute" value="vinValue">
		<input type=text name="vinValue" length=10><br><br>
		Select the <b>Category</b> for the new car:<br>
		<input type=hidden name="categoryAttribute" value="categoryValue">
		<select name="categoryValue">
			 <option value="Luxury">Luxury</option>
			 <option value="Standard">Standard</option>
			 <option value="Comfort">Comfort</option>
		</select><br><br>
		Enter the <b>make</b> for the new car:<br>
		<input type=hidden name="makeAttribute" value="makeValue">
		<input type=text name="makeValue" length=10><br><br>
		Enter the <b>model</b> for the new car:<br>
		<input type=hidden name="modelAttribute" value="modelValue">
		<input type=text name="modelValue" length=10><br><br>
		Enter the <b>year</b> for the new car:<br>
		<input type=hidden name="yearAttribute" value="yearValue">
		<input type=text name="yearValue" length=10><br><br>
		<input type=submit>
	</form>
	<BR>

<%
}
else {
	String vinValue = request.getParameter("vinValue");
	String categoryValue = request.getParameter("categoryValue");
	String makeValue = request.getParameter("makeValue");
	String modelValue = request.getParameter("modelValue");
	String yearValue = request.getParameter("yearValue");
	
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	if (controller.addNewCar(vinValue, categoryValue, modelValue, makeValue, yearValue, connector)) {
		%>
		<b>Successfully added new car vin: #<%=vinValue%></b>
		<%
	}
	else {
		%>
		<b>Failed to add new car vin: #<%=vinValue%></b>
		<%
	}
	
 //connector.closeConnection();
}
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>
</body>
</html>