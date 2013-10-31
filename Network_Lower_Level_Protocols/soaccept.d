<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Network Lower Level Protocols:soaccept.d - DTraceBook</title>
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
wgPageName="Network_Lower_Level_Protocols:soaccept.d",
wgTitle="Network Lower Level Protocols:soaccept.d",
wgAction="view",
wgArticleId=126,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=505,
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
<body class="mediawiki ltr ns-0 ns-subject page-Network_Lower_Level_Protocols_soaccept_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Network Lower Level Protocols:soaccept.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="soaccept.d.2C_page_453">soaccept.d, page 453</span></h1>
<pre>
#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10hz

/* If AF_INET and AF_INET6 are &quot;Unknown&quot; to DTrace, replace with numbers: */
inline int af_inet = AF_INET;
inline int af_inet6 = AF_INET6;

dtrace:::BEGIN
{
	/* Add translations as desired from /usr/include/sys/errno.h */
	err[0]            = &quot;Success&quot;;
	err[EINTR]        = &quot;Interrupted syscall&quot;;
	err[EIO]          = &quot;I/O error&quot;;
	err[EAGAIN]       = &quot;Resource temp unavail&quot;;
	err[EACCES]       = &quot;Permission denied&quot;;
	err[ECONNABORTED] = &quot;Connection aborted&quot;;
	err[ECONNRESET]   = &quot;Connection reset&quot;;
	err[ETIMEDOUT]    = &quot;Timed out&quot;;
	err[EINPROGRESS]  = &quot;In progress&quot;;

	printf(&quot;%-6s&nbsp;%-16s&nbsp;%-3s&nbsp;%-16s&nbsp;%-5s&nbsp;%8s&nbsp;%s\n&quot;, &quot;PID&quot;, &quot;PROCESS&quot;, &quot;FAM&quot;,
	    &quot;ADDRESS&quot;, &quot;PORT&quot;, &quot;LAT(us)&quot;, &quot;RESULT&quot;);
}

syscall::accept*:entry
{
	self-&gt;sa = arg1;
	self-&gt;start = timestamp;
}

syscall::accept*:return
/self-&gt;sa/
{
	this-&gt;delta = (timestamp - self-&gt;start) / 1000;
	/* assume this is sockaddr_in until we can examine family */
	this-&gt;s = (struct sockaddr_in *)copyin(self-&gt;sa,
	    sizeof (struct sockaddr_in));
	this-&gt;f = this-&gt;s-&gt;sin_family;
}

syscall::accept*:return
/this-&gt;f == af_inet/
{
	this-&gt;port = ntohs(this-&gt;s-&gt;sin_port);
	this-&gt;address = inet_ntoa((ipaddr_t *)&amp;this-&gt;s-&gt;sin_addr);
	this-&gt;errstr = err[errno]&nbsp;!= NULL&nbsp;? err[errno]&nbsp;: lltostr(errno);
	printf(&quot;%-6d&nbsp;%-16s&nbsp;%-3d&nbsp;%-16s&nbsp;%-5d&nbsp;%8d&nbsp;%s\n&quot;, pid, execname,
	    this-&gt;f, this-&gt;address, this-&gt;port, this-&gt;delta, this-&gt;errstr);
}

syscall::accept*:return
/this-&gt;f == af_inet6/
{
	/* refetch for sockaddr_in6 */
	this-&gt;s6 = (struct sockaddr_in6 *)copyin(self-&gt;sa,
	    sizeof (struct sockaddr_in6));
	this-&gt;port = ntohs(this-&gt;s6-&gt;sin6_port);
	this-&gt;address = inet_ntoa6((in6_addr_t *)&amp;this-&gt;s6-&gt;sin6_addr);
	this-&gt;errstr = err[errno]&nbsp;!= NULL&nbsp;? err[errno]&nbsp;: lltostr(errno);
	printf(&quot;%-6d&nbsp;%-16s&nbsp;%-3d&nbsp;%-16s&nbsp;%-5d&nbsp;%8d&nbsp;%s\n&quot;, pid, execname,
	    this-&gt;f, this-&gt;address, this-&gt;port, this-&gt;delta, this-&gt;errstr);
}

syscall::accept*:return
/self-&gt;start/
{
	self-&gt;sa = 0; self-&gt;start = 0;
}
</pre>
<h1> <span class="mw-headline" id="Mac_OS_X">Mac OS X</span></h1>
<pre>
#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10hz

/* If AF_INET and AF_INET6 are &quot;Unknown&quot; to DTrace, replace with numbers: */
inline int af_inet = 2;		/* AF_INET defined in bsd/sys/socket.h */
inline int af_inet6 = 30;	/* AF_INET6 defined in bsd/sys/socket.h */

dtrace:::BEGIN
{
	/* Add translations as desired from /usr/include/sys/errno.h */
	err[0]            = &quot;Success&quot;;
	err[EINTR]        = &quot;Interrupted syscall&quot;;
	err[EIO]          = &quot;I/O error&quot;;
	err[EAGAIN]       = &quot;Resource temp unavail&quot;;
	err[EACCES]       = &quot;Permission denied&quot;;
	err[ECONNABORTED] = &quot;Connection aborted&quot;;
	err[ECONNRESET]   = &quot;Connection reset&quot;;
	err[ETIMEDOUT]    = &quot;Timed out&quot;;
	err[EINPROGRESS]  = &quot;In progress&quot;;

	printf(&quot;%-6s&nbsp;%-16s&nbsp;%-3s&nbsp;%-16s&nbsp;%-5s&nbsp;%8s&nbsp;%s\n&quot;, &quot;PID&quot;, &quot;PROCESS&quot;, &quot;FAM&quot;,
	    &quot;ADDRESS&quot;, &quot;PORT&quot;, &quot;LAT(us)&quot;, &quot;RESULT&quot;);
}

syscall::accept*:entry
{
	self-&gt;sa = arg1;
	self-&gt;start = timestamp;
}

syscall::accept*:return
/self-&gt;sa/
{
	this-&gt;delta = (timestamp - self-&gt;start) / 1000;
	/* assume this is sockaddr_in until we can examine family */
	this-&gt;s = (struct sockaddr_in *)copyin(self-&gt;sa,
	    sizeof (struct sockaddr_in));
	this-&gt;f = this-&gt;s-&gt;sin_family;
}

syscall::accept*:return
/this-&gt;f == af_inet/
{
	this-&gt;port = ntohs(this-&gt;s-&gt;sin_port);

	/*
	 * Convert an IPv4 address into a dotted quad decimal string.
	 * Until the inet_ntoa() functions are available from DTrace, this is
	 * converted using the existing strjoin() and lltostr().  It's done in
	 * two parts to avoid exhausting DTrace registers in one line of code.
	 */
	this-&gt;a = (uint8_t *)&amp;this-&gt;s-&gt;sin_addr;
	this-&gt;addr1 = strjoin(lltostr(this-&gt;a[0] + 0ULL), strjoin(&quot;.&quot;,
	    strjoin(lltostr(this-&gt;a[1] + 0ULL), &quot;.&quot;)));
	this-&gt;addr2 = strjoin(lltostr(this-&gt;a[2] + 0ULL), strjoin(&quot;.&quot;,
	    lltostr(this-&gt;a[3] + 0ULL)));
	this-&gt;address = strjoin(this-&gt;addr1, this-&gt;addr2);

	this-&gt;errstr = err[errno]&nbsp;!= NULL&nbsp;? err[errno]&nbsp;: lltostr(errno);
	printf(&quot;%-6d&nbsp;%-16s&nbsp;%-3d&nbsp;%-16s&nbsp;%-5d&nbsp;%8d&nbsp;%s\n&quot;, pid, execname,
	    this-&gt;f, this-&gt;address, this-&gt;port, this-&gt;delta, this-&gt;errstr);
}

syscall::accept*:return
/self-&gt;start/
{
	self-&gt;sa = 0; self-&gt;start = 0;
}
</pre>
<p>This version does IPv4 only.  IPv6 can be traced: you'll need to add a clause for /this-&gt;f == af_inet6/ and write some code to stringify the address (or just hexdump).  Also, the port number was "0" (when it should be something else) during testing; need to investigate more.
</p><p><br />
</p>
<!-- 
NewPP limit report
Preprocessor node count: 20/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:126-0!1!0!!en!2!edit=0 and timestamp 20131031021514 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Network_Lower_Level_Protocols:soaccept.d">http://www.dtracebook.com/index.php/Network_Lower_Level_Protocols:soaccept.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Network_Lower_Level_Protocols:soaccept.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Network_Lower_Level_Protocols:soaccept.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Network_Lower_Level_Protocols:soaccept.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Network_Lower_Level_Protocols:soaccept.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Network_Lower_Level_Protocols:soaccept.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
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
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Network_Lower_Level_Protocols:soaccept.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Network_Lower_Level_Protocols:soaccept.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Network_Lower_Level_Protocols:soaccept.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Network_Lower_Level_Protocols:soaccept.d&amp;oldid=505" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 30 September 2011, at 22:21.</li>
		<li id="viewcount">This page has been accessed 2,834 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.267 secs. --></body></html>
