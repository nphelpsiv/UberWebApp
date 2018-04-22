<%@ page language="java" import="cs5530.*" import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rate Car Feedback</title>
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
String fidAttribute = request.getParameter("fidAttribute");
if( vinAttribute == null && fidAttribute ==null ){
%>

	<form name="rate_feedback" method=get onsubmit="return check_all_fields(this)" action="rateCarFeedback.jsp">
		Vin # of the car to view feedbacks:<br>
		<input type=hidden name="vinAttribute" value="vinValue">
		<input type=text name="vinValue" length=10><br><br>
		<input type=submit>
	</form>
	<BR>

<%

} 
else if (fidAttribute == null) {
	String vinValue = request.getParameter("vinValue");
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	
	ArrayList<Feedback> feedbacks = controller.getFeedbackList(vinValue, connector);
	%>
	<table>
		<tr>
			<th>Fid</th>
			<th>User</th>
			<th>Score</th>
			<th>Feedback</th>
			<th>Vin</th>
		</tr>
		<%
		for(Feedback f: feedbacks) {
			%>
			<tr>
				<td><%=f.get_fid()%></td>
				<td><%=f.get_user()%></td>
				<td><%=f.get_score()%></td>
				<td><%=f.get_text()%></td>
				<td><%=f.get_vin()%></td>
			</tr>
			<%
		}
		%>
	</table>
	<br><br>
	<form name="fid_feedback" method=get onsubmit="return check_all_fields(this)" action="rateCarFeedback.jsp">
		Enter the <b>Fid</b> of the feedback you wish to rate:<br>
		<input type=hidden name="fidAttribute" value="fidValue">
		<input type=text name="fidValue" length=10><br><br>
		Enter the rating score you wish to give this feedback. (0, 1, or 2 ('useless','useful', 'very useful' respectively):<br>
		<input type=hidden name="ratingAttribute" value="ratingValue">
		<input type=text name="ratingValue" length=10><br><br>
		<input type=submit>
	</form>
	<BR>
<%
}
else {
	String fidValue = request.getParameter("fidValue");
	String rating = request.getParameter("ratingValue");
	Connector2 connector = (Connector2) session.getAttribute("connector2");
	UberController controller = (UberController) session.getAttribute("ub");
	if(controller.setFeedbackRating(fidValue, rating, connector)) {
		%>
		<b>You Successfully rated fid: <%=fidValue%>, with rating: <%=rating%></b>
		<%
	}
	else {
		%>
		<b>Failed to rate fid: <%=fidValue%></b>
		<%
	}

 //connector.closeConnection();
}
%>

<BR><a href="usermenu.jsp"> Back To Menu</a></p>
</body>
</html>