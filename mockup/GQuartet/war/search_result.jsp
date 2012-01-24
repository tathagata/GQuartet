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
<%@page import="java.util.*"%>

<%@ include file="header.jsp"%>
<style type="text/css">
body{
background-image: url('http://www.uicargus.com/wp-content/uploads/2010/02/dh-exterior-web.jpg');
background-size:100%;
padding:80px 0 200px;
}
</style>
<div class="topbar" data-dropdown="dropdown">
		<div class="topbar-inner">
			<div class="container-fluid">
				<a class="brand" href="index.jsp">Quartet</a>
				<ul class="nav">
					<li><a href="docs.jsp" target="_blank">Docs</a></li>
					<li><a href="contacts.jsp" target="_blank">Contact</a></li>
				</ul>
				<%@include file="search.jsp"%>
			</div>
		</div>
	</div>

<div class="container">
<%

List<SearchResult> l = null; 
DocumentListFeed feed = null; 
  String searchText = "";
  if (request.getParameter("searchText")!=null){
  //Search for text in questions and comments
  searchText = request.getParameter("searchText");
   l = GQDataStore.SearchText(request.getParameter("searchText"));

  //Search for text in slides associated with presentations
  Map<String,String> searchParam= new HashMap<String,String>();
 
  
    searchParam.put("q", request.getParameter("searchText"));
    DocumentList documentList = new DocumentList(
                 "JavaGDataClientSampleAppV3.0" , "docs.google.com");
    documentList.login("gquartetbeta@gmail.com", "Google!234");
    feed =  documentList.search(searchParam);
    }

    %>

<div class="hero-unit">
<div class="module module-header">
<div class="flex-module">
<div class="row">

<h2>Discussions</h2>
    <% if ( l != null ) {
   for ( SearchResult r : l ) { %>
<div class="span4">
  <a href="/guestbook.jsp?talkName=<%=r.talkName%>&slideNo=<%=r.slideNo%>"><%=r.talkName%></a>
</div>
<div class="span12">
<b><%=r.text%></b> in slide no:<%=r.slideNo%>
</div>
 
  <% } 
   } //if 
   %>
</div>
</div>
</div>
</div>

<div class="hero-unit">
<div class="module module-header">
<div class="flex-module">
<div class="row">
<h2>Lecture Notes</h2>
  <% if ( feed != null ) { %>
  <% for ( DocumentListEntry entry: feed.getEntries() ) { %>
<div class="span4">
  <a href="/testpdf?action=getPdf&resourceId=<%=entry.getResourceId()%>"><%=entry.getTitle().getPlainText()%></a>
  <br>
</div>
  <% } }
  
  %>
</div>
</div>
</div>
</div>

<div class="hero-unit">
<div class="module module-header">
<div class="flex-module">
<div class="row">

<h2>Google Book search</h2>
<div id="content"></div>
    <script>
      function handleResponse(response) {
      for (var i = 0; i < response.items.length; i++) {
        var item = response.items[i];
        // in production code, item.text should have the HTML entities escaped.
        document.getElementById("content").innerHTML += "<br>" + item.volumeInfo.title;
         	}
        }
      </script>
      <script src="https://www.googleapis.com/books/v1/volumes?q=<%=searchText%>&callback=handleResponse"></script>

</div>
</div>
</div>
</div>
</div>


<%@ include file="footer.jsp"%>

   




