<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%
	UserService userService =  UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user!=null){
%>
<ul class="nav secondary-nav">
	<li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
	</li>
	<li><a href="#">Logout</a>
	</li>
</ul>



<%		
	}else{
%>
<form action="#" class="pull-right" method="post">
	<ul class="nav">
	<li>Email: <input class="input-small" type="email" placeholder="email"
		name="email"> </li><li> Password: <input class="input-small" type="password"
		placeholder="password" name="password"></li>
	<li><button class="btn" type="submit">Sign in</button></li>
	</ul>
</form>


<%
	}
%>
