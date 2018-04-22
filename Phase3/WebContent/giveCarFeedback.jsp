<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Car Feedback</title>
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

	
	<form name="give_feedback" method=get onsubmit="return check_all_fields(this)" action="giveCarFeedback.jsp">
		Vin # of the car to give feedback on:<br>
		<input type=hidden name="vinAttribute" value="vinValue">
		<input type=text name="vinValue" length=10><br><br>
		Integer Score. 0-low, 10-high:<br>
		<input type=hidden name="scoreAttribute" value="scoreValue">
		<input type=text name="scoreValue" length=10><br><br>
		Short Feedback (200 char limit):<br>
		<input type=hidden name="feedbackAttribute" value="feedbackValue">
		<textarea rows="10" cols="30" name="feedbackValue"></textarea><br><br>
		<input type=submit>
	</form>
	<BR>

<%

} else {
	String vinValue = request.getParameter("vinValue");
	String score = request.getParameter("scoreValue");
	String feedback = request.getParameter("feedbackValue");
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	if(controller.giveFeedback(vinValue, score, feedback, connector)) {
		%>
		<b>Successfully gave feedback on: #<%=vinValue%></b>
		<%
	}
	else {
		%>
		<b>Failed to give feedback on: #<%=vinValue%></b>
		<%
	}

 //connector.closeConnection();
}  // We are ending the braces for else here
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>
</body>
</html>