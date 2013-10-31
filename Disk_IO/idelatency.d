<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Disk IO:idelatency.d - DTraceBook</title>
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
wgPageName="Disk_IO:idelatency.d",
wgTitle="Disk IO:idelatency.d",
wgAction="view",
wgArticleId=72,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=461,
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
<body class="mediawiki ltr ns-0 ns-subject page-Disk_IO_idelatency_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Disk IO:idelatency.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="idelatency.d.2C_page_252">idelatency.d, page 252</span></h1>
<pre>
#!/usr/sbin/dtrace -s

#pragma D option quiet

string dcmd[uchar_t];

dtrace:::BEGIN
{
	/*
	 * These command descriptions are from the DCMD_* definitions
	 * in /usr/include/sys/dktp/dadkio.h:
	 */
	dcmd[1] = &quot;Read Sectors/Blocks&quot;;
	dcmd[2] = &quot;Write Sectors/Blocks&quot;;
	dcmd[3] = &quot;Format Tracks&quot;;
	dcmd[4] = &quot;Format entire drive&quot;;
	dcmd[5] = &quot;Recalibrate&quot;;
	dcmd[6] = &quot;Seek to Cylinder&quot;;
	dcmd[7] = &quot;Read Verify sectors on disk&quot;;
	dcmd[8] = &quot;Read manufacturers defect list&quot;;
	dcmd[9] = &quot;Lock door&quot;;
	dcmd[10] = &quot;Unlock door&quot;;
	dcmd[11] = &quot;Start motor&quot;;
	dcmd[12] = &quot;Stop motor&quot;;
	dcmd[13] = &quot;Eject medium&quot;;
	dcmd[14] = &quot;Update geometry&quot;;
	dcmd[15] = &quot;Get removable disk status&quot;;
	dcmd[16] = &quot;cdrom pause&quot;;
	dcmd[17] = &quot;cdrom resume&quot;;
	dcmd[18] = &quot;cdrom play by track and index&quot;;
	dcmd[19] = &quot;cdrom play msf&quot;;
	dcmd[20] = &quot;cdrom sub channel&quot;;
	dcmd[21] = &quot;cdrom read mode 1&quot;;
	dcmd[22] = &quot;cdrom read table of contents header&quot;;
	dcmd[23] = &quot;cdrom read table of contents entry&quot;;
	dcmd[24] = &quot;cdrom read offset&quot;;
	dcmd[25] = &quot;cdrom mode 2&quot;;
	dcmd[26] = &quot;cdrom volume control&quot;;
	dcmd[27] = &quot;flush write cache to physical medium&quot;;

	/* from CPS_* definitions in /usr/include/sys/dktp/cmpkt.h */
	reason[0] = &quot;success&quot;;
	reason[1] = &quot;failure&quot;;
	reason[2] = &quot;fail+err&quot;;
	reason[3] = &quot;aborted&quot;;

	printf(&quot;Tracing... Hit Ctrl-C to end.\n&quot;);
}

/* IDE command start */
fbt::dadk_pktprep:return
{
	start[arg1] = timestamp;
}

/* IDE command completion */
fbt::dadk_pktcb:entry
/start[arg0]/
{
	this-&gt;pktp = args[0];

	this-&gt;delta = (timestamp - start[arg0]) / 1000;
	this-&gt;cmd = *((uchar_t *)this-&gt;pktp-&gt;cp_cdbp);
	this-&gt;cmd_text = dcmd[this-&gt;cmd]&nbsp;!= NULL&nbsp;?
	    dcmd[this-&gt;cmd]&nbsp;: lltostr(this-&gt;cmd);
	this-&gt;reason = this-&gt;pktp-&gt;cp_reason;
	this-&gt;reason_text = reason[this-&gt;reason]&nbsp;!= NULL&nbsp;?
	    reason[this-&gt;reason]&nbsp;: lltostr(this-&gt;reason);

	@num[this-&gt;cmd_text, this-&gt;reason_text] = count();
	@average[this-&gt;cmd_text, this-&gt;reason_text] = avg(this-&gt;delta);
	@total[this-&gt;cmd_text, this-&gt;reason_text] = sum(this-&gt;delta);

	start[arg0] = 0;
}

dtrace:::END
{
	normalize(@total, 1000);
	printf(&quot;\n &nbsp;%-36s&nbsp;%8s&nbsp;%8s&nbsp;%10s&nbsp;%10s\n&quot;, &quot;IDE COMMAND&quot;,
	    &quot;REASON&quot;, &quot;COUNT&quot;, &quot;AVG(us)&quot;, &quot;TOTAL(ms)&quot;);
	printa(&quot; &nbsp;%-36s&nbsp;%8s&nbsp;%@8d&nbsp;%@10d&nbsp;%@10d\n&quot;, @num, @average, @total);
}
</pre>

<!-- 
NewPP limit report
Preprocessor node count: 7/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:72-0!1!0!!en!2!edit=0 and timestamp 20131030170222 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Disk_IO:idelatency.d">http://www.dtracebook.com/index.php/Disk_IO:idelatency.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Disk_IO:idelatency.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Disk_IO:idelatency.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Disk_IO:idelatency.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Disk_IO:idelatency.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Disk_IO:idelatency.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
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
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Disk_IO:idelatency.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Disk_IO:idelatency.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Disk_IO:idelatency.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Disk_IO:idelatency.d&amp;oldid=461" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 20 April 2011, at 19:38.</li>
		<li id="viewcount">This page has been accessed 1,149 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.278 secs. --></body></html>
