<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trusted User</title>
<script LANGUAGE="javascript">

function check_all_fields(form_obj){
	alert(form_obj.otherUserAttribute.value+"='"+form_obj.otherUserAttribute.value+"'");
	if( form_obj.otherUserAttribute.value == ""){
		alert("Search field should be nonempty");
		return false;
	}
	return true;
}

</script> 
</head>
<body>

<%
String otherUserAttribute = request.getParameter("otherUserAttribute");
if( otherUserAttribute == null ){
%>

	
	<form name="declare_trusted" method=get onsubmit="return check_all_fields(this)" action="denoteTrustUser.jsp">
		Other user (their username) that you trust or don't trust:<br>
		<input type=hidden name="otherUserAttribute" value="otherUser">
		<input type=text name="otherUserValue" length=10><br><br>
		Do you trust this user? (Enter "yes" or "no")<br>
		<input type=hidden name="trustedAttribute" value="trustedUser">
		<input type=text name="trustedValue" length=10><br>
		<input type=submit>
	</form>
	<BR>

<%

} else {
	String otherUserValue = request.getParameter("otherUserValue");
	String isTrusted = request.getParameter("trustedValue");
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	if(controller.declareTrusted(otherUserValue, isTrusted, connector)) {
		%>
		<b>You Successfully trusted: #<%=otherUserValue%></b>
		<%
	}
	else {
		%>
		<b>Failed to trust: #<%=otherUserValue%></b>
		<%
	}

 //connector.closeConnection();
}  // We are ending the braces for else here
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>
</body>
</html>