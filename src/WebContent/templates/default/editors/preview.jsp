<%-- 
    JSPWiki - a JSP-based WikiWiki clone.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.  
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://jakarta.apache.org/jspwiki.tld" prefix="wiki" %>
<%@ page import="org.apache.wiki.*" %>
<%@ page import="org.apache.wiki.ui.*" %>
<%@ page import="org.apache.wiki.filters.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://stripes.sourceforge.net/stripes.tld" prefix="stripes" %>
<%@ page import="org.apache.wiki.action.WikiContextFactory" %>
<%@ page import="org.apache.wiki.util.TextUtil" %>
<%--
        This is a special editor component for JSPWiki preview storage.
--%>
<% 
   WikiContext context = WikiContextFactory.findContext( pageContext ); 
   String usertext = (String)pageContext.getAttribute( EditorManager.ATTR_EDITEDTEXT, PageContext.REQUEST_SCOPE ); 
   if( usertext == null ) usertext = ""; 
 
   String action = "comment".equals(request.getParameter("action")) ? 
                   context.getURL(WikiContext.COMMENT,context.getPage().getName()) : 
                   context.getURL(WikiContext.EDIT,context.getPage().getName());
 %>
<form action="<%=action%>"
      method="post" accept-charset="<wiki:ContentEncoding/>" 
       class="wikiform"
          id="editform"
    onsubmit="return Wiki.submitOnce( this );"
     enctype="application/x-www-form-urlencoded">

  <p>
    <%-- Edit.jsp & Comment.jsp rely on these being found.  So be careful, if you make changes. --%>
    <input type="hidden" name="author" value="<c:out value='${author}' />" />
    <input type="hidden" name="link" value="<c:out value='${link}' />" />
    <input type="hidden" name="remember" value="<c:out value='${remember}' />" />
    <input type="hidden" name="changenote" value="<c:out value='${changenote}' />" />

    <input type="hidden" name="page" value="<wiki:Variable var='pagename' />" />
    <input type="hidden" name="action" value="save" />
    <input name="<%=SpamFilter.getHashFieldName(request)%>" type="hidden" value="<c:out value='${lastchange}' />" />
  </p>
  <div>
  <textarea style="display:none;" readonly="readonly"
              id="editorarea" name="<%=EditorManager.REQ_EDITEDTEXT%>" 
            rows="4" 
            cols="80"><%=TextUtil.replaceEntities(usertext)%></textarea>
  </div>
  <div id="submitbuttons">
    <input type="submit" name="edit" value="<fmt:message key='editor.preview.edit.submit'/>" 
      accesskey="e"
          title="<fmt:message key='editor.preview.edit.title'/>" />
    <input type="submit" name="ok" value="<fmt:message key='editor.preview.save.submit'/>" 
      accesskey="s"
          title="<fmt:message key='editor.preview.save.title'/>" />
    <input type="submit" name="cancel" value="<fmt:message key='editor.preview.cancel.submit'/>"  
      accesskey="q" 
          title="<fmt:message key='editor.preview.cancel.title'/>" />
  </div>
  
</form>