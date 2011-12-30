<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<html>
  Create New Talk:
  <form action="/testdb?action=addnewtalk" method="post">
    Talk Name:
    <input type="text" name="talkname"/>
    Resource Id:
    <input type="text" name="resourceid" value="presentation:0AYyutri7KO7bZDlycjRyY18wZGo5cWd6OHA"/>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=addSlide" method="post">
    <p>Add Slide</p>
    Talk key
    <input type="text" name="parentKey"/>
    Slide No
    <input type="text" name="slideNo"/>

    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=addQuestion" method="post">
    <p>Add Question</p>
    Slide Key
    <input type="text" name="parentKey"/>
    Question Text
    <input type="text" name="questionText"/>
    Rating
    <input type="text" name="rating" value=0>

    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=addComment" method="post">
    <p>Add Comment for a Question</p>
    Question Key
    <input type="text" name="parentKey"/>
    Comment Text
    <input type="text" name="commentText"/>
    Rating
    <input type="text" name="rating" value=0>
    <input type="submit" value="Submit">
  </form>

 <form action="/testdb?action=getSlideContent" method="post">
    <p>Show All Questions And Comments By Slide No</p>
    <input type="text" name="parentKey"/>
    <input type="text" name="slideNo"/>
    <input type="submit" value="Submit">
  </form>


  <!--

 <form action="/testdb?action=getTalkContent" method="post">
    <p>Show All Content for Talk</p>
    <input type="text" name="parentKey"/>
    <input type="submit" value="Submit">
  </form>


  Get All Talks:
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
  -->





</html>
