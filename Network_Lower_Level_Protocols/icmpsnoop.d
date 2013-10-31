<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Network Lower Level Protocols:icmpsnoop.d - DTraceBook</title>
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
wgPageName="Network_Lower_Level_Protocols:icmpsnoop.d",
wgTitle="Network Lower Level Protocols:icmpsnoop.d",
wgAction="view",
wgArticleId=116,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=498,
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
<body class="mediawiki ltr ns-0 ns-subject page-Network_Lower_Level_Protocols_icmpsnoop_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Network Lower Level Protocols:icmpsnoop.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="icmpsnoop.d.2C_page_522">icmpsnoop.d, page 522</span></h1>
<pre>
#!/usr/sbin/dtrace -Cs

#pragma D option quiet
#pragma D option switchrate=10hz

#define	IPPROTO_ICMP            1
#define	IPH_HDR_LENGTH(iph)     (((struct ip *)(iph))-&gt;ip_hl &lt;&lt; 2)

dtrace:::BEGIN
{
	/* See RFC792 and ip_icmp.h */
	icmptype[0] = &quot;ECHOREPLY&quot;;
	icmptype[3] = &quot;UNREACH&quot;;
	icmpcode[3, 0] = &quot;NET&quot;;
	icmpcode[3, 1] = &quot;HOST&quot;;
	icmpcode[3, 2] = &quot;PROTOCOL&quot;;
	icmpcode[3, 3] = &quot;PORT&quot;;
	icmpcode[3, 4] = &quot;NEEDFRAG&quot;;
	icmpcode[3, 5] = &quot;SRCFAIL&quot;;
	icmpcode[3, 6] = &quot;NET_UNKNOWN&quot;;
	icmpcode[3, 7] = &quot;HOST_UNKNOWN&quot;;
	icmpcode[3, 8] = &quot;ISOLATED&quot;;
	icmpcode[3, 9] = &quot;NET_PROHIB&quot;;
	icmpcode[3, 10] = &quot;HOST_PROHIB&quot;;
	icmpcode[3, 11] = &quot;TOSNET&quot;;
	icmpcode[3, 12] = &quot;TOSHOST&quot;;
	icmpcode[3, 13] = &quot;FILTER_PROHIB&quot;;
	icmpcode[3, 14] = &quot;HOST_PRECEDENCE&quot;;
	icmpcode[3, 15] = &quot;PRECEDENCE_CUTOFF&quot;;
	icmptype[4] = &quot;SOURCEQUENCH&quot;;
	icmptype[5] = &quot;REDIRECT&quot;;
	icmpcode[5, 0] = &quot;NET&quot;;
	icmpcode[5, 0] = &quot;HOST&quot;;
	icmpcode[5, 0] = &quot;TOSNET&quot;;
	icmpcode[5, 0] = &quot;TOSHOST&quot;;
	icmptype[8] = &quot;ECHO&quot;;
	icmptype[9] = &quot;ROUTERADVERT&quot;;
	icmpcode[9, 0] = &quot;COMMON&quot;;
	icmpcode[9, 16] = &quot;NOCOMMON&quot;;
	icmptype[10] = &quot;ROUTERSOLICIT&quot;;
	icmptype[11] = &quot;TIMXCEED&quot;;
	icmpcode[11, 0] = &quot;INTRANS&quot;;
	icmpcode[11, 1] = &quot;REASS&quot;;
	icmptype[12] = &quot;PARAMPROB&quot;;
	icmpcode[12, 1] = &quot;OPTABSENT&quot;;
	icmpcode[12, 2] = &quot;BADLENGTH&quot;;
	icmptype[13] = &quot;TSTAMP&quot;;
	icmptype[14] = &quot;TSTAMPREPLY&quot;;
	icmptype[15] = &quot;IREQ&quot;;
	icmptype[16] = &quot;IREQREPLY&quot;;
	icmptype[17] = &quot;MASKREQ&quot;;
	icmptype[18] = &quot;MASKREPLY&quot;;

	printf(&quot;%-20s &nbsp;%-12s&nbsp;%1s&nbsp;%-15s&nbsp;%-15s&nbsp;%s\n&quot;, &quot;TIME&quot;, &quot;PROCESS&quot;, &quot;D&quot;,
	    &quot;REMOTE&quot;, &quot;TYPE&quot;, &quot;CODE&quot;);
}

fbt::icmp_inbound:entry
{
	this-&gt;mp = args[1];
	this-&gt;ipha = (ipha_t *)this-&gt;mp-&gt;b_rptr;
	/* stringify manually if inet_ntoa() unavailable */
	this-&gt;addr = inet_ntoa(&amp;this-&gt;ipha-&gt;ipha_src);
	this-&gt;dir = &quot;&lt;&quot;;
}

fbt::ip_xmit_v4:entry
/arg4 &amp;&amp; args[4]-&gt;conn_ulp == IPPROTO_ICMP/
{
	this-&gt;mp = args[0];
	this-&gt;ipha = (ipha_t *)this-&gt;mp-&gt;b_rptr;
	/* stringify manually if inet_ntoa() unavailable */
	this-&gt;addr = inet_ntoa(&amp;this-&gt;ipha-&gt;ipha_dst);
	this-&gt;dir = &quot;&gt;&quot;;
}

fbt::icmp_inbound:entry,
fbt::ip_xmit_v4:entry
/this-&gt;dir&nbsp;!= NULL/
{
	this-&gt;iph_hdr_length = IPH_HDR_LENGTH(this-&gt;ipha);
	this-&gt;icmph = (icmph_t *)&amp;this-&gt;mp-&gt;b_rptr[(char)this-&gt;iph_hdr_length];
	this-&gt;type = this-&gt;icmph-&gt;icmph_type;
	this-&gt;code = this-&gt;icmph-&gt;icmph_code;
	this-&gt;typestr = icmptype[this-&gt;type]&nbsp;!= NULL&nbsp;?
	    icmptype[this-&gt;type]&nbsp;: lltostr(this-&gt;type);
	this-&gt;codestr = icmpcode[this-&gt;type, this-&gt;code]&nbsp;!= NULL&nbsp;?
	    icmpcode[this-&gt;type, this-&gt;code]&nbsp;: lltostr(this-&gt;code);

	printf(&quot;%-20Y &nbsp;%-12.12s&nbsp;%1s&nbsp;%-15s&nbsp;%-15s&nbsp;%s\n&quot;, walltimestamp, execname,
	    this-&gt;dir, this-&gt;addr, this-&gt;typestr, this-&gt;codestr);
}
</pre>

<!-- 
NewPP limit report
Preprocessor node count: 7/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:116-0!1!0!!en!2!edit=0 and timestamp 20131031022621 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Network_Lower_Level_Protocols:icmpsnoop.d">http://www.dtracebook.com/index.php/Network_Lower_Level_Protocols:icmpsnoop.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Network_Lower_Level_Protocols:icmpsnoop.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Network_Lower_Level_Protocols:icmpsnoop.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Network_Lower_Level_Protocols:icmpsnoop.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Network_Lower_Level_Protocols:icmpsnoop.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Network_Lower_Level_Protocols:icmpsnoop.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
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
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Network_Lower_Level_Protocols:icmpsnoop.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Network_Lower_Level_Protocols:icmpsnoop.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Network_Lower_Level_Protocols:icmpsnoop.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Network_Lower_Level_Protocols:icmpsnoop.d&amp;oldid=498" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 29 September 2011, at 18:52.</li>
		<li id="viewcount">This page has been accessed 958 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.262 secs. --></body></html>
