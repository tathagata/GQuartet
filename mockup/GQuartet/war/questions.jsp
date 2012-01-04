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


<%
     String talkKey = request.getParameter("talkKey") ;
     Long slideNo = Long.parseLong(request.getParameter("slideNo"));
     Slide slide = GQDataStore.GetSlideQuestionsAndComments(talkKey, slideNo);

     if ( slide != null )
     {
     %>
<html>
  <head>
    Questions on  <%= slideNo %> ( Total Questions : ) <%=slide.questions.size()%>
  </head>

  <table>
    <% for ( Question q : slide.questions ) { %>
  <tr>
    <td>
      <%= q.questionText %>
    </td>
    </tr>
    <% } %>
  </table>
  <a href="javascript:history.go(-1)">GO back</a>%>
  </html>
    <%
    }
    else
    {
    %>
      <html>
        <head>
          Error retrieving questions for requested slide.
        </head>
        <body>
            <p>
          <i>
            Invalid data passed, User Query String should be : <br><br> talkKey=&lt;talkKey&gt;&slideNo=&lt;slideNo&gt;
          </i>
        </body>
        <a href="javascript:history.go(-1)">GO back</a>%>
      </html>

    <% } %>

   




