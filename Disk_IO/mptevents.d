<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Disk IO:mptevents.d - DTraceBook</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="generator" content="MediaWiki 1.16.2" />
<link rel="shortcut icon" href="/favicon.ico" />
<link rel="search" type="application/opensearchdescription+xml" href="/opensearch_desc.php" title="DTraceBook (en)" />
<link rel="alternate" type="application/atom+xml" title="DTraceBook Atom feed" href="/index.php?title=Special:RecentChanges&amp;feed=atom" />
<link rel="stylesheet" href="/skins/common/shared.css?270" media="screen" />
<link rel="stylesheet" href="/skins/common/commonPrint.css?270" media="print" />
<link rel="stylesheet" href="/skins/monobook/main.css?270" media="screen" />
<!--[if lt IE 5.5000]><link rel="stylesheet" href="/skins/monobook/IE50Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 5.5000]><link rel="stylesheet" href="/skins/monobook/IE55Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 6]><link rel="stylesheet" href="/skins/monobook/IE60Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" href="/skins/monobook/IE70Fixes.css?270" media="screen" /><![endif]-->
<link rel="stylesheet" href="/index.php?title=MediaWiki:Common.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" />
<link rel="stylesheet" href="/index.php?title=MediaWiki:Print.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" media="print" />
<link rel="stylesheet" href="/index.php?title=MediaWiki:Monobook.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" />
<link rel="stylesheet" href="/index.php?title=-&amp;action=raw&amp;maxage=18000&amp;gen=css" />
<script>
var skin="monobook",
stylepath="/skins",
wgUrlProtocols="http\\:\\/\\/|https\\:\\/\\/|ftp\\:\\/\\/|irc\\:\\/\\/|gopher\\:\\/\\/|telnet\\:\\/\\/|nntp\\:\\/\\/|worldwind\\:\\/\\/|mailto\\:|news\\:|svn\\:\\/\\/",
wgArticlePath="/index.php/$1",
wgScriptPath="",
wgScriptExtension=".php",
wgScript="/index.php",
wgVariantArticlePath=false,
wgActionPaths={},
wgServer="http://www.dtracebook.com",
wgCanonicalNamespace="",
wgCanonicalSpecialPageName=false,
wgNamespaceNumber=0,
wgPageName="Disk_IO:mptevents.d",
wgTitle="Disk IO:mptevents.d",
wgAction="view",
wgArticleId=76,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=465,
wgVersion="1.16.2",
wgEnableAPI=true,
wgEnableWriteAPI=true,
wgSeparatorTransformTable=["", ""],
wgDigitTransformTable=["", ""],
wgMainPageTitle="Main Page",
wgFormattedNamespaces={"-2": "Media", "-1": "Special", "0": "", "1": "Talk", "2": "User", "3": "User talk", "4": "DTraceBook", "5": "DTraceBook talk", "6": "File", "7": "File talk", "8": "MediaWiki", "9": "MediaWiki talk", "10": "Template", "11": "Template talk", "12": "Help", "13": "Help talk", "14": "Category", "15": "Category talk"},
wgNamespaceIds={"media": -2, "special": -1, "": 0, "talk": 1, "user": 2, "user_talk": 3, "dtracebook": 4, "dtracebook_talk": 5, "file": 6, "file_talk": 7, "mediawiki": 8, "mediawiki_talk": 9, "template": 10, "template_talk": 11, "help": 12, "help_talk": 13, "category": 14, "category_talk": 15, "image": 6, "image_talk": 7},
wgSiteName="DTraceBook",
wgCategories=[],
wgRestrictionEdit=[],
wgRestrictionMove=[];
</script><script src="/skins/common/wikibits.js?270"></script>
<script src="/skins/common/ajax.js?270"></script>
<script src="/index.php?title=-&amp;action=raw&amp;gen=js&amp;useskin=monobook&amp;270"></script>

</head>
<body class="mediawiki ltr ns-0 ns-subject page-Disk_IO_mptevents_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Disk IO:mptevents.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="mptevents.d.2C_page_265">mptevents.d, page 265</span></h1>
<pre>
#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
	/*
	 * These MPI_EVENT_* definitions are from uts/common/sys/mpt/mpi_ioc.h
	 */

	mpi_event[0x00000000] = &quot;NONE&quot;;
	mpi_event[0x00000001] = &quot;LOG_DATA&quot;;
	mpi_event[0x00000002] = &quot;STATE_CHANGE&quot;;
	mpi_event[0x00000003] = &quot;UNIT_ATTENTION&quot;;
	mpi_event[0x00000004] = &quot;IOC_BUS_RESET&quot;;
	mpi_event[0x00000005] = &quot;EXT_BUS_RESET&quot;;
	mpi_event[0x00000006] = &quot;RESCAN&quot;;
	mpi_event[0x00000007] = &quot;LINK_STATUS_CHANGE&quot;;
	mpi_event[0x00000008] = &quot;LOOP_STATE_CHANGE&quot;;
	mpi_event[0x00000009] = &quot;LOGOUT&quot;;
	mpi_event[0x0000000A] = &quot;EVENT_CHANGE&quot;;
	mpi_event[0x0000000B] = &quot;INTEGRATED_RAID&quot;;
	mpi_event[0x0000000C] = &quot;SCSI_DEVICE_STATUS_CHANGE&quot;;
	mpi_event[0x0000000D] = &quot;ON_BUS_TIMER_EXPIRED&quot;;
	mpi_event[0x0000000E] = &quot;QUEUE_FULL&quot;;
	mpi_event[0x0000000F] = &quot;SAS_DEVICE_STATUS_CHANGE&quot;;
	mpi_event[0x00000010] = &quot;SAS_SES&quot;;
	mpi_event[0x00000011] = &quot;PERSISTENT_TABLE_FULL&quot;;
	mpi_event[0x00000012] = &quot;SAS_PHY_LINK_STATUS&quot;;
	mpi_event[0x00000013] = &quot;SAS_DISCOVERY_ERROR&quot;;
	mpi_event[0x00000014] = &quot;IR_RESYNC_UPDATE&quot;;
	mpi_event[0x00000015] = &quot;IR2&quot;;
	mpi_event[0x00000016] = &quot;SAS_DISCOVERY&quot;;
	mpi_event[0x00000017] = &quot;SAS_BROADCAST_PRIMITIVE&quot;;
	mpi_event[0x00000018] = &quot;SAS_INIT_DEVICE_STATUS_CHANGE&quot;;
	mpi_event[0x00000019] = &quot;SAS_INIT_TABLE_OVERFLOW&quot;;
	mpi_event[0x0000001A] = &quot;SAS_SMP_ERROR&quot;;
	mpi_event[0x0000001B] = &quot;SAS_EXPANDER_STATUS_CHANGE&quot;;
	mpi_event[0x00000021] = &quot;LOG_ENTRY_ADDED&quot;;

	sas_discovery[0x00000000] = &quot;SAS_DSCVRY_COMPLETE&quot;;
	sas_discovery[0x00000001] = &quot;SAS_DSCVRY_IN_PROGRESS&quot;;

	dev_stat[0x03] = &quot;ADDED&quot;;
	dev_stat[0x04] = &quot;NOT_RESPONDING&quot;;
	dev_stat[0x05] = &quot;SMART_DATA&quot;;
	dev_stat[0x06] = &quot;NO_PERSIST_ADDED&quot;;
	dev_stat[0x07] = &quot;UNSUPPORTED&quot;;
	dev_stat[0x08] = &quot;INTERNAL_DEVICE_RESET&quot;;
	dev_stat[0x09] = &quot;TASK_ABORT_INTERNAL&quot;;
	dev_stat[0x0A] = &quot;ABORT_TASK_SET_INTERNAL&quot;;
	dev_stat[0x0B] = &quot;CLEAR_TASK_SET_INTERNAL&quot;;
	dev_stat[0x0C] = &quot;QUERY_TASK_INTERNAL&quot;;
	dev_stat[0x0D] = &quot;ASYNC_NOTIFICATION&quot;;
	dev_stat[0x0E] = &quot;CMPL_INTERNAL_DEV_RESET&quot;;
	dev_stat[0x0F] = &quot;CMPL_TASK_ABORT_INTERNAL&quot;;

	printf(&quot;%-20s &nbsp;%-6s&nbsp;%-3s   &nbsp;%s\n&quot;, &quot;TIME&quot;, &quot;MODULE&quot;, &quot;CPU&quot;, &quot;EVENT&quot;);
}
sdt:mpt::handle-event-sync
{
	this-&gt;mpt = (mpt_t *)arg0;
	this-&gt;mpt_name = strjoin(&quot;mpt&quot;, lltostr(this-&gt;mpt-&gt;m_instance));
	this-&gt;event_text = mpi_event[arg1]&nbsp;!= NULL&nbsp;?
	    mpi_event[arg1]&nbsp;: lltostr(arg1);
	printf(&quot;%-20Y &nbsp;%-6s&nbsp;%-3d -&gt;&nbsp;%s\n&quot;, walltimestamp, this-&gt;mpt_name, cpu,
	    this-&gt;event_text);
}
sdt:mpt::handle-event-sync
/arg1 == 0x00000016/
{
	self-&gt;mpt = (mpt_t *)arg0;
	self-&gt;discovery = 1;
}
fbt::mpt_handle_event_sync:return
/self-&gt;discovery/
{
	/* remove the PHY_BITS from the discovery status */
	this-&gt;cond = self-&gt;mpt-&gt;m_discovery &amp; 0x0000FFFF;
	this-&gt;cond_text = sas_discovery[this-&gt;cond]&nbsp;!= NULL&nbsp;?
	    sas_discovery[this-&gt;cond]&nbsp;: lltostr(this-&gt;cond);
	printf(&quot;%-20Y &nbsp;%-6s&nbsp;%-3d    -&gt; discovery status:&nbsp;%s\n&quot;, walltimestamp,
	    this-&gt;mpt_name, cpu, this-&gt;cond_text);
	self-&gt;mpt = 0;
	self-&gt;discovery = 0;
}
sdt:mpt::device-status-change
{
	this-&gt;mpt = (mpt_t *)arg0;
	this-&gt;mpt_name = strjoin(&quot;mpt&quot;, lltostr(this-&gt;mpt-&gt;m_instance));
	this-&gt;reason = arg2;
	this-&gt;reason_text = dev_stat[this-&gt;reason]&nbsp;!= NULL&nbsp;?
	    dev_stat[this-&gt;reason]&nbsp;: lltostr(this-&gt;reason);
	printf(&quot;%-20Y &nbsp;%-6s&nbsp;%-3d    -&gt; device change:&nbsp;%s\n&quot;, walltimestamp,
	    this-&gt;mpt_name, cpu, this-&gt;reason_text);
	printf(&quot;%-20Y &nbsp;%-6s&nbsp;%-3d       wwn=%x\n&quot;, walltimestamp,
	    this-&gt;mpt_name, cpu, arg3);
}
sdt:mpt::event-sas-phy-link-status
{
	this-&gt;mpt = (mpt_t *)arg0;
	this-&gt;mpt_name = strjoin(&quot;mpt&quot;, lltostr(this-&gt;mpt-&gt;m_instance));
	this-&gt;phynum = arg1;
	printf(&quot;%-20Y &nbsp;%-6s&nbsp;%-3d    -&gt; phy link status, phy=%d\n&quot;,
	    walltimestamp, this-&gt;mpt_name, cpu, this-&gt;phynum);
}
</pre>

<!-- 
NewPP limit report
Preprocessor node count: 7/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:76-0!1!0!!en!2!edit=0 and timestamp 20131031133726 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Disk_IO:mptevents.d">http://www.dtracebook.com/index.php/Disk_IO:mptevents.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Disk_IO:mptevents.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Disk_IO:mptevents.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Disk_IO:mptevents.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Disk_IO:mptevents.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Disk_IO:mptevents.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-logo">
		<a style="background-image: url(../images/41AKe8-hswL._SL160_.jpg);" href="/index.php/Main_Page" title="Visit the main page"></a>
	</div>
	<script type="text/javascript"> if (window.isMSIE55) fixalpha(); </script>
	<div class='generated-sidebar portlet' id='p-navigation'>
		<h5>Navigation</h5>
		<div class='pBody'>
			<ul>
				<li id="n-mainpage-description"><a href="/index.php/Main_Page" title="Visit the main page [z]" accesskey="z">Main page</a></li>
				<li id="n-recentchanges"><a href="/index.php/Special:RecentChanges" title="The list of recent changes in the wiki [r]" accesskey="r">Recent changes</a></li>
				<li id="n-randompage"><a href="/index.php/Special:Random" title="Load a random page [x]" accesskey="x">Random page</a></li>
				<li id="n-help"><a href="/index.php/Help:Contents" title="The place to find out">Help</a></li>
			</ul>
		</div>
	</div>
	<div class='generated-sidebar portlet' id='p-links'>
		<h5>links</h5>
		<div class='pBody'>
			<ul>
				<li id="n-dtrace.org"><a href="http://dtrace.org">dtrace.org</a></li>
				<li id="n-DTraceToolkit"><a href="http://www.brendangregg.com/dtrace.html#DTraceToolkit">DTraceToolkit</a></li>
				<li id="n-solarisinternals.com"><a href="http://www.solarisinternals.com">solarisinternals.com</a></li>
			</ul>
		</div>
	</div>
	<div id="p-search" class="portlet">
		<h5><label for="searchInput">Search</label></h5>
		<div id="searchBody" class="pBody">
			<form action="/index.php" id="searchform">
				<input type='hidden' name="title" value="Special:Search"/>
				<input id="searchInput" title="Search DTraceBook" accesskey="f" type="search" name="search" />
				<input type='submit' name="go" class="searchButton" id="searchGoButton"	value="Go" title="Go to a page with this exact name if exists" />&nbsp;
				<input type='submit' name="fulltext" class="searchButton" id="mw-searchButton" value="Search" title="Search the pages for this text" />
			</form>
		</div>
	</div>
	<div class="portlet" id="p-tb">
		<h5>Toolbox</h5>
		<div class="pBody">
			<ul>
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Disk_IO:mptevents.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Disk_IO:mptevents.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Disk_IO:mptevents.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Disk_IO:mptevents.d&amp;oldid=465" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 20 April 2011, at 19:41.</li>
		<li id="viewcount">This page has been accessed 1,425 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.267 secs. --></body></html>
