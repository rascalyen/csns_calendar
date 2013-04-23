<%@ include file="/WEB-INF/jsp/include/taglib.jspf" %>

<c:set var="headElements">
  <title>CSNS - Add a New Task</title>
</c:set>
<%@ include file="/WEB-INF/jsp/include/header.jspf" %>

<div id="content">
<ul id="title">
<li>Add a New Task</li>
</ul>
<br/>
<form:form commandName="task" >
<table class="general">
  <tr>
    <th>Title:</th>
    <td><form:input path="title" /></td>
  </tr>
</table>
<input type="submit" name="add" value="Add" />
</form:form>
</div>

<%@ include file="/WEB-INF/jsp/include/footer.jspf" %>
