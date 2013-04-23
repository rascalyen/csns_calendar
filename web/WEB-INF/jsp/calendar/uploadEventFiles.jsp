<%@ include file="/WEB-INF/jsp/include/taglib.jspf" %>

<c:set var="headElements">
  <title>CSNS - Upload Attachment</title>
</c:set>
<%@ include file="/WEB-INF/jsp/include/header.jspf" %>

<div id="content">
<ul id="title">
<li>Upload Attachment</li>
</ul>
<p><b>Event:</b> ${event.title}<br />
<b>Description:</b> ${event.description}<br />
<b>Start Time:</b> <fmt:formatDate value="${event.startTime.time}" pattern="yyyy-MM-dd HH:mm:ss" /><br />
<b>End Time:</b> <fmt:formatDate value="${event.endTime.time}" pattern="yyyy-MM-dd HH:mm:ss" /><br />
<c:if test="${not empty event.section}">
<b>Section:</b> ${event.section.id}<br />
</c:if>
</p>

<form method="post" action="uploadEventFiles.html" enctype="multipart/form-data">
<b>File:</b>
<input type="file" name="file1" size="50" />
<input type="submit" class="subbutton" value="Upload" />
<input type="hidden" name="eventId" value="${event.id}" />
<input type="hidden" name="year" value="${year}" />
<input type="hidden" name="month" value="${month}" />
<input type="hidden" name="day" value="${day}" />
</form>

<c:forEach items="${errors}" var="error">
  <div class="error">${error}</div>
</c:forEach>
<br />

<display:table name="${event.attachments}" uid="file" class="viewtable"
    requestURI="uploadEventFiles.html" defaultsort="1">
    <display:setProperty name="basic.msg.empty_list_row" value="<tr><td colspan={0}>No files.</td></tr>" />
    <display:column property="name" href="download.html" paramId="fileId" paramProperty="id" sortable="true" />
    <display:column property="version" sortable="true" />
    <display:column property="size" sortable="true" />
    <display:column sortProperty="date" title="Last Uploaded" sortable="true">
        <fmt:formatDate value="${file.date}" pattern="yyyy-MM-dd HH:mm:ss" />
    </display:column>
</display:table>

<p><button type="button" class="subbutton" onclick="gotoUrl('<c:url value='calendar.html?month=${month}&day=${day}&year=${year}' />');">Done</button></p>
</div>

<%@ include file="/WEB-INF/jsp/include/footer.jspf" %>
