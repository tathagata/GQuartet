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




<!DOCTYPE HTML> 
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
	<title>GQuartet</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript" ></script>	
  </head>
  <body>
	<form action="slideshow.jsp" method="post">
	<fieldset>
	<label for="talkName" id="talk_Name" >TalkName</label>  
	    	<input type="text" name="talkName" /> 
		<input type="submit" />
	</fieldset>
	</form>
	<hr>
	<form action="guestbook.jsp" method="post">
	<fieldset>
	<label for="talkName" id="talk_Name" >TalkName</label>  
	    	<input type="text" name="talkName" /> 
		<input type="submit" />
	</fieldset>
	</form>

  </body>
</html>
