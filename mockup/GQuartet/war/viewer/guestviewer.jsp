<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.*"%>
<%@page import="com.gquartet.data.*"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.*"%>

<%
	
	String talkKey = "";
	if ((request.getParameter("talkKey"))!=null){
		talkKey = request.getParameter("talkKey");
	}else{
		out.println(talkKey+"is this");
		response.setHeader("Refresh", "0; URL=../index.jsp");
    }

    String slideNo = request.getParameter("slideNo");

%>





<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet"
	href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">
<link rel="stylesheet" href="viewer.css" />

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript" ></script>
<script type="text/javascript" src="compatibility.js"></script>

<!-- PDFJSSCRIPT_INCLUDE_BUILD -->
<!-- This snippet is used in production, see Makefile -->
<script type="text/javascript" src="pdf.js"></script>
<script type="text/javascript">
	// This specifies the location of the pdf.js file.
	PDFJS.workerSrc = "pdf.js";
</script>
<script type="text/javascript" src="viewer.js"></script>
<script src="../js/sketcher.js"></script>
<script src="../js/trigonometry.js"></script>
<script src="../js/modernizr.custom.34982.js"></script>

<script>
var talkKey = "<%=talkKey%>";
console.log(talkKey);

$(document).ready(function(){
	getCurrentPage();
});


function getCurrentPage(){

	var _url = "../getTalkInfo?action=getCurrentSlide&talkKey="+talkKey;
	$.ajax({
		type:"GET",
		url:_url,
		async:true,
		cache: false,
		timeout: 500,
		success: function(data){
      PDFView.page = data;

      setTimeout('getCurrentPage()',200);
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
			console.log("There was an error fetching current page#");
			setTimeout(
                        'getCurrentPage()', /* Try again after.. */
                        "5000"); /* milliseconds (15seconds) */
                },
	});
}


</script>





</head>

<body>

	<div id="errorWrapper" hidden='true'>
		<div id="errorMessageLeft">
			<span id="errorMessage"></span>
			<button id="errorShowMore" onclick="" oncontextmenu="return false;">
				More Information</button>
			<button id="errorShowLess" onclick="" oncontextmenu="return false;"
				hidden='true'>Less Information</button>
		</div>
		<div id="errorMessageRight">
			<button id="errorClose" oncontextmenu="return false;">Close
			</button>
		</div>
		<div class="clearBoth"></div>
		<div id="errorMoreInfo" hidden='true'></div>
	</div>

	<div id="sidebar">
		<div id="sidebarBox">
			<div id="sidebarScrollView">
				<div id="sidebarView"></div>
			</div>
			<div id="outlineScrollView" hidden='true'>
				<div id="outlineView"></div>
			</div>
			<div id="sidebarControls">
				<button id="thumbsSwitch" title="Show Thumbnails"
					onclick="PDFView.switchSidebarView('thumbs')" data-selected>
					<img src="images/nav-thumbs.svg" align="top" height="16"
						alt="Thumbs" />
				</button>
				<button id="outlineSwitch" title="Show Document Outline"
					onclick="PDFView.switchSidebarView('outline')" disabled>
					<img src="images/nav-outline.svg" align="top" height="16"
						alt="Document Outline" />
				</button>
			</div>
		</div>
	</div>

	<div id="loading">Loading... 0%</div>
	<div id="viewer"></div>
	<div id="controls">
		<button class="btn primary" id="previous" onclick="PDFView.page--;"
			oncontextmenu="return false;">
			<img src="images/go-up.svg" align="top" height="16"> Previous
		</button>

		<button class="btn primary" id="next" onclick="PDFView.page++;"
			oncontextmenu="return false;">
			<img src="images/go-down.svg" align="top" height="16"> Next
		</button>

		<div class="separator"></div>
		<input type="number" id="pageNumber"
			onchange="PDFView.page = this.value;" value="1" size="4" min="1">

		<span>/</span> <span id="numPages">--</span>

		<div class="separator"></div>
		<button id="zoomOut" class="btn primary" title="Zoom Out"
			onclick="PDFView.zoomOut();" oncontextmenu="return false;">
			<img src="images/zoom-out.svg" align="top" height="16">
		</button>
		
		<button id="zoomIn" class="btn primary" title="Zoom In"
			onclick="PDFView.zoomIn();" oncontextmenu="return false;">
			<img src="images/zoom-in.svg" align="top" height="16">
		</button>
		<div class="separator"></div>

		<select id="scaleSelect" onchange="PDFView.parseScale(this.value);"
			oncontextmenu="return false;">
			<option id="customScaleOption" value="custom"></option>
			<option value="0.5">50%</option>
			<option value="0.75">75%</option>
			<option value="1">100%</option>
			<option value="1.25">125%</option>
			<option value="1.5" selected="selected">150%</option>
			<option value="2">200%</option>
			<option id="pageWidthOption" value="page-width">Page Width</option>
			<option id="pageFitOption" value="page-fit">Page Fit</option>
		</select>

		<div class="separator"></div>

		<button id="print" class="btn primary" onclick="window.print();"
			oncontextmenu="return false;">
			<img src="images/document-print.svg" align="top" height="16">
			Print
		</button>

		<button id="download" class="btn primary" title="Download"
			onclick="PDFView.download();" oncontextmenu="return false;">
			<img src="images/download.svg" align="top" height="16">
			Download
		</button>

		<div class="separator"></div>

		<input id="fileInput" type="file" oncontextmenu="return false;">

		<div class="separator"></div>

		<a href="#" id="viewBookmark"
			title="Bookmark (or copy) current location"> <img
			src="images/bookmark.svg" alt="Bookmark" align="top" height="16">
		</a>

		<div class="separator"></div>

		<span id="info">--</span>
	</div>

</body>
</html>
