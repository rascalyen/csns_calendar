<%@ include file="/WEB-INF/jsp/include/taglib.jspf" %>

<c:set var="headElements">
  <title>CSNS - View Event</title>
</c:set>
<%@ include file="/WEB-INF/jsp/include/header.jspf" %>

<div id="content">
<ul id="title">
<li>View Event</li>
</ul>
<br/>
<table>
<tr>
<td>Event Title : </td><td>${event.title}</td>
</tr>
<tr>
<td>Description : </td><td>${event.description}</td>
</tr>
<tr>
<td>Start Time : </td>
<td><fmt:formatDate value="${event.startTime.time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td>End Time : </td>
<td><fmt:formatDate value="${event.endTime.time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td>Public Event : </td>
  <td><c:choose> 
       <c:when test="${event.open}">Yes</c:when>
       <c:otherwise>No</c:otherwise>
  </c:choose></td>
</tr>
<c:if test="${not empty event.section}">
<tr>
<td>Class Section : </td><td>${event.section.id}</td>
</tr>
</c:if>
<tr>
<td>Creator : </td><td>${event.creator.username}</td>
</tr>
</table>
<br />
<c:if test="${not empty event.attachments}">
<table class="outer_viewtable" cellpadding="0">
<tr><td>
<display:table name="${event.attachments}" uid="file" class="viewtable" defaultsort="1">
    <display:column property="name" title="File Name" href="download.html" paramId="fileId" paramProperty="id" sortable="true" />
    <display:column property="version" class="center" style="width:10%" />
    <display:column property="size" class="center" sortable="true" style="width:10%" />
    <display:column sortProperty="date" class="center" title="Last Uploaded" sortable="true" style="width:20%">
        <fmt:formatDate value="${file.date}" pattern="yyyy-MM-dd HH:mm:ss" />
    </display:column>
</display:table>
</td></tr>
<tr class="rowtypeb">
<td>
<a href="downloadEventZip.html?eventId=${event.id}">Download All Files</a>
</td>
</tr>
</table>
</c:if>

</div>

<%@ include file="/WEB-INF/jsp/include/footer.jspf" %>
