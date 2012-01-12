<!DOCTYPE HTML> 
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
	<title>GQuartet</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript" ></script>	
  </head>

  <body>
	<form action="guestbook.jsp" method="post">
	<fieldset>
	<label for="talkKey" id="name_label">TalkKey</label>  
	    	<input type="text" name="talkKey" /> 
		<input type="submit" />
	</fieldset>
	</form>
	 <form action="/testdb?action=getTalkByTalkName" method="post">
    <p>Get Talk by Talk Name</p>
     <input type="text" name="talkname"/>
    <input type="submit" value="Submit">
  </form>

  </body>
</html>
