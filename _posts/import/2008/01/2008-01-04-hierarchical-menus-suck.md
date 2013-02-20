---
layout: post
tags : ["Interface Design", "Mac OS X", "Software"]
title: "Hierarchical menus suck"
---
In <a href="http://daringfireball.net/2008/01/where_keyboard_shortcuts_win">Where Keyboard Shortcuts Win</a>, Gruber talks about Tog's findings on mouse vs. keyboard. In a footnote, he adds:



<blockquote>Especially with most Cocoa apps, where the Find commands are in a sub-menu, and thus take even longer to target using the mouse.</blockquote>



To me, this is a real problem on Mac OS. It is not one that Apple has not only completely failed to address, but has actually made worse in Mac OS X. For technical users, items in hierarchical menus are slightly more difficult to activate. But for non-technical users, items in hierarchical menus are <strong>not</strong> just a little more difficult to activate, but <strong>awesomely</strong> so. And in Mac OS X, Apple has introduced <em>more</em> of them!


<!--more-->

Hierarchical menus have become a little better now that you don't have to hold down the mouse button ((And, in fact, this suggests a simple fix Apple could do: Clicking an item with a hierarchical menu should lock that hierarchical menu open so the user can take as long as they want and use whatever motion they want to get into the hierarchical menu.)), but watching a neophyte or novice try to access them is a real eye-opener. I'd really suggest to any developer thinking of using one that they ask a non-technical person to select one. Using the mouse at all is the first major task. Using the mouse to select menu items is almost as difficult. And using the mouse to select menu items in hierarchal menus will often be more difficult than the previous two combined. It's not only conceptually screwy, but physically difficult.



After doing so with a product used by teachers (including the almost-ready-to-retire), I removed every hierarchical menu from our application. There weren't many anyway. But one of the most difficult things for me when moving from Mac OS Classic to Mac OS X was how obvious it was that Apple <em>hadn't</em> tested this.



Now I'm not altogether opposed to hierarchical menus. I think they're a perfectly valid solution for Services, Open With and maybe even Arrange By ((Arrange By is a valid place to use them only because novices and neophytes are probably looking to arrange by name most often, and that's easily achieved by switching to list view.)). All of these options can be accessed some other way, except for Services which are rarely used by novices or neophytes. I also think they're fine for contextual menus, since contextual menus only offer choices that are available elsewhere. ((Ahem. Or should. See <a href="http://developer.apple.com/documentation/UserExperience/Conceptual/OSXHIGuidelines/XHIGMenus/chapter_16_section_5.html#//apple_ref/doc/uid/TP30000356-TPXREF113">Apple's Human Interface Guidelines on Contextual Menus</a>.)) But having Find commands in a hierarchical menu? That's completely completely insane. Find is something users need to be able to access.



Apple even admits this problem in <a href="http://developer.apple.com/documentation/UserExperience/Conceptual/OSXHIGuidelines/XHIGMenus/chapter_16_section_3.html#//apple_ref/doc/uid/TP30000356-TPXREF122">Apple Human Interface Guidelines</a>:



<blockquote>Because submenus add complexity to the interface and are physically more difficult to use, you should use them only when you have more menus than fit in the menu bar...</blockquote>



So far, so good. But they go on:

<blockquote>...or for closely related commands.</blockquote>



This simply does not follow! Making something physically more difficult to use just because it's closely related to something else is stupid. A good design puts commands in recognizable locations, and puts commands users need to access <strong>in locations that are easy to physically access</strong>. Closely related is <em>not</em> an excuse for a hierarchical menu. Closely related <em>and</em> infrequently used ((Or an option with an easier access method.)) is a good reason, though. But what genius decided that spell checking and find qualified? If find qualifies as infrequently used, it's almost certainly because it's such as a pain in the ass to select!



I do think this is less of a problem now that the menu search has been added to the Help menu. I find myself using this frequently in applications with many infrequently-used menu entries. ((Another symptom of lack of zen in application design. A few unused commands are normal but when a menu bar consists almost entirely of unused commands there's a problem.))