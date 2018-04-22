<%@ page language="java" import="cs5530.*" %>
<html>
<head>
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
Connector2 connector2 = new Connector2();
session.setAttribute("connector2", connector2);
UberController ub = new UberController();
session.setAttribute("ub", ub);
String url = "http://localhost:8080/Phase3v2/";
session.setAttribute("url", url);
String userAttribute = request.getParameter("usernameAttribute");
if(userAttribute == null ){
	
%>

	Login \n
	Username:
	<form name="user_login" method=get onsubmit="return check_all_fields(this)" action="login.jsp">
		<input type=hidden name="usernameAttribute" value="username">
		<input type=text name="usernameValue" length=20>
		<BR>Password: <BR>
		<input type=hidden name="passwordAttribute" value="password">
		<input type=text name="passwordValue" length=20>
		<input type=submit>
	</form>
	<BR><BR>

  <BR><BR>
  <% connector2.closeConnection();%>
 <%
 
} 
 else{
	  	String username = request.getParameter("usernameValue");
		String password = request.getParameter("passwordValue");
		session.setAttribute("username", username);
		System.out.print("about to login");
		if(ub.loginUser(username, password, connector2))
		 {
		 	System.out.print("login success");
		 	response.sendRedirect(url + "usermenu.jsp");
		 	
		 }
		else
		{
			System.out.print("login failure");
			connector2.closeConnection();
		}
		
  }
  %>
<BR><a href="register.jsp"> Register new user </a></p>

</body>
