<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.*"%>
<%@page import="com.gquartet.data.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@ include file="header.jsp"%>
<%
String talkName = "";
String resourceId = "";
String talkKey = "";
if ((request.getParameter("talkName"))!=null){
talkName = request.getParameter("talkName");
Talk t = GQDataStore.GetTalkByTalkName(talkName); 
if(t!=null){
resourceId = t.resourceId;
talkKey = t.key;
}else{
out.println("<center>Talkname:"+talkName+"</center>");
}

}else{
//	response.setHeader("Refresh", "0; URL=../index.jsp");
}
%>

<div class="content">
  <div class="hero-unit">
    <iframe id="slide" src="viewer/viewer.jsp?talkKey=<%=talkKey%>&resourceId=<%=resourceId%>" frameborder="0" width="1500" height="45" id='frameDemo'></iframe>  
    <div class="pull-right"><a id="fullscreen" class="btn primary">Fullscreen</a></div>

  </div>

  <script>
    $("#fullscreen").toggle(function(){
      $("#social").hide();
      $("#slide").animate({"height":"+=385"},500);
      },function(){
      $("#social").show();
      $("#slide").animate({"height":"-=385"},500);
    });
  </script>

  <script src="js/bootstrap-tabs.js"></script>
  <script>

    $("#.tabs").bind("change", function(e){
    window.activeTab = e.target;
    //e.relatedTarget
    })
  </script>

  <div id="social">
    <div class="row">
      <div class="span15">
        <ul class="tabs" data-tabs="tabs">
          <li class="active"><a href="#Ask">Ask</a></li>
          <li><a href="#Feed">Feed</a></li>
          <li><a href="#Note">Note</a></li>
        </ul>

        <div class="span15" >
          <h4>Have a question? ...</h4>
        </div>
        <div id="postfeed" style="padding-left:0px;padding-bottom:10px">
          <form  id="question">
            <input type="hidden" name="action" value="addQuestion">
            <input type="hidden" name="parentKey" value="<%=talkKey%>"/>
            <input type="hidden" name="slideNo" value="1"/>
            <input type="hidden" name="rating" value=0 />
            <textarea rows="2" name="questionText" class="span15"></textarea>
            <input id="askquestion" type="submit" class="btn success" value="ASK">
          </form>
        </div>
        <script >

          $("#question").submit(function (event){
            alert("alert");
            event.preventDefault();
            var $form = $(this),
            questionText = $form.find('textarea[name="questionText"]').val(),
            url = '/updateutil';
            console.log("Question text is:"+questionText);


            $.post("/updateutil", {"action":"addQuestion", "parentKey":"<%=talkKey%>", "slideNo":"1", "questionText":questionText, "rating":0 },function(data){
              console.log("Got back the response: "+data);
              $("#listofquestions").append(data);
            });
          });
        </script>

        <% Slide slide = GQDataStore.GetSlideQuestionsAndComments(talkKey, 1);
        List<Question> questions  = slide.questions;

        for ( Question q : questions ){
          String QPlusSign=" +";
        %>

        <div id="listofquestions">	
          <div class="row">

            <div class="table.span1" style="padding-top:7px">
              <img src="images/Question.png" height=20 width=20>
            </div>

            <div class="span14" >
              <h5><%=q.questionText %></h5>
              <img src="http://wewillraakyou.com/wp-content/uploads/2011/06/google-plus1.png" height=15 width=20></a>
              <%=QPlusSign%><%=q.rating%>												

            </div>
          <hr>

          <%
          List<Comment> comments  = q.comments;
          for ( Comment c : comments ){
            String plussign=" +";

          %>


          <div class="" style="padding-left:20px">
            <%=c.commentText%>
            <BR>
            <img src="http://wewillraakyou.com/wp-content/uploads/2011/06/google-plus1.png" height=15 width=20></a>
          <%=plussign%><%=c.rating%>												
        </div>

        <hr>

        <%} %>

        <div>
          <form id="<%=q.key%>">
            <input type="hidden" name="parentKey" value="<%=q.key %>"/>
            <input type="hidden" name="rating" value="0">
            <textarea class="span10" type="text" name="commentText"></textarea>

            <button class="btn success" onClick='submitComment("<%=q.key%>");return false'></button>
          </form>
        </div>
      </div>



    </div><!-- End of one Question Division -->

<hr>
<%}%>
<script >
  function submitComment(questionKey){
    alert("called");
      var $form = $(questionKey);
          var  questionText = "asdas";//$form.find('textarea[name="commentText"]').val(),
            console.log("Comment text is:"+questionText);

            $.post("/updateutil", {"action":"addComment", "parentKey":questionKey, "commentText":questionText, "rating":0 },function(data){
                console.log(data);
            });
  return false;
  }
</script>



      <!--row-->
<%@include file="footer.jsp"%>
