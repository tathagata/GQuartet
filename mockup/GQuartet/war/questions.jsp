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
     String talkKey = request.getParameter("talkKey") ;
     //Long slideNo = Long.parseLong(request.getParameter("slideNo"));
     
     Talk talk = GQDataStore.GetTalkByKey(talkKey);
     Slide slide = GQDataStore.GetSlideQuestionsAndComments(talkKey, talk.activeSlideNo);

     if ( slide != null )
     {
     %>
<html>

  <head>
       
    <title>Questions</title> 
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
	<link rel="stylesheet" href="style.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
  </head>
  
<body>
  
   <div class="content-primary">
		<ul data-role="listview" data-theme="c">  

    <% 
	String talkName = "";
    for ( Question q : slide.questions ) { %>
		<li>    
    		<%= q.questionText %>
		</li>
  <% } %>
  
  </ul>
  </div>
  <div class="center-wrapper">
    <img src='https://chart.googleapis.com/chart?cht=p3&chs=250x100&chd=t:<%=slide.likes%>,<%=slide.dislikes%>&chl=like|dislike&chof=png'>
  
  <a href="/navigator.jsp?talkKey=<%=talkKey%>" data-role="button" rel="external">GO back</a>

  </div>
    <%
    }
    else
    {
    %>
         
        <h5>  Error retrieving questions for requested slide.</h5>
       		<a href="/navigator.jsp?talkKey=<%=talkKey%>" rel="external">GO back</a>
     <% } %>
 </body>
</html>
   




