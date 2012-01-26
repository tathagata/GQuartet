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
	String talkKey = "";
	Talk talk; 
	String resourceId = "";
	String talkName = "";

	
	if ((request.getParameter("talkKey"))!=null){
		talkKey = request.getParameter("talkKey");
		talk = GQDataStore.GetTalkByKey(talkKey);
    		resourceId = talk.resourceId;
		talkName = talk.talkName;
	}else{
		if (request.getParameter("resourceId")!=null){
			resourceId = request.getParameter("resourceId");
		}
		if (request.getParameter("talkName")!=null){
			talkName = request.getParameter("talkName");
		}


    		talkName = talkName.substring(0,3);

		Calendar cal = Calendar.getInstance();
		String timestamp = String.format("%1$tH%1$tM%1$tS", cal);
		talkKey =  GQDataStore.AddNewTalk(resourceId
			, new Date() 
			, talkName + "_" + timestamp );
			
		talk = GQDataStore.GetTalkByKey(talkKey);
	}
%>



<!DOCTYPE html> 
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

       function onSuccess(data, status){
		var talkKey = <%=talkKey%>;
		var talkName = <%= talkName %>;
			console.log("success"+data + talkKey + talkName);
            data = $.trim(data);
            $("#notification").text(data);
        }
 
        function onError(data, status){
            console.log(status);
        }       
 
        $(document).ready(function() {
            $("#previous").click(function(){
                var formData = $("#callPrevious").serialize();
		var _talkKey = "<%=talkKey%>";
		$.post("navigator", {"talkKey":_talkKey, "action":"moveSlideBackward"}, function(data){
			$("#notification").text(data);
		});
            });
	$("#next").click(function(){
		var _talkKey = "<%=talkKey%>";
 		$.post("navigator", {"talkKey":_talkKey, "action":"moveSlideForward"}, function(data){
			$("#notification").text(data);
		});
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
		<h1><%=talk.talkName %></h1>
	</div><!-- /header -->
	
		<div class="center-wrapper" data-role="controlgroup" data-type="horizontal">
			<!--
			<form id="callPrevious" action="navigator">
			<input type="hidden" name="talkKey" value="<%=talkKey%>">
			<input type="hidden" name="action" value="moveSlideBackward">
			<button id="previous" data-theme="a" type="submit">Prev</button>
			</form>
			-->
			<button id="previous" data-theme="a" type="submit">Prev</button>
			<a href="questions.jsp?talkKey=<%=talkKey%>&slideNo=<%=talk.activeSlideNo%>" rel="external" data-role="button" data-icon="info">Show Q</a>
			<button id="next" data-theme="a" type="submit" ">Next</button>
		<div id="notification"><label id="SlideNo:">Slide No:</label><%=talk.activeSlideNo%></div>
		</div>
	</div>

	</div><!-- /content -->
	
</div><!-- /page -->

</body>
</html>
