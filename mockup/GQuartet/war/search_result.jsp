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

<%

  //Search for text in questions and comments
  List<SearchResult>  l = GQDataStore.SearchText(request.getParameter("searchText"));

  //Search for text in slides associated with presentations
  Map<String,String> searchParam= new HashMap<String,String>();
  searchParam.put("q", request.getParameter("searchText"));
  DocumentList documentList = new DocumentList(
               "JavaGDataClientSampleAppV3.0" , "docs.google.com");
  documentList.login("gquartetbeta@gmail.com", "Google!234");
  DocumentListFeed feed =  documentList.search(searchParam);


%>
<html> 
	<head> 
	<title>GQuartet</title> 
</head> 
<body>

  <% for ( SearchResult r : l ) { %>
  <a href="/questions.jsp?talkKey=<%=r.talkKey%>&slideNo=<%=r.slideNo%>"><%=r.talkName%></a>has searched text <br>&nbsp;&nbsp;<b><%=r.text%></b> <br>associated with slide no:<%=r.slideNo%>
  </br>
  </br>
  <% } %>

  <b> Documents Containing The searched Text </b><br>
  <% for ( DocumentListEntry entry: feed.getEntries() ) { %>
  <a href="/viewer.jsp?resourceId=<%=entry.getResourceId()%>"><%=entry.getTitle().getPlainText()%></a>
  <br>
  <% } %>


</body>

</html>

   




