<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Application Level Protocols:weblatency.d - DTraceBook</title>
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
wgPageName="Application_Level_Protocols:weblatency.d",
wgTitle="Application Level Protocols:weblatency.d",
wgAction="view",
wgArticleId=207,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=265,
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
<body class="mediawiki ltr ns-0 ns-subject page-Application_Level_Protocols_weblatency_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Application Level Protocols:weblatency.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="weblatency.d">weblatency.d</span></h1>
<pre>
#!/usr/sbin/dtrace -s

#pragma D option quiet

/* browser's execname */
inline string BROWSER = &quot;mozilla-bin&quot;;

/* maximum expected hostname length + &quot;GET http://&quot; */
inline int MAX_REQ = 64;

dtrace:::BEGIN
{
	printf(&quot;Tracing... Hit Ctrl-C to end.\n&quot;);
}

/*
 * Trace brower request
 *
 * This is achieved by matching writes for the browser's execname that
 * start with &quot;GET&quot;, and then timing from the return of the write to
 * the return of the next read in the same thread. Various stateful flags
 * are used: self-&gt;fd, self-&gt;read.
 *
 * For performance reasons, I'd like to only process writes that follow a
 * connect(), however this approach fails to process keepalives.
 */
syscall::write:entry
/execname == BROWSER/
{
	self-&gt;buf = arg1;
	self-&gt;fd = arg0 + 1;
	self-&gt;nam = &quot;&quot;;
}

syscall::write:return
/self-&gt;fd/
{
	this-&gt;str = (char *)copyin(self-&gt;buf, MAX_REQ);
	this-&gt;str[4] = '\0';
	self-&gt;fd = stringof(this-&gt;str) == &quot;GET &quot;&nbsp;? self-&gt;fd&nbsp;: 0;
}

syscall::write:return
/self-&gt;fd/
{
	/* fetch browser request */
	this-&gt;str = (char *)copyin(self-&gt;buf, MAX_REQ);
	this-&gt;str[MAX_REQ] = '\0';

	/*
	 * This unrolled loop strips down a URL to it's hostname.
	 * We ought to use strtok(), but it's not available on Sol 10 3/05,
	 * so instead I used dirname(). It's not pretty - it's done so that
	 * this works on all Sol 10 versions.
	 */
	self-&gt;req = stringof(this-&gt;str);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;req = dirname(self-&gt;req);
	self-&gt;nam = strlen(self-&gt;req) &gt; 15&nbsp;? self-&gt;req&nbsp;: self-&gt;nam;
	self-&gt;nam = basename(self-&gt;nam);

	/* start the timer */
	start[pid, self-&gt;fd - 1] = timestamp;
	host[pid, self-&gt;fd - 1] = self-&gt;nam;
	self-&gt;buf = 0;
	self-&gt;fd  = 0;
	self-&gt;req = 0;
	self-&gt;nam = 0;
}

/* this one wasn't a GET */
syscall::write:return
/self-&gt;buf/
{
	self-&gt;buf = 0;
	self-&gt;fd  = 0;
}

syscall::read:entry
/execname == BROWSER &amp;&amp; start[pid, arg0]/
{
	self-&gt;fd = arg0 + 1;
}

/*
 * Record host details
 */
syscall::read:return
/self-&gt;fd/
{
	/* fetch details */
	self-&gt;host = stringof(host[pid, self-&gt;fd - 1]);
	this-&gt;start = start[pid, self-&gt;fd - 1];

	/* save details */
	@Avg[self-&gt;host] = avg((timestamp - this-&gt;start)/1000000);
	@Max[self-&gt;host] = max((timestamp - this-&gt;start)/1000000);
	@Num[self-&gt;host] = count();

	/* clear vars */
	start[pid, self-&gt;fd - 1] = 0;
	host[pid, self-&gt;fd - 1] = 0;
	self-&gt;host = 0;
	self-&gt;fd = 0;
}

/*
 * Output report
 */
dtrace:::END
{
	printf(&quot;%-32s&nbsp;%11s\n&quot;, &quot;HOST&quot;, &quot;NUM&quot;);
	printa(&quot;%-32s&nbsp;%@11d\n&quot;, @Num);

	printf(&quot;\n%-32s&nbsp;%11s\n&quot;, &quot;HOST&quot;, &quot;AVGTIME(ms)&quot;);
	printa(&quot;%-32s&nbsp;%@11d\n&quot;, @Avg);

	printf(&quot;\n%-32s&nbsp;%11s\n&quot;, &quot;HOST&quot;, &quot;MAXTIME(ms)&quot;);
	printa(&quot;%-32s&nbsp;%@11d\n&quot;, @Max);
}
</pre>

<!-- 
NewPP limit report
Preprocessor node count: 7/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:207-0!1!0!!en!2!edit=0 and timestamp 20131031143503 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Application_Level_Protocols:weblatency.d">http://www.dtracebook.com/index.php/Application_Level_Protocols:weblatency.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Application_Level_Protocols:weblatency.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Application_Level_Protocols:weblatency.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Application_Level_Protocols:weblatency.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Application_Level_Protocols:weblatency.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Application_Level_Protocols:weblatency.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
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
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Application_Level_Protocols:weblatency.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Application_Level_Protocols:weblatency.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Application_Level_Protocols:weblatency.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Application_Level_Protocols:weblatency.d&amp;oldid=265" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 6 March 2011, at 23:04.</li>
		<li id="viewcount">This page has been accessed 575 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.296 secs. --></body></html>
