<%@ include file="../../adminDefaults.jsp" %>

<%

/* $Id$ */

/**
* Licensed to the Apache Software Foundation (ASF) under one or more
* contributor license agreements. See the NOTICE file distributed with
* this work for additional information regarding copyright ownership.
* The ASF licenses this file to You under the Apache License, Version 2.0
* (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
* 
* http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
%>

<%
	// This file is included by every place that the specification information for the file system connector
	// needs to be viewed.  When it is called, the DocumentSpecification object is placed in the thread context
	// under the name "DocumentSpecification".  The IRepositoryConnection object is also in the thread context,
	// under the name "RepositoryConnection".

	// The coder can presume that this jsp is executed within a body section.

	DocumentSpecification ds = (DocumentSpecification)threadContext.get("DocumentSpecification");
	IRepositoryConnection repositoryConnection = (IRepositoryConnection)threadContext.get("RepositoryConnection");
%>

<%
	if (ds == null)
		out.println("Hey!  No document specification came in!!!");
	if (repositoryConnection == null)
		out.println("No repository connection!!!");
%>
	<table class="displaytable">
<%
	int i = 0;
	boolean seenAny = false;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("startpoint"))
		{
			if (seenAny == false)
			{
				seenAny = true;
%>
				<!-- tr><td>Include root</td><td>Rules</td></tr -->
<%
			}
%>
			<tr><td class="description"><%=org.apache.lcf.ui.util.Encoder.bodyEscape(sn.getAttributeValue("path"))+":"%></td>
			<td class="value">
<%
			int j = 0;
			while (j < sn.getChildCount())
			{
				SpecificationNode excludeNode = sn.getChild(j++);
%>
				<%=(excludeNode.getType().equals("include"))?"Include ":""%>
				<%=(excludeNode.getType().equals("exclude"))?"Exclude ":""%>
				<%=(excludeNode.getAttributeValue("type").equals("file"))?"file ":""%>
				<%=(excludeNode.getAttributeValue("type").equals("directory"))?"directory ":""%>
				<%=org.apache.lcf.ui.util.Encoder.bodyEscape(excludeNode.getAttributeValue("match"))%><br/>
<%
			}
%>
			</td></tr>
<%
		}
	}
	if (seenAny == false)
	{
%>
		<tr><td class="message">No documents specified</td></tr>
<%
	}
%>
	</table>

