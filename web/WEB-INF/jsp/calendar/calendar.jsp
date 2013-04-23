<%@ include file="/WEB-INF/jsp/include/taglib.jspf" %>

<c:set var="headElements">
  <title>CSNS - Calendar</title>
</c:set>
<%@ include file="/WEB-INF/jsp/include/header.jspf" %>

<div id="content">

<ul id="title">
<li>Calendar</li>
<div id="forums_menu"> 
<form action="searchEvents.html" method="post">
<input type="text" class="input_search" name="query" />
<input type="submit" class="subbutton" name="search" value="Event Search" />
</form>
</div>
</ul>

<table align="center" width="100%">
<tr>
<td width="25%">
<table align="center" width="95%" ><tr>
   <td align="left" width="5%"><a href="calendar.html?action=-1">&lt;&lt;</td>
   <td align="center" width="90%"><h4>
   <c:out value = "${entries.get(0).thisMonth}  ${entries.get(0).year}"></c:out>
   </h4></td>
   <td align="right" width="5%"><a href="calendar.html?action=1">&gt;&gt;</td>
</tr></table>

<table align="center" border="1" width="100%">
   <tr>
       <th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th>
   </tr>
   <c:forEach begin="0" end="${entries.get(0).totalWeeksOfMonth-1}" step="1" var="i">
       <tr>
       <c:set var="firstDay" value="${entries.get(0).startDayOfFirstWeek-1}" />
       <c:set var="lastDay" value="${entries.get(0).totalDaysOfMonth}" />
       <c:forEach begin="${i*7+1}" end = "${i*7+7}" step="1" var="j">
       
          <c:set var="isBold" value="false" />
          <c:forEach items="${monthEvents}" var="k">
             <c:if test="${j-firstDay == k }">
               <c:set var="isBold" value="true" />
             </c:if>
          </c:forEach> 
           
          <c:choose>
          <c:when test="${j <= firstDay}"><td width="14%">&nbsp;</td></c:when>
          <c:when test="${j > lastDay + firstDay}"><td width="14%">&nbsp;</td></c:when>
          
          <c:when test="${j-firstDay == entries.get(0).currentDay && entries.get(0).month == entries.get(0).currentMonth && entries.get(0).year == entries.get(0).currentYear && isBold}">
             <td align="center" bgcolor=#cccccc width="14%"><b>
             <a href="calendar.html?month=${entries.get(0).month}&day=${j-firstDay}&year=${entries.get(0).year}">${j-firstDay}</a></b></td></c:when>       
          <c:when test="${j-firstDay == entries.get(0).currentDay && entries.get(0).month == entries.get(0).currentMonth && entries.get(0).year == entries.get(0).currentYear}">
             <td align="center" bgcolor=#cccccc width="14%">
             <a href="calendar.html?month=${entries.get(0).month}&day=${j-firstDay}&year=${entries.get(0).year}">${j-firstDay}</a></td></c:when>             

          <c:when test="${j%7 !=0 && isBold}"><td align="center" width="14%"><b>
             <a href="calendar.html?month=${entries.get(0).month}&day=${j-firstDay}&year=${entries.get(0).year}">${j-firstDay}</a></b></td></c:when>
          <c:when test="${j%7 !=0}"><td align="center" width="14%">
             <a href="calendar.html?month=${entries.get(0).month}&day=${j-firstDay}&year=${entries.get(0).year}">${j-firstDay}</a></td></c:when>
                          
          <c:when test="${j%7 == 0 && isBold}"><td align="center" width="14%"><b><a href="calendar.html?month=${entries.get(0).month}&day=${j-firstDay}&year=${entries.get(0).year}">${j-firstDay}</a></b></td></tr></c:when>
          <c:when test="${j%7 == 0}"><td align="center" width="14%"><a href="calendar.html?month=${entries.get(0).month}&day=${j-firstDay}&year=${entries.get(0).year}">${j-firstDay}</a></td></tr></c:when>
          </c:choose>
       </c:forEach>
   </c:forEach>
</table>
</td>

<td width="52%" align="center" valign="top">
<security:authorize ifAllGranted="ROLE_USER">
<c:if test="${not empty message}">
<p>${message} | <a href="addEvent.html?month=${month}&day=${day}&year=${year}">Add a New Event</a></p>
</c:if>
</security:authorize>
<c:if test="${not empty events}">
<table width="90%"> 
<tr><th>Event Title</th><th>Start Time</th><th>End Time</th><th>&nbsp;</th><th>&nbsp;</th></tr>
<c:forEach items="${events}" var="i">
     <tr><td align="left"><a href="viewEvent.html?eventId=${i.id}">${i.title}</a></td>     
     <td align="center"><fmt:formatDate value="${i.startTime.time}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
     <td align="center"><fmt:formatDate value="${i.endTime.time}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
<security:authorize ifAllGranted="ROLE_USER">
<c:choose>
   <c:when test="${not empty message }">
     <td align="center"><a href="editEvent.html?eventId=${i.id}&month=${month}&day=${day}&year=${year}">edit</a></td>
     <td align="right"><a href="uploadEventFiles.html?eventId=${i.id}&month=${month}&day=${day}&year=${year}">upload</a></td></tr>
   </c:when> 
   <c:otherwise>&nbsp;</c:otherwise>   
</c:choose>
</security:authorize>
</c:forEach>
</table>
</c:if>
</td>

<td width="23%" valign="top" align="center">
<security:authorize ifAllGranted="ROLE_USER">
<c:choose>
  <c:when test="${not empty month}">
    <p><a href="addTask.html?month=${month}&day=${day}&year=${year}">Add a New Task</a></p>
  </c:when>  
  <c:otherwise>
  <p><a href="addTask.html">Add a New Task</a></p>
  </c:otherwise>
</c:choose>
<table width="90%"> 
<c:forEach items="${tasks}" var="i">
  <c:if test="${i.completedDate==null}">
    <tr><td align="left">${i.title}</td>
    <td align="right">
      <c:choose>
        <c:when test="${not empty month}">
          <a href="markTask.html?taskId=${i.id}&month=${month}&day=${day}&year=${year}">done</a> 
        </c:when>  
        <c:otherwise><a href="markTask.html?taskId=${i.id}">done</a></c:otherwise>
      </c:choose>
    </td></tr>
  </c:if>
</c:forEach>
</table>
</security:authorize>
</td>

</tr>
</table>

</div>
<%@ include file="/WEB-INF/jsp/include/footer.jspf" %>

