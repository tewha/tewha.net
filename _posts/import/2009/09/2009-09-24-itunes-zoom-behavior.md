---
layout: post
tags : ["iTunes", "Standards", "Bad Interface"]
title: "iTunes zoom behavior"
---
iTunes prior to 9.0 used a click on the zoom widget to convert to the mini player, leaving people like me who actually like to zoom a window option-clicking it.

<!--more-->

iTunes 9.0 finally fixed this. A click on the zoom widget actually zoomed the window!

iTunes 9.0.1 changed it back to the old behavior. Many people were happy, I imagine. But people who wanted to zoom iTunes windows (or, I imagine, valued standard behavior) were left sad.

It turns out you can get the click-to-zoom behavior back:

    defaults write com.apple.iTunes zoom-to-window -bool true

Tip of the hat to <a href="http://twitter.com/zadr ">zadr</a> on Twitter for <a href="http://twitter.com/zadr/status/4300874028">this tweet</a>.