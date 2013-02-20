---
layout: post
tags : ["Cocoa Touch", "Documentation Viewer", "iPhone", "Xcode"]
title: "Loving Xcode + iPhone SDK"
---
I've been full time on an iPhone project (more of a prototype, really) for one day, and I absolutely love it.

<!--more-->

* It's simple and intuitive. Drop controls, set up outlets and actions.

* You don't have to fight the framework. It does what it does with a minimum of fuss.

* A good UI is a focused UI, rather than one full of features. I love this style of thinking.

I'm less thrilled with Xcode's documentation viewer. It feels like a really poor web browser that takes more of the screen for junk, runs in the same workspace so you can't command-tab in and out of it. Just splitting it into a separate process would immediately improve it.

In about a day, I created four screens and linked them all together. That doesn't sound horribly impressive, but it felt easy. Granted, I've previously spent a few hours figuring out <code>UINavigationController</code>, but things were actually simpler than I had understood. Finding things took a while, but they were generally hidden in plain sight. The few times I violated something in the runtime, the error message was simple, direct and accurate.

I do wish <a href="http://www.sqlite.org/">SQLite</a> was a more recent version. I would love to use <a href="http://www.sqlite.org/c3ref/open.html">sqlite3_open_v2</a> in some of this code, especially the <code>SQLITE_OPEN_READONLY</code> flag.