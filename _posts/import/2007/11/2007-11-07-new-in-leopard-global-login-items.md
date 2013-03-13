---
layout: post
tags : ["launchd", "Mac OS X", "Mac OS X Leopard"]
title: "New in Leopard: Global Login Items?"
---
Not a lot of details yet, but apparently Mac OS X 10.5 supports Global Login Items. This would be a nice thing to have more information on, as I can imagine needing to remove these.

<!--more-->

From Apple's technote on [Daemons and Agents][1]:

>A **global login item** is a login item that is launched when any user logs in. Installing a global login item is roughly equivalent to installing that login item for all users on the system: every time a user logs in, loginwindow launches that user's login items and all global login items.

>In Mac OS X 10.5 and later you can install a global login item using the shared file lists interface to Launch Services.

I'm getting the feeling from that description that there's no UI for managing these. There's also the possibility that some doc writer made the whole thing up. Anyone know more?

[1]: http://developer.apple.com/technotes/tn2005/tn2083.html#SECGLOBALLOGINITEM