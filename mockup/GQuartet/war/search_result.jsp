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


<html> 
	<head> 
	<title>GQuartet</title> 
</head> 
<body>


<%

List<SearchResult> l = null; 
DocumentListFeed feed = null; 
  String searchText = "";
  if (request.getParameter("searchText")!=null){
  //Search for text in questions and comments
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

    <h1>Search </h1>
    <fieldset>
    <form action="/search_result.jsp">
      <input type=text name=searchText value=<%=searchText%>>
    </form>
    </fieldset>

    <% if ( l != null ) {
   for ( SearchResult r : l ) { %>
  <a href="/guestbook.jsp?talkName=<%=r.talkName%>&slideNo=<%=r.slideNo%>"><%=r.talkName%></a>has searched text <br>&nbsp;&nbsp;<b><%=r.text%></b> <br>associated with slide no:<%=r.slideNo%>
  </br>
  </br>
  <% } 
   } //if 
   %>

  <% if ( feed != null ) { %>
  <b> Documents Containing The searched Text </b><br>
  <% for ( DocumentListEntry entry: feed.getEntries() ) { %>
  <a href="/testpdf?action=getPdf&resourceId=<%=entry.getResourceId()%>"><%=entry.getTitle().getPlainText()%></a>
  <br>
  <% } }
  
  %>


</body>

</html>

   




