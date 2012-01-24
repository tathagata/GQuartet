<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.*"%>
<%@page import="com.gquartet.data.*"%>
<%@page import="java.io.IOException"%>
<%@ include file="header.jsp"%>
<%
	String talkName = "";
	String resourceId = "";
	String talkKey = "";
	long slideNo=0;
	if ((request.getParameter("talkName"))!=null){
		talkName = request.getParameter("talkName");
		Talk t = GQDataStore.GetTalkByTalkName(talkName); 
		if(t!=null){
			resourceId = t.resourceId;
			talkKey = t.key;
			slideNo = t.activeSlideNo;
		}else{
			out.println("<center>Talkname:"+talkName+"</center>");
		}
		
	}else{
		response.setHeader("Refresh", "0; URL=../index.jsp");
	}
%>
<script	type="text/javascript" src="js/bootstrap-modal.js">
</script>


<div class="content">
            <iframe id="slide" src="viewer/guestviewer.jsp?talkKey=<%=talkKey%>&resourceId=<%=resourceId%>" frameborder="0" style="border: 0; width: 100%; height: 810px;"></iframe>   
<script type="text/javascript">
$("#slide").load(function(){
	$("#slide").contents().find("#controls").hide();
});

</script>

	<!--row-->
<div class="modal hide fade" id="modal-from-dom" style="display: block;width:700px;">
            <div class="modal-header">
              <a class="close" href="#">×</a>
              <h3>Questions</h3>
            </div>
            <div class="modal-body">
            <iframe src="questions.jsp?talkKey=<%=talkKey%>&slideNo=<%=slideNo%>" width='630' frameborder=0 ></iframe>
		</div>
            <div class="modal-footer">
              <a class="btn primary" href="#">Primary</a>
              <a class="btn secondary" href="#">Secondary</a>
            </div>
          </div>
<button class="btn danger" data-keyboard="true" data-backdrop="true" data-controls-modal="modal-from-dom">Questions</button>
</div>

<%@include file="footer.jsp"%>
