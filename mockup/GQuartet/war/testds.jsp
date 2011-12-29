<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<html>
  <form action="/testdb?action=addnewtalk" method="post">
    <input type="text" name="talkname"/>
    <input type="text" name="resourceid" value="presentation:0AYyutri7KO7bZDlycjRyY18wZGo5cWd6OHA"/>
    <input type="submit" value="Submit">
  </form>


  <form action="/testdb?action=getTalks" method="post">
    <p>Click here to get list of talks</p>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=getTalkByTalkName" method="post">
    <p>Get Talk by Talk Name</p>
     <input type="text" name="talkname"/>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=getTalkByKey" method="post">
    <p>Get Talk by Talk Name</p>
     <input type="text" name="key"/>
    <input type="submit" value="Submit">
  </form>





</html>
