<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="guestbook.Greeting" %>
<%@ page import="guestbook.PMF" %>
<%@include file="header.jsp"%>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.InputStreamReader" %>
<%@page import="java.net.MalformedURLException" %>
<%@page import="java.net.URL" %>


<%! 

public String getContents(String url, String encodeType) {
        URL u;
        StringBuilder builder = new StringBuilder();
        try {
            u = new URL(url);
            try {
                BufferedReader theHTML = new BufferedReader(new InputStreamReader(u.openStream(), encodeType));
                String thisLine;
                while ((thisLine = theHTML.readLine()) != null) {
                    builder.append(thisLine).append("\n");
                } 
            } 
            catch (Exception e) {
                System.err.println(e);
            }
        } catch (MalformedURLException e) {
            System.err.println(url + " is not a parseable URL");
            System.err.println(e);
        }
        return builder.toString();
    }

%>






<div class="content">
        <div class="page-header">
          <h1>Quartet <small>No question is studpid</small></h1>
        </div>
        <div class="row">
            <div class="span10">
                        <h3>CS-450</h3>
                        <iframe src="http://mozilla.github.com/pdf.js/web/viewer.html" frameborder="0" width="500" height="450" id='frameDemo'></iframe>   
                        <iframe src="footer.jsp" frameborder="0" width="500" height="450" id='frameDemo0'></iframe>   
<script>console.log($("#frameDemo")) ;</script>
<script>console.log(window.frames['frameDemo'].document);</script>
<script>
console.log("");

</script>



</div>
             <div class="span4">
                        <h3>Confusion Barrometer</h3>
<%-- 
<%   UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser(); %>
--%>
<%
    if (user != null) {
%>
<p>Hello, <%= user.getNickname() %>! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to include your name with greetings you post.</p>
<%
    }
%>
<%
    PersistenceManager pm = PMF.get().getPersistenceManager();
    String query = "select from " + Greeting.class.getName() + " order by date desc range 0,5";
    List<Greeting> greetings = (List<Greeting>) pm.newQuery(query).execute();
    if (greetings.isEmpty()) {
%>
<p>The guestbook has no messages.</p>
<%
    } else {
        for (Greeting g : greetings) {
            if (g.getAuthor() == null) {
%>
<p>An anonymous person wrote:</p>
<%
            } else {
%>
<p><b><%= g.getAuthor().getNickname() %></b> wrote:</p>
<%
            }
%>
<blockquote><%= g.getContent() %></blockquote>
<%
        }
    }
    pm.close();
%>

    <form action="/sign" method="post">
      <div><textarea name="content" rows="3" cols="60"></textarea></div>
      <div><input type="submit" value="Post Greeting" /></div>
    </form>
                </div> <!--span4-->
                </div> <!--span10-->
             </div> <!--span10-->
      </div><!--row-->
    
<%@include file="footer.jsp"%>
