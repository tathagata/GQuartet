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
	<div class="hero-unit">
            <iframe id="slide" src="viewer/viewer.html" frameborder="0" width="1500" height="450" id='frameDemo'></iframe>   
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
			
			<div class="pill-content">
				<div  id="Ask">
					<div class="row">
						<div class="span1">
								<div class="span1 offset1">
									<img src="images/Question.png" height=35 width=35>
								</div>
						</div>

							<div class="span10">
								<div class="row">
									<div class="span6">
										I am totally confused why the Kardashians are so famous? I get the hot part though ...
									</div>
										<ul class="media-grid">
    										<li>
    											<a href="#"><img class="thumbnail" height=35 width=35 src="https://lh5.googleusercontent.com/-6MAFGmEFPQA/AAAAAAAAAAI/AAAAAAAAAdM/B5ugbriRQOA/s200-c-k/photo.jpg" alt=""></a>
    										</li>
	    									<li>
    											<a href="#"><img class="thumbnail" height=35 width=35 src="https://lh5.googleusercontent.com/-pmaqSWlnG58/AAAAAAAAAAI/AAAAAAAAA2I/3e1PuwiQZhI/s200-c-k/photo.jpg" alt=""></a>
    										</li>
    									</ul>
    							</div>	
							</div>
					</div>
					<hr>
					<div class="row">
						<div class="span1">
								<div class="span1 offset1">
									<img src="images/Question.png" height=35 width=35>
								</div>
						</div>

							<div class="span10">
								<div class="row">
									<div class="span6">
										I am totally confused why the Kardashians are so famous? I get the hot part though ...
									</div>
										<ul class="media-grid">
    										<li>
    											<a href="#"><img class="thumbnail" height=35 width=35 src="https://lh5.googleusercontent.com/-6MAFGmEFPQA/AAAAAAAAAAI/AAAAAAAAAdM/B5ugbriRQOA/s200-c-k/photo.jpg" alt=""></a>
    										</li>
	    									<li>
    											<a href="#"><img class="thumbnail" height=35 width=35 src="https://lh5.googleusercontent.com/-pmaqSWlnG58/AAAAAAAAAAI/AAAAAAAAA2I/3e1PuwiQZhI/s200-c-k/photo.jpg" alt=""></a>
    										</li>
    									</ul>
    							</div>	
							</div>
					</div>
					<hr>					
					<div class="row">
						<div class="span1">
								<div class="span1 offset1">
									<img src="images/Question.png" height=35 width=35>
								</div>
						</div>

							<div class="span10">
								<div class="row">
									<div class="span6">
										I am totally confused why the Kardashians are so famous? I get the hot part though ...
									</div>
										<ul class="media-grid">
    										<li>
    											<a href="#"><img class="thumbnail" height=35 width=35 src="https://lh5.googleusercontent.com/-6MAFGmEFPQA/AAAAAAAAAAI/AAAAAAAAAdM/B5ugbriRQOA/s200-c-k/photo.jpg" alt=""></a>
    										</li>
	    									<li>
    											<a href="#"><img class="thumbnail" height=35 width=35 src="https://lh4.googleusercontent.com/-qMLLc9ygtEo/AAAAAAAAAAI/AAAAAAAABGQ/iTb9uKu8Nlc/s48-c-k/photo.jpgbb" alt=""></a>
    										</li>
    										<li>
    											<a href="#"><img class="thumbnail" height=35 width=35 src="https://lh4.googleusercontent.com/-sTmobuvrAJQ/AAAAAAAAAAI/AAAAAAAAE58/1uqkN7lzXf0/s48-c-k/photo.jpg" alt=""></a>
    										</li>
    									</ul>
    							</div>	
							</div>
					</div>
					
					<hr>					
					
					<div class="pagination">
							<ul>
								<li class="prev disabled"><a href="#">&larr; Previous</a></li>
								<li class="active"><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li class="next"><a href="#">Next &rarr;</a></li>
							</ul>
					</div>
				</div>	
			
				<div class="active" id="Feed">
					<script>
					
					</script>
					<div class="page-header" style="padding-left:60px;padding-bottom:10px">
							<div class="span12" ><h4>Found something interesting? Share it with the class ...</h4></div>
							<div class="input" id="postfeed" style="padding-bottom:10px">
								<textarea rows="3" name="textarea2" id="textarea2"
									class="span14" ></textarea>
							</div>
							<div class="" style="padding-left:0px;padding-bottom:10px">
								<input type="submit" class="btn success" value="Share">
							</div>
						</div>	
						
							<div class="row">
								<div class="span2 offset1">
									<a href="#"><img class="thumbnail" height=50 width=50 src="https://lh5.googleusercontent.com/-6MAFGmEFPQA/AAAAAAAAAAI/AAAAAAAAAdM/B5ugbriRQOA/s200-c-k/photo.jpg" alt=""></a>
								</div>
								<div class="span10">
									<div>
									<h3>Mainul Raju</h3>
									</div>
									<div>
									I must say, Head First HTML 5 is an excellent book to start with. Thanks T. Going to watch Sherlock Holmes now. Watched MI4, just awesome. FYI, ticket is only $10 at ICON theater on Roosevelt.
									</div>
								</div>
							</div>	
							<hr>
							<div class="row">
								<div class="span2 offset1">
									<a href="#"><img class="thumbnail" height=50 width=50 src="https://lh5.googleusercontent.com/-pmaqSWlnG58/AAAAAAAAAAI/AAAAAAAAA2I/3e1PuwiQZhI/s200-c-k/photo.jpg" alt=""></a>
								</div>
								<div class="span10">
								<div>
									<h3>Tathagata Dasgupta</h3>
									</div>
									<div>
								I saw Sherlock Holmes ... Guy Ritchie awesomeness, but doesn't lacks
the tension of the first part. MI4? I hear mixed reviews ... Catch
Girl with the Dragon Tattoo - quite hard hitting. Saw it first day of
release ... hard hitting, really!</div>
							</div>
							</div>
							<hr>
							<div class="row">
								<div class="span2 offset1">
									<a href="#"><img class="thumbnail" height=50 width=50 src="https://lh5.googleusercontent.com/-6MAFGmEFPQA/AAAAAAAAAAI/AAAAAAAAAdM/B5ugbriRQOA/s200-c-k/photo.jpg" alt=""></a>
								</div>
								<div class="span10">This is a piece of information thats rather important!</div>
							</div>
							<hr>
							<div class="row">
								<div class="span2 offset1">
									<a href="#"><img class="thumbnail" height=50 width=50 src="https://lh5.googleusercontent.com/-6MAFGmEFPQA/AAAAAAAAAAI/AAAAAAAAAdM/B5ugbriRQOA/s200-c-k/photo.jpg" alt=""></a>
								</div>
								<div class="span10">This is a piece of information thats rather important!</div>
							</div>
								<label for="textarea"></label>
								

				</div>
			
				<div id="Note" ><iframe class="span16" height=500 src="https://docs.google.com/a/uic.edu/document/d/1aBXqCL8AfFRjvwo-GuWnPrsOwWKfNR5xS93lBIruFGE/edit?hl=en_US"></div>
			</div>
		</div>
		<div class="span5">
				<h2>Stalkbar</h2>
				<div></div>
			</div>
	</div>
</div>




	<!--row-->

<%@include file="footer.jsp"%>