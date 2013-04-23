<%@ include file="/WEB-INF/jsp/include/taglib.jspf" %>

<c:set var="headElements">
  <title>CSNS - Event Search Results</title>
  <style type="text/css">
/* <![CDATA[ */
    .subject { font-size: large; }
    .body { margin: 1em; }
/* ]]> */
  </style>
</c:set>
<%@ include file="/WEB-INF/jsp/include/header.jspf"%>

<div id="content">

<ul id="title">
<li>Event Search Results</li>
<div id="forums_menu"> 
<form action="searchEvents.html" method="post">
<input type="text" class="input_search" name="query" />
<input type="submit" class="subbutton" name="search" value="Event Search" />
</form>
</div>
</ul>

<c:if test="${resultSize == 0}">
<h4>No events found.</h4>
</c:if>

<c:if test="${resultSize > 0}">
<table class="forums">
<tr>
<th colspan="2">Found ${resultSize} event(s) that match <i>${param.query}</i>.</th>
</tr>
<c:forEach items="${events}" var="event" varStatus="status">
<tr<c:if test="${(status.index+1)%2 eq 0}"> class="even"</c:if>>
<td class="count center">${status.index+1}</td>
<td class="cat">
<a class="" href="viewEvent.html?eventId=${event.id}">
  <span class="search-result-title"><b>${event.title}</b></span><br />
  <span class="search-result-body">${event.description}</span><br />
  <span class="search-result-body">start: <fmt:formatDate value="${event.startTime.time}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
  <span class="search-result-body"> end: <fmt:formatDate value="${event.endTime.time}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
</a>
</td>
</tr>
</c:forEach>


</table>
</c:if>


</div>

<%@ include file="/WEB-INF/jsp/include/footer.jspf" %>
