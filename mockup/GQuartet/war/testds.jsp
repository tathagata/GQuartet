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



  <form action="/testdb?action=addFeed" method="post">
    <p>Add Question</p>
    Slide Key
    <input type="text" name="parentKey"/>
    Question Text
    <input type="text" name="feedText"/>
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

  <form action="/testdb?action=updateActiveSlide" method="post">
    <p>Update Active Slide No</p>
    Talk Key
    <input type="text" name="talkKey"/>
    New Active Slide
    <input type="text" name="slideNo"/>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=updateQuestionRating" method="post">
    <p>Update Question Rating</p>
    Question Key
    <input type="text" name="questionKey"/>
    New Rating
    <input type="text" name="rating"/>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=updateCommentRating" method="post">
    <p>Update CommentRating</p>
    Comment Key
    <input type="text" name="commentKey"/>
    New Rating
    <input type="text" name="rating"/>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=updateFeedRating" method="post">
    <p>Update Feed Rating</p>
    Question Key
    <input type="text" name="feedKey"/>
    New Rating
    <input type="text" name="rating"/>
    <input type="submit" value="Submit">
  </form>

  <p> Get All Talks</p>
  <form action="/testdb?action=getTalkByTalkName" method="post">
    <p>Get Talk by Talk Name</p>
     <input type="text" name="talkname"/>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=searchByTalkKey" method="post">
    <p> Search Text By Talk</p>
    <input type="text" name="talkKey"/>
    <input type="text" name="searchText"/>
    <input type="submit" value="Submit">
  </form>

  <form action="/testdb?action=searchCourse" method="post">
    <p> Search Text Across the Course</p>
    <input type="text" name="talkKey"/>
    <input type="text" name="searchText"/>
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
