<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.*"%>
<%@page import="com.gquartet.data.*"%>
<%@page import="com.gquartet.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.*"%>
<%@ include file="header.jsp"%>

<%
	String talkKey = "";
	Talk talk; 
	String resourceId = "";
	String talkName = "";
  long slideNo=0;
  String token="";
	
	if ((request.getParameter("talkKey"))!=null){
		talkKey = request.getParameter("talkKey");
		talk = GQDataStore.GetTalkByKey(talkKey);
    		resourceId = talk.resourceId;
		talkName = talk.talkName;
		slideNo = talk.activeSlideNo;
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

    	Calendar cal1 = Calendar.getInstance();
    	String clientname = String.format("%1$tH%1$tM%1$tS", cal1);
			token = ChannelHelper.addChannel(application, ChannelHelper.getChannelKey(clientname, "Slideshow_" + talkName + "_" + timestamp ));
			
		  talk = GQDataStore.GetTalkByKey(talkKey);
	}
%>



<script	type="text/javascript" src="js/bootstrap-modal.js"></script>
<script type="text/javascript" src="/_ah/channel/jsapi"></script> 
<script>
		var paused = false;
	
   		onOpened = function() {
    			connected = true;
			console.log("Opened and connected");
    		};
		onError = function(){
			console.log("There has been an error");
		}
		onClose = function(){
			//alert("Connection tear down complete");
		}
    onMessage = function(e){
      var pattern = "Question";
      var index = e.data.search(pattern);
      console.log("outside if " + e.data);
      if ( index > -1 )
      {
          var pageNumber = $("#slide").contents().find("#pageNumber").val();
          console.log("pagenumber changed to " + pageNumber );
           $.post("navigator", {"talkKey":"<%=talk.key%>", "action":"getQuestionCount", "currentSlideNo":pageNumber}, function(data){
              console.log("inside condition " + data);
            });
        }
      }

    		channel = new goog.appengine.Channel('<%=token%>');
    		socket = channel.open();
    		socket.onopen = onOpened;
    		socket.onmessage = onMessage;
    		socket.onerror = onError;
    		socket.onclose = onClose;

	</script>

	
<div class="topbar" data-dropdown="dropdown">
		<div class="topbar-inner">
			<div class="container-fluid">
				<a class="brand" href="index.jsp">Quartet</a>
				<ul class="nav">
					<li><a href="docs.jsp" target="_blank">Docs</a></li>
					<li><a href="contacts.jsp" target="_blank">Contact</a></li>
					<li><a href="#"><%=talk.talkName%></a></li>
				</ul>
				<%@include file="search.jsp"%>
				<div class="pull-right">
				</div>
			</div>
			
		</div>
	</div>



<div class="content">
            <iframe id="slide" src="viewer/guestviewer.jsp?talkKey=<%=talkKey%>&resourceId=<%=resourceId%>" frameborder="0" style="border: 0; width: 100%; height: 810px;"></iframe>   
<div>
	<div class="modal hide fade" id="modal-from-dom" style="display: block; height:640px; width:1020px; margin-left:-520px;">
            	<div class="modal-header">
              		<a class="close" href="#">×</a>
              		<h3>Questions</h3>
            	</div>
            	<div class="modal-body">
            	<iframe src="questions.jsp?talkKey=<%=talkKey%>&slideNo=<%=slideNo%>" width=100% height=100% frameborder=0 ></iframe>
		</div>
          </div>
</div>
<div>
	<div class="modal hide fade" id="modal-for-drawing" style="display:block; height:640px; width:1020px; margin-left:-520px;">
	     	<div class="modal-header">
              		<a class="close" href="#">×</a>
              		<h3>Scratchpad</h3>
            	</div>
            	<div class="modal-body">
			<iframe src="scratch/lineTo.html" height=100% width=100% frameborder=0></iframe>
		</div>
        </div>
</div>

<div class="row" style="padding-left:23px;">
<!--<button class="btn danger" data-keyboard="true" data-backdrop="true" data-controls-modal="modal-from-dom">Questions</button>
<button id="scratch" class="btn danger" data-keyboard="true" data-backdrop="true" data-controls-modal="modal-for-drawing">Scratchpad</button>
-->
</div>
<script>
        $("#slide").load(function(){

                 $('#modal-from-dom').modal({keyboard:true, backdrop:true});
                 $('#modal-for-drawing').modal({keyboard:true, backdrop:true});

        $("#slide").contents().find("#previous").click(function(){
          console.log("previous clicked");
	    var pageNumber = $("#slide").contents().find("#pageNumber").val();
	    console.log("pagenumber changed to " + pageNumber );
			$.post("navigator", {"talkKey":"<%=talk.key%>", "action":"moveSlideBackward", "currentSlideNo":pageNumber}, function(data){
				console.log(data);
				});
	    $.post("navigator", {"talkKey":"<%=talk.key%>", "action":"getQuestionCount", "currentSlideNo":pageNumber}, function(data){
				console.log(data);
    });
  });



	
	$("#slide").contents().find("#next").click(function(){
	    console.log("next clicked");
	    var pageNumber = $("#slide").contents().find("#pageNumber").val();
	    console.log("pagenumber changed to " + pageNumber );
		$.post("navigator", {"talkKey":"<%=talk.key%>", "action":"moveSlideForward", "currentSlideNo":pageNumber}, function(data){
			console.log(data);
		});
    $.post("navigator", {"talkKey":"<%=talk.key%>", "action":"getQuestionCount", "currentSlideNo":pageNumber}, function(data){
			console.log(data);
    });
		});
	
	$("#slide").contents().find("#aggregatedquestions").click(function(){
		console.log("#aggregatedquestions");
                 $('#modal-from-dom').modal('toggle');
		});
	
	$("#slide").contents().find("#scratchpad").click(function(){
		console.log("#scratchpad");
                 $('#modal-for-drawing').modal('toggle');
		});
	
  });



</script>
</div>
<%@include file="footer.jsp"%>
