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
    <tr>
<%
	int i = 0;
	boolean seenAny = false;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("SearchPath"))
		{
			if (seenAny == false)
			{
%>
	<td class="description"><nobr>Paths:</nobr></td>
	<td class="value">
<%
				seenAny = true;
			}
%>
		<%=org.apache.lcf.ui.util.Encoder.bodyEscape(sn.getAttributeValue("path"))%><br/>
<%
		}
	}

	if (seenAny)
	{
%>
	</td>
    </tr>
<%
	}
	else
	{
%>
	    <tr><td class="message" colspan="2">No paths specified</td></tr>
<%
	}
%>
    <tr><td class="separator" colspan="2"><hr/></td></tr>
    <tr>
	<td class="description"><nobr>Data Type:</nobr>
	</td>
	<td class="value">
		<nobr>
<%
	i = 0;
	String mode = "DOCUMENTS_AND_RECORDS";
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("SearchOn"))
			mode = sn.getAttributeValue("value");
	}
	String displayMode;
	if (mode.equals("DOCUMENTS"))
		displayMode = "Documents only";
	else if (mode.equals("RECORDS"))
		displayMode = "Records only";
	else
		displayMode = "Documents and Records";
%>
			<%=displayMode%>
		</nobr>
	</td>
    </tr>
    <tr><td class="separator" colspan="2"><hr/></td></tr>
    <tr>
	<td class="description"><nobr>Categories:</nobr>
	</td>
	<td class="value">
<%
	int count = 0;
	i = 0;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("SearchCategory"))
			count++;
	}
	String[] sortArray = new String[count];
	count = 0;
	i = 0;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("SearchCategory"))
			sortArray[count++] = sn.getAttributeValue("category");
	}
	java.util.Arrays.sort(sortArray);
	i = 0;
	while (i < sortArray.length)
	{
		String category = sortArray[i++];
%>
		<nobr><%=org.apache.lcf.ui.util.Encoder.bodyEscape(category)%></nobr><br/>
<%
	}
%>
	</td>
    </tr>
    <tr><td class="separator" colspan="2"><hr/></td></tr>
    <tr>
	<td class="description"><nobr>Mime types:</nobr>
	</td>
	<td class="value">
<%
	count = 0;
	i = 0;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("MIMEType"))
			count++;
	}
	sortArray = new String[count];
	count = 0;
	i = 0;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("MIMEType"))
			sortArray[count++] = sn.getAttributeValue("type");
	}
	java.util.Arrays.sort(sortArray);
	i = 0;
	while (i < sortArray.length)
	{
		String mimeType = sortArray[i++];
%>
		<nobr><%=org.apache.lcf.ui.util.Encoder.bodyEscape(mimeType)%></nobr><br/>
<%
	}
%>
	</td>
    </tr>

    <tr><td class="separator" colspan="2"><hr/></td></tr>

<%
	// Find whether security is on or off
	i = 0;
	boolean securityOn = true;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("security"))
		{
			String securityValue = sn.getAttributeValue("value");
			if (securityValue.equals("off"))
				securityOn = false;
			else if (securityValue.equals("on"))
				securityOn = true;
		}
	}
%>

    <tr>
	<td class="description">Security:</td>
	<td class="value"><%=(securityOn)?"Enabled":"Disabled"%></td>
    </tr>


    <tr><td class="separator" colspan="2"><hr/></td></tr>
<%
	// Go through looking for access tokens
	seenAny = false;
	i = 0;
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("access"))
		{
			if (seenAny == false)
			{
%>
    <tr><td class="description">Access tokens:</td>
	<td class="value">

<%
				seenAny = true;
			}
			String token = sn.getAttributeValue("token");
%>
				<%=org.apache.lcf.ui.util.Encoder.bodyEscape(token)%><br/>
<%		}
	}

	if (seenAny)
	{
%>
	</td>
    </tr>
<%
	}
	else
	{
%>
    <tr><td class="message" colspan="2">No access tokens specified</td></tr>
<%
	}
%>
    <tr><td class="separator" colspan="2"><hr/></td></tr>
    <tr>
<%
	count = 0;
	i = 0;
	boolean allMetadata = false;

	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("ReturnedMetadata"))
			count++;
		else if (sn.getType().equals("AllMetadata"))
		{
			String value = sn.getAttributeValue("value");
			if (value != null && value.equals("true"))
			{
				allMetadata = true;
			}
		}
	}

	if (allMetadata)
	{
%> 
	<td class="description"><nobr>Metadata properties to ingest:</nobr>
	</td>
	<td class="value"><nobr><b>All metadata</b></nobr></td>
<%
	}
	else if (count > 0)
	{
%>
	<td class="description"><nobr>Metadata properties to ingest:</nobr>
	</td>
	<td class="value">
<%
		sortArray = new String[count];
		i = 0;
		count = 0;
        while (i < ds.getChildCount())
		{
			SpecificationNode sn = ds.getChild(i++);
			if (sn.getType().equals("ReturnedMetadata"))
			{
				String category = sn.getAttributeValue("category");
				String property = sn.getAttributeValue("property");
				String descriptor;
				if (category == null || category.length() == 0)
					descriptor = property;
				else
					descriptor = category + "." + property;

				sortArray[count++] = descriptor;
			}
		}

		java.util.Arrays.sort(sortArray);	
        i = 0;
        while (i < sortArray.length)
        {
                String descriptor = sortArray[i++];
%>
		<nobr><%=org.apache.lcf.ui.util.Encoder.bodyEscape(descriptor)%></nobr><br/>
<%
        }
%>
	</td>
<%
	}
	else
	{
%>
	<td class="message" colspan="2"><nobr>No metadata properties to ingest</nobr></td> 
<%
	} 
%>
    </tr>
    <tr><td class="separator" colspan="2"><hr/></td></tr>
<%
	// Find the path-name metadata attribute name i = 0;
	String pathNameAttribute = "";
	i = 0;
	while (i < ds.getChildCount())
	{
			 SpecificationNode sn = ds.getChild(i++);
			 if (sn.getType().equals("pathnameattribute"))
			 {
				 pathNameAttribute = sn.getAttributeValue("value");
			 }
	}
%>
    <tr>
<%
	if (pathNameAttribute.length() > 0)
	{
%>
	<td class="description"><nobr>Path-name metadata attribute:</nobr></td>
	<td class="value"><nobr><%=org.apache.lcf.ui.util.Encoder.bodyEscape(pathNameAttribute)%></nobr></td>
<%
	}
	else
	{
%>
	<td class="message" colspan="2"><nobr>No path-name metadata attribute specified</nobr></td>
<%
	}
%>
    </tr>

    <tr><td class="separator" colspan="2"><hr/></td></tr>

    <tr>

<%
	// Find the path-value mapping data
	i = 0;
	org.apache.lcf.crawler.connectors.meridio.MatchMap matchMap = new org.apache.lcf.crawler.connectors.meridio.MatchMap();
	while (i < ds.getChildCount())
	{
		SpecificationNode sn = ds.getChild(i++);
		if (sn.getType().equals("pathmap"))
		{
			String pathMatch = sn.getAttributeValue("match");
			String pathReplace = sn.getAttributeValue("replace");
			matchMap.appendMatchPair(pathMatch,pathReplace);
		}
	}
	if (matchMap.getMatchCount() > 0)
	{
%>
	<td class="description"><nobr>Path-value mapping:</nobr></td>
	<td class="value">
	    <table class="displaytable">
<%
	    i = 0;
	    while (i < matchMap.getMatchCount())
	    {
		String matchString = matchMap.getMatchString(i);
		String replaceString = matchMap.getReplaceString(i);
%>
	    <tr><td class="value"><%=org.apache.lcf.ui.util.Encoder.bodyEscape(matchString)%></td><td class="value">--></td><td class="value"><%=org.apache.lcf.ui.util.Encoder.bodyEscape(replaceString)%></td></tr>
<%
		i++;
	    }
%>
	    </table>
	</td>
<%
	}
	else
	{
%>
	<td class="message" colspan="2"><nobr>No mappings specified</nobr></td>
<%
	}
%>
    </tr>
</table>
