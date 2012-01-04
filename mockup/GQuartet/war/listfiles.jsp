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
  String nextUrl =  GQUtil.GetHostUrl(request) + "/listfiles.jsp?auth=true";
  String scope = "http://docs.google.com/feeds/";
  boolean secure = false;  // set secure=true to request secure AuthSub tokens
  boolean googleSession = true;
  DocumentListFeed feed=null;

  String authSubUrl = "";
  //authSubUrl = AuthSubUtil.getRequestUrl(nextUrl, scope, secure, googleSession);

  if ( request.getParameter("auth") == null )
  {
   authSubUrl = AuthSubUtil.getRequestUrl(nextUrl, scope, secure, googleSession);
  }
  else
  {

    //Get single use token
    String singleUseToken = AuthSubUtil.getTokenFromReply(request.getQueryString());

    //Now get session token
    String sessionToken = AuthSubUtil.exchangeForSessionToken(singleUseToken, null);

    DocumentList documentList = new DocumentList(
                  "JavaGDataClientSampleAppV3.0" , "docs.google.com");
   
    //documentList.login("gquartetbeta@gmail.com", "Google!234");
    documentList.loginWithAuthSubToken(sessionToken );
    session.putValue("DOC_SESSION_TOKEN", sessionToken);

	  //UserService userService = UserServiceFactory.getUserService();
  	//User user = userService.getCurrentUser();
    feed  =  documentList.getDocsListFeed("presentations");
  
    }
%>

<html>
  <% if ( request.getParameter("auth") ==null ) /* &&  request.getParameter("auth").equals("true") )  */ { %> 
      Click Here to get authenticated with your Google<a href=<%=authSubUrl%>>Account</a>
  <% } else { %>

  <head>
    List of all presentation for User : 
  </head>

  <table>
    <% for ( DocumentListEntry entry : feed.getEntries() ) { %>
  <tr>
    <td>
      <%=entry.getTitle().getPlainText()%>
    </td>
    <td>
      <a href="/testpdf?action=getPdf&resourceId=<%=entry.getResourceId()%>">Open</a> 
    </td>
    </tr>
    <% } %>
  </table>
  <% } %>

<html>

   




