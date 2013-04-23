<%@ include file="/WEB-INF/jsp/include/taglib.jspf" %>

<c:set var="headElements">
  <title>CSNS - Add a New Event</title>
  <script type="text/javascript">
/* <![CDATA[ */
$(function(){
	$('#startTime').datepicker({
        inline: true
    });         
});
$(function(){
	$('#endTime').datepicker({
        inline: true
    });         
});
/* ]]> */
  </script>  
</c:set>
<%@ include file="/WEB-INF/jsp/include/header.jspf" %>

<div id="content">
<ul id="title">
<li>Add a New Event</li>
</ul>
<br/>
<form:form commandName="event" >
<table class="general">
  <tr><th>Title:</th>
    <td>
       <form:input path="title" cssClass="leftinput" size="30" maxlength="255" />
       <div class="error"><form:errors path="title" /></div>
    </td>
  </tr>
  <tr><th>Description:</th>
    <td><form:input path="description" cssClass="leftinput" size="30" maxlength="255" /></td>
  </tr>
  <tr>
    <th>Start Time:</th>
    <td>
      <form:input path="startTime" cssClass="smallinput" size="10" maxlength="10" />
      -
      <form:input path="startTimeHour" cssClass="smallerinput" size="2" maxlength="2" />
      :
      <form:input path="startTimeMinute" cssClass="smallerinput" size="2" maxlength="2" />
      :
      <form:input path="startTimeSecond" cssClass="smallerinput" size="2" maxlength="2" />
    </td>
  </tr>
    <tr>
    <th>End Time:</th>
    <td>
      <form:input path="endTime" cssClass="smallinput" size="10" maxlength="10" />
      -
      <form:input path="endTimeHour" cssClass="smallerinput" size="2" maxlength="2" />
      :
      <form:input path="endTimeMinute" cssClass="smallerinput" size="2" maxlength="2" />
      :
      <form:input path="endTimeSecond" cssClass="smallerinput" size="2" maxlength="2" />
      <div class="error"><form:errors path="endTime" /></div>
    </td>
  </tr>
<security:authorize ifAllGranted="ROLE_ADMIN">  
  <tr><th>Checked if event is public:</th>
      <td> <form:checkbox path="open" cssStyle="width: auto;" /> </td>
  </tr>
</security:authorize>  
  <tr><th></th><td><input class="subbutton" type="submit" value="Add" /></td></tr>
</table>
</form:form>
</div>

<%@ include file="/WEB-INF/jsp/include/footer.jspf" %>
