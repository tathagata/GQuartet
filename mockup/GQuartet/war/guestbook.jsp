<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.*"%>
<%@page import="com.gquartet.data.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@ include file="header.jsp"%>
<%@page import="java.util.logging.Logger"%>

<%
 Logger log = Logger.getLogger("guestbook.jsp"); 


String talkName = "";
String resourceId = "";
String talkKey = "";
long slideNo = 1;

  log.warning("Req Parameter Talk Name" + request.getParameter("talkName"));
  log.warning("Req Parameter Slide No" + request.getParameter("slideNo"));

if ((request.getParameter("talkName"))!=null){
  talkName = request.getParameter("talkName");
  log.warning("Talk Name:" + talkName);

  Talk t = GQDataStore.GetTalkByTalkName(talkName);
  if(t!=null){
    resourceId = t.resourceId;
    talkKey = t.key;
  }else{
    out.println("<center>Talkname:"+talkName+"</center>");
  }

}else{
	response.setHeader("Refresh", "0; URL=../index.jsp");
  }
if((request.getParameter("slideNo"))!=null){
    slideNo = Long.parseLong(request.getParameter("slideNo"));
    }
%>

<div class="content">
  <iframe id="slide" src="viewer/viewer.jsp?talkKey=<%=talkKey%>&resourceId=<%=resourceId%>&slideNo=<%=slideNo%>" frameborder="0" width="100%" height="200"></iframe>  
    <div class="pull-left"><a id="like" class="btn primary">Got it!</a></div>

    <div class="pull-right"><a id="dislike" class="btn primary">Oops!</a></div>

    <script type="text/javascript">
      $("#like").click(function(){
              console.log("like clicked");
              $.post("/updateutil", {"action":"updateLikes", "talkKey":"<%=talkKey%>", "SlideNo":<%=slideNo%>, "count":1 },function(data){
                console.log(data+<%=slideNo%>); 
                $("#like").removeClass("btn primary");
                $("#like").addClass("btn success disabled");  
                $("#dislike").addClass("btn danger disabled");  
            });

        });
        $("#dislike").click(function(){
              console.log("dislike clicked");
              $.post("/updateutil", {"action":"updateDislikes", "talkKey":"<%=talkKey%>", "SlideNo":<%=slideNo%>, "count":1 },function(data){
                console.log("Reutrned:"+data+":"+<%=slideNo%>);  
                $("#dislike").removeClass("btn primary");
                $("#like").addClass("btn success disabled");  
                $("#dislike").addClass("btn danger disabled");  
            });

        });


    		$("#fullscreen").toggle(function(){
      		$("#social").hide();
      		$("#slide").animate({"height":"+=385"},500);
      		},function(){
      		$("#social").show();
      		$("#slide").animate({"height":"-=385"},500);
    		});


  	</script>


    <div class="span12" style="padding-left:100px" >
      <hr>
          <h4>Ask, Share, Note with <em>others</em></h4>
        </div>
        <div id="postfeed" style="padding-left:100px;padding-bottom:10px">
          <form  id="question">
            <input type="hidden" name="rating" value=0 />
            <textarea rows="2" name="questionText" class="span12"></textarea>
            <input id="askquestion" type="submit" class="btn success" value="ASK">
          </form>
        </div>
        <script >
	var pageNumber;

	$("#slide").load(function(){
		pageNumber = $("#slide").contents().find("#pageNumber").val();
	});
	function changedPage(){
		pageNumber =$("#slide").contents().find("#pageNumber").val();
    console.log("changedPage function was called and page was set to "+pageNumber);
    //$.post("guestbook.jsp", {"talkName":"<%=talkName%>","slideNo":pageNumber});
    window.location = "/guestbook.jsp?talkName=<%=talkName%>&slideNo="+pageNumber;
	}	


          $("#question").submit(function (event){
            event.preventDefault();
            var $form = $(this),
            questionText = $form.find('textarea[name="questionText"]').val(),
            url = '/updateutil';
            console.log("Question text is:"+questionText + "for slide no"+ <%=slideNo%>);


            $.post("/updateutil", {"action":"addQuestion", "parentKey":"<%=talkKey%>", "slideNo":<%=slideNo%>, "questionText":questionText, "rating":0 },function(data){
              console.log("Got back the response: "+data);
              var questiondata = data.split('|');
              var imageurl = "<img src='http://wewillraakyou.com/wp-content/uploads/2011/06/google-plus1.png' height=15 width=20>"; 
              var newquestionchild = "<div class='span11' style='padding-top:7px' ><img src='images/Question.png' height=20 width=20></div><div class='span11'>";
              newquestionchild += "<h5>"+questiondata[1]+"</h5>"+imageurl+"&nbsp;"+questiondata[2]+"</div>";
                  
              console.log(newquestionchild);
              $("#listofquestions").last().append(newquestionchild);
              
              $form.find('textarea[name="questionText"]').val('');
              

            });
          });
        </script>

        <% 
          log.warning("Slide No before calling data store " + slideNo );
          //slideNo = 5;
          Slide slide = GQDataStore.GetSlideQuestionsAndComments(talkKey, slideNo);
          List<Question> questions  = slide.questions;

          log.warning("No of questions = " + questions.size() );
	
        	for ( Question q : questions ){
          	String QPlusSign=" +";
        %>

        <div id="listofquestions" style="padding-left:100px">	
            	<div class="span11" style="padding-top:7px">
              		<img src="images/Question.png" height=20 width=20>
            	</div>

            	<div class="span11" >
              	<h5><%=q.questionText %></h5>
             		<img src="http://wewillraakyou.com/wp-content/uploads/2011/06/google-plus1.png" height=15 width=20></a>
              		&nbsp;<%=q.rating%>												

            	</div>

          	<%
          		List<Comment> comments  = q.comments;
          		for ( Comment c : comments ){
            			String plussign=" +";

          	%>

            <div id="commentList<%=q.key%>">
            <div class="span11 offset3">
              <hr>
            		<%=c.commentText%>
            		<br>
            		<img src="http://wewillraakyou.com/wp-content/uploads/2011/06/google-plus1.png" height=15 width=20>
          		&nbsp;<%=c.rating%>												
        	  </div>
          </div>

        	<%} %>

          <div class="span11 offset1">
            <hr>
          		<form id="<%=q.key%>">
            			<input type="hidden" name="parentKey" value="<%=q.key %>"/>
            			<input type="hidden" name="rating" value="0">
            			<textarea class="span11" type="text" name="commentText"></textarea>
            			<button class="btn success" onClick='submitComment("<%=q.key%>");return false'>Comment</button>
          		</form>
        	</div>
      	</div>
    </div><!-- End of one Question Division -->

	<%}%>
	<script >
  		function submitComment(questionKey){
   			// alert("called");
      			var $form = $('#'+questionKey);
          		var  questionText = $form.find('textarea[name="commentText"]').val();
            		console.log("Comment text is:"+questionText);

                $.post("/updateutil", {"action":"addComment", "parentKey":questionKey, "commentText":questionText, "rating":0 },function(data){
                  var datasplit = data.split('|');
                  var imageurl = "<img src='http://wewillraakyou.com/wp-content/uploads/2011/06/google-plus1.png' height=15 width=20>"; 
                  var newchild = "<div class='span11 offset'><hr>"+datasplit[1]+"<br>"+imageurl+"&nbsp;"+ datasplit[2]+"</div>" 
                  $("#commentList"+questionKey).last().append(newchild);
                  $form.find('textarea[name="commentText"]').val('');
           		});
  			return false;
  		}
	</script>



      <!--row-->
<%@include file="footer.jsp"%>

