<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Network Lower Level Protocols:macops.d - DTraceBook</title>
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
wgPageName="Network_Lower_Level_Protocols:macops.d",
wgTitle="Network Lower Level Protocols:macops.d",
wgAction="view",
wgArticleId=122,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=501,
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
<body class="mediawiki ltr ns-0 ns-subject page-Network_Lower_Level_Protocols_macops_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Network Lower Level Protocols:macops.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="macops.d.2C_page_534">macops.d, page 534</span></h1>
<pre>
#!/usr/sbin/dtrace -s

#pragma D option quiet

dtrace:::BEGIN
{
	/* See /usr/include/sys/dlpi.h */
	mediatype[0x0] = &quot;CSMACD&quot;;
	mediatype[0x1] = &quot;TPB&quot;;
	mediatype[0x2] = &quot;TPR&quot;;
	mediatype[0x3] = &quot;METRO&quot;;
	mediatype[0x4] = &quot;ETHER&quot;;
	mediatype[0x05] = &quot;HDLC&quot;;
	mediatype[0x06] = &quot;CHAR&quot;;
	mediatype[0x07] = &quot;CTCA&quot;;
	mediatype[0x08] = &quot;FDDI&quot;;
	mediatype[0x10] = &quot;FC&quot;;
	mediatype[0x11] = &quot;ATM&quot;;
	mediatype[0x12] = &quot;IPATM&quot;;
	mediatype[0x13] = &quot;X25&quot;;
	mediatype[0x14] = &quot;ISDN&quot;;
	mediatype[0x15] = &quot;HIPPI&quot;;
	mediatype[0x16] = &quot;100VG&quot;;
	mediatype[0x17] = &quot;100VGTPR&quot;;
	mediatype[0x18] = &quot;ETH_CSMA&quot;;
	mediatype[0x19] = &quot;100BT&quot;;
	mediatype[0x1a] = &quot;IB&quot;;
	mediatype[0x0a] = &quot;FRAME&quot;;
	mediatype[0x0b] = &quot;MPFRAME&quot;;
	mediatype[0x0c] = &quot;ASYNC&quot;;
	mediatype[0x0d] = &quot;IPX25&quot;;
	mediatype[0x0e] = &quot;LOOP&quot;;
	mediatype[0x09] = &quot;OTHER&quot;;

	printf(&quot;Tracing MAC calls... Hit Ctrl-C to end.\n&quot;);
}

/* the following are not complete lists of mac functions; add as needed */

/* mac functions with mac_client_impl_t as the first arg */
fbt::mac_promisc_add:entry,
fbt::mac_promisc_remove:entry,
fbt::mac_multicast_add:entry,
fbt::mac_multicast_remove:entry,
fbt::mac_unicast_add:entry,
fbt::mac_unicast_remove:entry,
fbt::mac_tx:entry
{
	this-&gt;macp = (mac_client_impl_t *)arg0;
	this-&gt;name = stringof(this-&gt;macp-&gt;mci_name);
	this-&gt;media = this-&gt;macp-&gt;mci_mip-&gt;mi_info.mi_media;
	this-&gt;type = mediatype[this-&gt;media]&nbsp;!= NULL&nbsp;?
	    mediatype[this-&gt;media]&nbsp;: lltostr(this-&gt;media);
	this-&gt;dir = probefunc == &quot;mac_tx&quot;&nbsp;? &quot;-&gt;&quot;&nbsp;: &quot;.&quot;;
	@[this-&gt;name, this-&gt;type, probefunc, this-&gt;dir] = count();
}

/* mac functions with mac_impl_t as the first arg */
fbt::mac_stop:entry,
fbt::mac_start:entry,
fbt::mac_stat_get:entry,
fbt::mac_ioctl:entry,
fbt::mac_capab_get:entry,
fbt::mac_set_prop:entry,
fbt::mac_get_prop:entry,
fbt::mac_rx:entry
{
	this-&gt;mip = (mac_impl_t *)arg0;
	this-&gt;name = stringof(this-&gt;mip-&gt;mi_name);
	this-&gt;media = this-&gt;mip-&gt;mi_info.mi_media;
	this-&gt;type = mediatype[this-&gt;media]&nbsp;!= NULL&nbsp;?
	    mediatype[this-&gt;media]&nbsp;: lltostr(this-&gt;media);
	this-&gt;dir = probefunc == &quot;mac_rx&quot;&nbsp;? &quot;&lt;-&quot;&nbsp;: &quot;.&quot;;
	@[this-&gt;name, this-&gt;type, probefunc, this-&gt;dir] = count();
}

dtrace:::END
{
	printf(&quot; &nbsp;%-16s&nbsp;%-16s&nbsp;%-16s&nbsp;%-4s&nbsp;%14s\n&quot;, &quot;INT&quot;, &quot;MEDIA&quot;, &quot;MAC&quot;,
	    &quot;DATA&quot;, &quot;CALLS&quot;);
	printa(&quot; &nbsp;%-16s&nbsp;%-16s&nbsp;%-16s&nbsp;%-4s&nbsp;%@14d\n&quot;, @);
}
</pre>

<!-- 
NewPP limit report
Preprocessor node count: 7/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:122-0!1!0!!en!2!edit=0 and timestamp 20131031143434 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Network_Lower_Level_Protocols:macops.d">http://www.dtracebook.com/index.php/Network_Lower_Level_Protocols:macops.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Network_Lower_Level_Protocols:macops.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Network_Lower_Level_Protocols:macops.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Network_Lower_Level_Protocols:macops.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Network_Lower_Level_Protocols:macops.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Network_Lower_Level_Protocols:macops.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
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
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Network_Lower_Level_Protocols:macops.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Network_Lower_Level_Protocols:macops.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Network_Lower_Level_Protocols:macops.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Network_Lower_Level_Protocols:macops.d&amp;oldid=501" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 29 September 2011, at 18:53.</li>
		<li id="viewcount">This page has been accessed 924 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.298 secs. --></body></html>
