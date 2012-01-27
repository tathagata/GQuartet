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

<%@ include file="header.jsp"%>


<%
  DocumentListFeed feed=null;

    DocumentList documentList = new DocumentList(
                  "JavaGDataClientSampleAppV3.0" , "docs.google.com");
   
    documentList.login("gquartetbeta@gmail.com", "Google!234");
    feed  =  documentList.getDocsListFeed("presentations");
 
%>



<style type="text/css">

body{

background-image: url('http://www.uicargus.com/wp-content/uploads/2010/02/dh-exterior-web.jpg');
background-size:100%;
padding:200px 0 200px;
background-color: transparent;

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
    <% 	String talkName = "";%>
    
    <table class="bordered-table zebra-striped">
    <thead>
    <tr>
    <th style="background-color:#0064cd; color:white">
    <h2 style="color:white">My Presentations</h2>
    </th>
    </tr>
    </thead>
    <tbody link="black">
        
    <% 
	for ( DocumentListEntry entry : feed.getEntries() ) { 

	talkName = entry.getTitle().getPlainText().replaceAll("[^a-zA-Z0-9]+","");
	%>
  
     <tr>
     <td bgcolor="#fff">      
     <a href="/slideshow.jsp?resourceId=<%=entry.getResourceId()%>&talkName=<%=talkName%>" rel="external"><%=entry.getTitle().getPlainText()%></a> 
    
 </h3>
     </td> 
     </tr>
    
    <% } %>
    
    </tbody>
    </table>

</div>


<%@ include file="footer.jsp"%>




