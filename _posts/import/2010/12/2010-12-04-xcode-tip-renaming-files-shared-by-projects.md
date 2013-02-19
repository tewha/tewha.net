---
layout: post
tags : ["Common Sense", "Good Design", "iOS Development", "Mac OS X", "Software Development", "Xcode"]
title: "Xcode tip: Renaming files shared by projects"
---
What if you want to rename a file that's used in multiple Xcode projects? Well, previously I'd rename the file in one project, then open each project in series and correct broken references. But I discovered today that this is unnecessary. If you open all of your projects first, Xcode will fix the references across <strong>all</strong> of your open projects as you rename files in <strong>any</strong> of the projects.

For all I know, this has always been a feature of Xcode. But I've never noticed it before. So for this stunning display of common sense: Well done, Apple!