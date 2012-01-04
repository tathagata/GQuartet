<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gquartet.*"%>
<%@ page import="com.gquartet.data.*"%>
<%@ page import="com.google.gdata.data.docs.DocumentListFeed"%>
<%@ page import="com.google.gdata.data.docs.DocumentListEntry"%>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@page  import="com.google.gdata.client.*"%>
<%@page  import="com.google.gdata.client.http.*"%>



<%
  DocumentListFeed feed=null;


    DocumentList documentList = new DocumentList(
                  "JavaGDataClientSampleAppV3.0" , "docs.google.com");
   
    documentList.login("gquartetbeta@gmail.com", "Google!234");

    feed  =  documentList.getDocsListFeed("presentations");
  
%>
<html> 
	<head> 
	<title>GQuartet</title> 
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
	<link rel="stylesheet" href="style.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
</head> 
<body> 
<script>
$(document).bind("mobileinit", function(){
  //apply overrides here
$("#question-input").hide();
});
</script>
<div data-role="page">



	<div data-role="header">
		<h1>View</h1>
	</div><!-- /header -->
	



  <div class="content-primary">
		<ul data-role="listview" data-theme="c">  

    <% for ( DocumentListEntry entry : feed.getEntries() ) { %>
  
    <li>
      <a href="/testpdf?action=getPdf&resourceId=<%=entry.getResourceId()%>"><%=entry.getTitle().getPlainText()%></a> 
    
    </li>
    <% } %>
  </div>
	<div class="center-wrapper" data-role="controlgroup" data-type="horizontal">
			<a href="index.html" data-role="button" data-icon="check">Got it!</a>
			<a href="index.html" data-role="button" data-icon="info">Oops!</a>
			<a id="question" href="index.html" data-role="button" data-icon="plus">Ask</a>
		</div>


</html>

   




