<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration page</title>
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
String userAttribute = request.getParameter("usernameAttribute");
String driverAttribute = request.getParameter("isDriver");
if(userAttribute == null && driverAttribute == null){
	
%>

	Signup <br>
	
	<form name="user_login" method=get onsubmit="return check_all_fields(this)" action="register.jsp">
		Username: <br>
		<input type=hidden name="usernameAttribute" value="username">
		<input type=text name="usernameValue" length=20>
		<BR>Password: <BR>
		<input type=hidden name="passwordAttribute" value="password">
		<input type=text name="passwordValue" length=20>
		<BR>name: <BR>
		<input type=hidden name="nameAttribute" value="name">
		<input type=text name="nameValue" length=20>
		<BR>address: <BR>
		<input type=hidden name="addressAttribute" value="address">
		<input type=text name="addressValue" length=20>
		<BR>phone: <BR>
		<input type=hidden name="phoneAttribute" value="phone">
		<input type=text name="phoneValue" length=20>
		<BR>Are you a driver? (enter yes or no): <BR>
		<input type=hidden name="isDriverAttribute" value="isDriver">
		<input type=text name="isDriverValue" length=20>
		<input type=submit>
	</form>
	<BR><BR>

  <BR><BR>
 <%
} 
 else{
	  	String username = request.getParameter("usernameValue");
		String password = request.getParameter("passwordValue");
		String name = request.getParameter("nameValue");
		String address = request.getParameter("addressValue");
		String phone = request.getParameter("phoneValue");
		String isDriver = request.getParameter("isDriverValue");
		//UberController ub = new UberController();
		Connector2 con = (Connector2) session.getAttribute("connector2");
		UberController ub = (UberController) session.getAttribute("ub");
		String url = (String) session.getAttribute("url");
		if(ub.setNewUser(username, password, name, address, phone, isDriver, con))
		 {
		 	System.out.print("registration success");
		 	response.sendRedirect(url + "usermenu.jsp");
		 }
		else
		{
			System.out.print("registration failure");
			
		}
		
  }
  %>

</body>
</html>