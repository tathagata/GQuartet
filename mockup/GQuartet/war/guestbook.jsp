<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.*"%>
<%@page import="com.gquartet.data.*"%>
<%@page import="com.gquartet.*"%>
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
String token ="";
   //log.warning("Req Parameter Talk Name" + request.getParameter("talkName"));
   //log.warning("Req Parameter Slide No" + request.getParameter("slideNo"));

if ((request.getParameter("talkName"))!=null){
   talkName = request.getParameter("talkName");
   //log.warning("Talk Name:" + talkName);

   Talk t = GQDataStore.GetTalkByTalkName(talkName);
   if(t!=null){
     resourceId = t.resourceId;
     talkKey = t.key;
    
Calendar cal = Calendar.getInstance();
     long clientname =  System.currentTimeMillis();//String.format("%1$tH%1$tM%1$tS", cal);
token = ChannelHelper.addChannel(application, ChannelHelper.getChannelKey(String.valueOf(clientname), talkName));

   }else{
   //log.warning("Talk Name:" + talkName+" was not found");
   }

}else{
response.setHeader("Refresh", "0; URL=../index.jsp");
   }

if((request.getParameter("slideNo"))!=null){
     slideNo = Long.parseLong(request.getParameter("slideNo"));
     }

%>

<head>
     <title>GQuartet</title>
   <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
   <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
   <script type="text/javascript" src="/_ah/channel/jsapi"></script>
<script>
  
   $(document).ready(function() {
     $("#listofquestions").accordion();
     $("#listofquestions" ).accordion({ autoHeight: false });
     $("#listofquestions" ).accordion({ collapsible: true });
     $("#listofquestions" ).accordion({ autoHeight: false });
    });
  
</script>
 
<script>
var paused = false;

     channel = new goog.appengine.Channel('<%=token%>');
    onOpened = function() {
     connected = true;
console.log("Opened and connected");
     };
onError = function(){
console.log("There has been an error");
}
onClose = function(){
alert("Connection tear down complete");
}
     onMessage = function(e){
var pageNumber;
console.log(paused);
       pageNumber =$("#slide").contents().find("#pageNumber").val();
       console.log("Message that was recieved = " + e.data);
       var pattern = "SlideNo:"
       if ( e.data.search(pattern) > -1 ){
var newPageNumber = e.data.substring(8,e.data.length);
     console.log("changed by channel Api "+newPageNumber);
           if (paused!=true) {
                console.log("will refresh slide to " + newPageNumber);
                //channel.close();
                //console.log("channel closed");
             window.location = "/guestbook.jsp?talkName=<%=talkName%>&slideNo="+newPageNumber;
           }
       }
}

     socket = channel.open();
     socket.onopen = onOpened;
     socket.onmessage = onMessage;
     socket.onerror = onError;
     socket.onclose = onClose;

</script>
</head>
<div class="topbar" data-dropdown="dropdown">
<div class="topbar-inner">
<div class="container-fluid">
<a class="brand" href="index.jsp">Quartet</a>
<ul class="nav">
<!--<a href="docs.jsp" target="_blank">Docs</a></li>-->
<!--<a href="contacts.jsp" target="_blank">Contact</a></li>-->
</ul>
<%@include file="search.jsp"%>
</div>
</div>
</div>

<div id="allcontent">

<div id="showslides" style="width:65%; height:880px; background-color:#ffffff; position:relative;
margin-top:5px; margin-left:5px; float:left; padding-left:5px; border:0px">
            <script>
              var changedPage;
            </script>
<iframe id="slide" src="viewer/viewer.jsp?talkKey=<%=talkKey%>&resourceId=<%=resourceId%>&slideNo=<%=slideNo%>" frameborder="0" width=100% height=100%></iframe>
</div>
<script>
        $("#slide").load(function(){
        $("#slide").contents().find("#sync").hide();
        $("#slide").contents().find("#async").click(function(){
paused = true;
console.log("async clicked");
         $("#slide").contents().find("#async").hide();
         $("#slide").contents().find("#sync").show();
});
$("#slide").contents().find("#sync").click(function(){
paused = false;
console.log("sync clicked");
         $("#slide").contents().find("#sync").hide();
         $("#slide").contents().find("#async").show();
});

  changedPage = function changedPageHandler(){
var pageNumber;
pageNumber =$("#slide").contents().find("#pageNumber").val();
        console.log("changedPage function was called due to a manual change on page by user "+pageNumber);
     window.location = "/guestbook.jsp?talkName=<%=talkName%>&slideNo="+pageNumber;
}
});
</script>
  
<div id="QuestionsComments" style= "height:880px; width:34%; background-color:#ffffff; position:relative; margin-top:5px;
float:right;overflow:scroll;border: 0px solid #ddd;">
                
<div id="questbox">
         <h4>Ask, Share, Note with <em>others</em></h4>
        </div>
        <div id="postfeed" style="padding-bottom:10px;padding-top:10px">
         <form id="question">
             <input type="hidden" name="rating" value=0 />
             <textarea rows="3" name="questionText" style="width:95%"></textarea>
             <input id="askquestion" type="submit" class="btn success" value="Ask">
           </form>
        </div>
        
<script >
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
          Slide slide = GQDataStore.GetSlideQuestionsAndComments(talkKey, slideNo);
          List<Question> questions = slide.questions;

          log.warning("No of questions = " + questions.size() );
          
        %>


<!-- Questions -->
       <div id="listofquestions">
<% for ( Question q : questions ){ %>
        
         <div id='qbody' style="font-size: 135%;">
          <a href="#"><%=q.questionText %></a>
         </div>
           
          <div>
           <%
List<Comment> comments = q.comments;
           for ( Comment c : comments ){
%>
           <div id="commentList<%=q.key%>" style="padding-left:25px; font-size: 115%;">
             <div>
               <%=c.commentText%>
               <br>
             <img src="http://wewillraakyou.com/wp-content/uploads/2011/06/google-plus1.png" height='20' width='25'>
           &nbsp;<%=c.rating%>
           <hr>
         </div>
          </div>
<%} %>

<div style="padding-left:25px;">
           <form id="<%=q.key%>">
             <input type="hidden" name="parentKey" value="<%=q.key %>"/>
             <input type="hidden" name="rating" value="0">
             <textarea type="text" rows="3" name="commentText" style="width:95%;"></textarea>
             <button class="btn success" onClick='submitComment("<%=q.key%>");return false'>Comment</button>
           </form>
         </div>
        </div>
     <%}%>
</div>
</div>
<script >
function submitComment(questionKey){
var $form = $('#'+questionKey);
         var questionText = $form.find('textarea[name="commentText"]').val();
         //console.log("Comment text is:"+questionText);

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

<div id="feedback" class="center-wrapper" style="padding-left:10px;">
    <a id="like" class="btn primary">Got it!</a>
    <a id="dislike" class="btn primary"> Oops! </a>
    <button id=showhidequestions class="btn primary pull-right" style="float:right;">>></button>
</div>
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
</script>
  
</div>

<script>
$("#showhidequestions").toggle(function(){
$("#like").hide();
$("#dislike").hide();
$("#footer").hide();
$("#showhidequestions").hide();
$("#QuestionsComments").hide();

        $('#showslides').animate({"width": "100%"},500, function(){
        $("#like").show();
     $("#dislike").show();
     $("#footer").show();
     $("#showhidequestions").html('<<');
     $("#showhidequestions").show();
          
        });
         },function(){
               $("#like").hide();
         $("#dislike").hide();
         $("#footer").hide();
         $("#showhidequestions").hide();
           $('#showslides').animate({"width": "65%"}, 500, function(){
          
         $("#QuestionsComments").show();
         $("#like").show();
     $("#dislike").show();
     $("#footer").show();
     $("#showhidequestions").html('>>');
     $("#showhidequestions").show();
         });
          
        });
</script>
      <!--row-->
<%@include file="footer.jsp"%>
