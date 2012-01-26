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
	<link rel="stylesheet" href="style.css" />


<script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['gauge']});
    </script>
    <script type="text/javascript">
    var gauge;
    var gaugeData;
    var gaugeOptions;
    function drawGauge() {
      gaugeData = new google.visualization.DataTable();
      gaugeData.addColumn('number', 'Cool!');
      gaugeData.addColumn('number', 'Oops!');
      gaugeData.addRows(2);
      gaugeData.setCell(0, 0, 100);
      gaugeData.setCell(0, 1, 100);
    
      gauge = new google.visualization.Gauge(document.getElementById('gaugegotit'));
      gaugeOptions = {
          min: 0, 
          max: 100, 
          yellowFrom: 80,
          yellowTo: 90,
          redFrom: 90, 
          redTo: 100, 
          minorTicks: 5
      };
      gaugeData.setValue(0, 0, <%=slide.likes%> );
      gaugeData.setValue(0, 1, <%=slide.dislikes%> );
      gauge.draw(gaugeData, gaugeOptions);
    }
    
    
    
    google.setOnLoadCallback(drawGauge);
    </script>



  </head>
  
<body>
   
   <div>
		<ul>  

    <% 
	String talkName = "";
    for ( Question q : slide.questions ) { %>
		<li> 
    		<span style="font-size:20px;"><b><%= q.questionText %></b></span>
		</li>
  <% } %>
  
  </ul>
  </div>
     <%
    }
    else
    {
    %>
         
        <h5>  Error retrieving questions for requested slide.</h5>
       		<a href="/navigator.jsp?talkKey=<%=talkKey%>" rel="external">GO back</a>
     <% } %>
	<div id="gaugegotit" style="width: 400px; height: 400px;"></div>

 </body>
</html>
