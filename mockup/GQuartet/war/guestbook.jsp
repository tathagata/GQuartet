<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ include file="header.jsp"%>

<div class="sidebar">
        <div class="well">
          <h5>Sidebar</h5>
          <ul>

            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
          </ul>
          <h5>Sidebar</h5>

          <ul>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>

            <li><a href="#">Link</a></li>
          </ul>
          <h5>Sidebar</h5>
          <ul>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
          </ul>

        </div>
      </div>

<div class="content">
        <!--
	<div class="page-header">
          <h1>Quartet <small>No question is studpid</small></h1>
        </div>
	-->
	<div class="hero-unit">
            <iframe id="slide" src="http://mozilla.github.com/pdf.js/web/viewer.html" frameborder="0" width="1500" height="450" id='frameDemo'></iframe>   
		<div class="pull-right"><a id="fullscreen" class="btn primary">Fullscreen</a></div>

        </div>

	<script>
		$("#fullscreen").toggle(function(){
			$("#discussion").hide();
			$("#slide").animate({"height":"+=390"},500);
		},function(){
			$("#discussion").show();
			$("#slide").animate({"height":"-=390"},500);
		});
	</script>

	<div id="discussion" class="row">
          <div class="span16">
            <h2>Heading</h2>
            <p>Etiam porta sem malesuada magna mollis euismod. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</p>
            <p><a class="btn" href="#">View details &raquo;</a></p>

          </div>
          <div class="span5">
            <h2>Heading</h2>
             <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
            <p><a class="btn" href="#">View details &raquo;</a></p>
         </div>
          
        </div>




<!--row-->
    
<%@include file="footer.jsp"%>
