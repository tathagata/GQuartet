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

<%
	String talkKey = "";// GQDataStore.AddNewTalk("presentation:0AYyutri7KO7bZDlycjRyY18wZGo5cWd6OHA"
//	String talkKey =  GQDataStore.AddNewTalk("presentation:0AYyutri7KO7bZDlycjRyY18wZGo5cWd6OHA"
//                , new Date() 
//                , "GoogleDemo" + new Date());
	Talk talk; 
	if ((request.getParameter("talkKey"))!=null){
		talkKey = request.getParameter("talkKey");
	}else{
		talkKey =  GQDataStore.AddNewTalk("presentation:0AYyutri7KO7bZDlycjRyY18wZGo5cWd6OHA"
                , new Date() 
                , "GoogleDemo" + new Date());
		
	}
	talk = GQDataStore.GetTalkByKey(talkKey);
%>



<!DOCTYPE html> 
<html> 
	<head> 
	<title>GQuartet</title> 
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />i
	<link rel="stylesheet" href="style.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
</head> 
<body> 
<script>

       function onSuccess(data, status)
        {
            data = $.trim(data);
            $("#notification").text(data);
        }
 
        function onError(data, status)
        {
            // handle an error
        }       
 
        $(document).ready(function() {
            $("#previous").click(function(){
 
                var formData = $("#callPrevious").serialize();
 
                $.ajax({
                    type: "POST",
                    url: "navigator",
                    cache: false,
                    data: formData,
                    success: onSuccess,
                    error: onError
                });
 
                return false;
            });
	$("#next").click(function(){
 
                var formData = $("#callNext").serialize();
 
                $.ajax({
                    type: "POST",
                    url: "navigator",
                    cache: false,
                    data: formData,
                    success: onSuccess,
                    error: onError
                });
 
                return false;
            });
	$("#showQ").click(function(){
 
                var formData = $("#showQuestions").serialize();
 
                $.ajax({
                    type: "POST",
                    url: "questions.jsp",
                    cache: false,
                    data: formData,
                    success: onSuccess,
                    error: onError
                });
 
                return True;
            });

        });


</script>

<div data-role="page">

	<div data-role="header">
		<h1><%=talkKey %></h1>
	</div><!-- /header -->
	
		<div class="center-wrapper" data-role="controlgroup" data-type="horizontal">
			<form id="callPrevious" action="navigator">
			<input type="hidden" name="talkKey" value="<%=talkKey%>">
			<input type="hidden" name="action" value="moveSlideBackward">
			<button id="previous" data-theme="a" type="submit">Prev</button>
			</form>
			<a href="questions.jsp?talkKey=<%=talkKey%>&slideNo=<%=talk.activeSlideNo%>" data-role="button" data-icon="info">Show Q</a>
			<form id="callNext" action="">
			<input type="hidden" name="talkKey" value="<%=talkKey%>">
			<input type="hidden" name="action" value="moveSlideForward">
			<button id="next" data-theme="a" type="submit">Next</button>
			</form>
		</div>
		<div id="notification"><label id="Slide Number">Slide Number by JSP:</label><%=talk.activeSlideNo%></div>
	</div>

	</div><!-- /content -->
	
</div><!-- /page -->

</body>
</html>
