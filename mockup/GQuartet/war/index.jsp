<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.*"%>
<%@page import="com.gquartet.data.*"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.*"%>

<%@ include file="header.jsp"%>
<style type="text/css">
body{
background-image: url('http://www.uicargus.com/wp-content/uploads/2010/02/dh-exterior-web.jpg');
background-size:100%;
padding:200px 0 200px;
}
</style>
<div class="topbar" data-dropdown="dropdown">
		<div class="topbar-inner">
			<div class="container-fluid">
				<a class="brand" href="index.jsp">Quartet</a>
				<ul class="nav">
					<li><a href="docs.jsp" target="_blank">Docs</a></li>
					<li><a href="contacts.jsp" target="_blank">Contact</a></li>
				</ul>
				<%@include file="search.jsp"%>
			</div>
		</div>
	</div>


<div class="container">
<div class="hero-unit" id="Professor" >
	<h1> Start a Talk</h1>
	<form action="slideshow.jsp" method="post">
	<div class="clearfix">
	<fieldset>
	<label for="talkName" id="talk_Name" >Talk Name</label>  
	<div class="input">
	    	<input type="text" name="talkName" /> 
		<input class="btn primary" type="submit" value='Start!' />
	</div>
	</fieldset>
	</div>
	</form>
	</div>
<div class="hero-unit" id="Student">
	<h1>View a Talk</h1>
	<form action="guestbook.jsp" method="post">
	<div class="clearfix">
	<fieldset>
	<label for="talkName" id="talk_Name" >Talk Name</label>  
	<div class="input">
	    	<input type="text" name="talkName" /> 
		<input class="btn primary" type="submit" value='Join!'/>
	</div>
	</fieldset>
	</div>
	</form>
	</div>

</div>
<%@ include file="footer.jsp"%>
