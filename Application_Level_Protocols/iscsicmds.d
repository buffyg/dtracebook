<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Application Level Protocols:iscsicmds.d - DTraceBook</title>
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
wgPageName="Application_Level_Protocols:iscsicmds.d",
wgTitle="Application Level Protocols:iscsicmds.d",
wgAction="view",
wgArticleId=171,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=229,
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
<body class="mediawiki ltr ns-0 ns-subject page-Application_Level_Protocols_iscsicmds_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Application Level Protocols:iscsicmds.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="iscsicmds.d">iscsicmds.d</span></h1>
<pre>
#!/usr/sbin/dtrace -s

#pragma D option quiet

string scsi_cmd[uchar_t];

dtrace:::BEGIN
{
	/*
	 * The following was generated from the SCSI_CMDS_KEY_STRINGS
	 * definitions in /usr/include/sys/scsi/generic/commands.h using sed.
	 */
	scsi_cmd[0x00] = &quot;test_unit_ready&quot;;
	scsi_cmd[0x01] = &quot;rezero/rewind&quot;;
	scsi_cmd[0x03] = &quot;request_sense&quot;;
	scsi_cmd[0x04] = &quot;format&quot;;
	scsi_cmd[0x05] = &quot;read_block_limits&quot;;
	scsi_cmd[0x07] = &quot;reassign&quot;;
	scsi_cmd[0x08] = &quot;read&quot;;
	scsi_cmd[0x0a] = &quot;write&quot;;
	scsi_cmd[0x0b] = &quot;seek&quot;;
	scsi_cmd[0x0f] = &quot;read_reverse&quot;;
	scsi_cmd[0x10] = &quot;write_file_mark&quot;;
	scsi_cmd[0x11] = &quot;space&quot;;
	scsi_cmd[0x12] = &quot;inquiry&quot;;
	scsi_cmd[0x13] = &quot;verify&quot;;
	scsi_cmd[0x14] = &quot;recover_buffer_data&quot;;
	scsi_cmd[0x15] = &quot;mode_select&quot;;
	scsi_cmd[0x16] = &quot;reserve&quot;;
	scsi_cmd[0x17] = &quot;release&quot;;
	scsi_cmd[0x18] = &quot;copy&quot;;
	scsi_cmd[0x19] = &quot;erase_tape&quot;;
	scsi_cmd[0x1a] = &quot;mode_sense&quot;;
	scsi_cmd[0x1b] = &quot;load/start/stop&quot;;
	scsi_cmd[0x1c] = &quot;get_diagnostic_results&quot;;
	scsi_cmd[0x1d] = &quot;send_diagnostic_command&quot;;
	scsi_cmd[0x1e] = &quot;door_lock&quot;;
	scsi_cmd[0x23] = &quot;read_format_capacity&quot;;
	scsi_cmd[0x25] = &quot;read_capacity&quot;;
	scsi_cmd[0x28] = &quot;read(10)&quot;;
	scsi_cmd[0x2a] = &quot;write(10)&quot;;
	scsi_cmd[0x2b] = &quot;seek(10)&quot;;
	scsi_cmd[0x2e] = &quot;write_verify&quot;;
	scsi_cmd[0x2f] = &quot;verify(10)&quot;;
	scsi_cmd[0x30] = &quot;search_data_high&quot;;
	scsi_cmd[0x31] = &quot;search_data_equal&quot;;
	scsi_cmd[0x32] = &quot;search_data_low&quot;;
	scsi_cmd[0x33] = &quot;set_limits&quot;;
	scsi_cmd[0x34] = &quot;read_position&quot;;
	scsi_cmd[0x35] = &quot;synchronize_cache&quot;;
	scsi_cmd[0x37] = &quot;read_defect_data&quot;;
	scsi_cmd[0x39] = &quot;compare&quot;;
	scsi_cmd[0x3a] = &quot;copy_verify&quot;;
	scsi_cmd[0x3b] = &quot;write_buffer&quot;;
	scsi_cmd[0x3c] = &quot;read_buffer&quot;;
	scsi_cmd[0x3e] = &quot;read_long&quot;;
	scsi_cmd[0x3f] = &quot;write_long&quot;;
	scsi_cmd[0x44] = &quot;report_densities/read_header&quot;;
	scsi_cmd[0x4c] = &quot;log_select&quot;;
	scsi_cmd[0x4d] = &quot;log_sense&quot;;
	scsi_cmd[0x55] = &quot;mode_select(10)&quot;;
	scsi_cmd[0x56] = &quot;reserve(10)&quot;;
	scsi_cmd[0x57] = &quot;release(10)&quot;;
	scsi_cmd[0x5a] = &quot;mode_sense(10)&quot;;
	scsi_cmd[0x5e] = &quot;persistent_reserve_in&quot;;
	scsi_cmd[0x5f] = &quot;persistent_reserve_out&quot;;
	scsi_cmd[0x80] = &quot;write_file_mark(16)&quot;;
	scsi_cmd[0x81] = &quot;read_reverse(16)&quot;;
	scsi_cmd[0x83] = &quot;extended_copy&quot;;
	scsi_cmd[0x88] = &quot;read(16)&quot;;
	scsi_cmd[0x8a] = &quot;write(16)&quot;;
	scsi_cmd[0x8c] = &quot;read_attribute&quot;;
	scsi_cmd[0x8d] = &quot;write_attribute&quot;;
	scsi_cmd[0x8f] = &quot;verify(16)&quot;;
	scsi_cmd[0x91] = &quot;space(16)&quot;;
	scsi_cmd[0x92] = &quot;locate(16)&quot;;
	scsi_cmd[0x9e] = &quot;service_action_in(16)&quot;;
	scsi_cmd[0x9f] = &quot;service_action_out(16)&quot;;
	scsi_cmd[0xa0] = &quot;report_luns&quot;;
	scsi_cmd[0xa2] = &quot;security_protocol_in&quot;;
	scsi_cmd[0xa3] = &quot;maintenance_in&quot;;
	scsi_cmd[0xa4] = &quot;maintenance_out&quot;;
	scsi_cmd[0xa8] = &quot;read(12)&quot;;
	scsi_cmd[0xa9] = &quot;service_action_out(12)&quot;;
	scsi_cmd[0xaa] = &quot;write(12)&quot;;
	scsi_cmd[0xab] = &quot;service_action_in(12)&quot;;
	scsi_cmd[0xac] = &quot;get_performance&quot;;
	scsi_cmd[0xAF] = &quot;verify(12)&quot;;
	scsi_cmd[0xb5] = &quot;security_protocol_out&quot;;

	printf(&quot;Tracing... Hit Ctrl-C to end.\n&quot;);
}

iscsi:::scsi-command
{
	this-&gt;code = *args[2]-&gt;ic_cdb;
	this-&gt;cmd = scsi_cmd[this-&gt;code]&nbsp;!= NULL&nbsp;?
	    scsi_cmd[this-&gt;code]&nbsp;: lltostr(this-&gt;code);
	@[args[0]-&gt;ci_remote, this-&gt;cmd] = count();
}

dtrace:::END
{
	printf(&quot; &nbsp;%-24s&nbsp;%-36s &nbsp;%s\n&quot;, &quot;iSCSI CLIENT&quot;, &quot;SCSI COMMAND&quot;, &quot;COUNT&quot;);
	printa(&quot; &nbsp;%-24s&nbsp;%-36s &nbsp;%@d\n&quot;, @);
}
</pre>

<!-- 
NewPP limit report
Preprocessor node count: 7/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:171-0!1!0!!en!2!edit=0 and timestamp 20131031045456 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Application_Level_Protocols:iscsicmds.d">http://www.dtracebook.com/index.php/Application_Level_Protocols:iscsicmds.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Application_Level_Protocols:iscsicmds.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Application_Level_Protocols:iscsicmds.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Application_Level_Protocols:iscsicmds.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Application_Level_Protocols:iscsicmds.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Application_Level_Protocols:iscsicmds.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
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
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Application_Level_Protocols:iscsicmds.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Application_Level_Protocols:iscsicmds.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Application_Level_Protocols:iscsicmds.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Application_Level_Protocols:iscsicmds.d&amp;oldid=229" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 6 March 2011, at 23:04.</li>
		<li id="viewcount">This page has been accessed 768 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.269 secs. --></body></html>
