---
layout: post
tags : ["Automatic Update", "Software Development", "User Interface"]
title: "Your app has a job, and it isn't updating itself."
---
WarpedVisions has an article on [automatic updates imposing on users][1].

I've done some thinking on this subject.

Should you wait on an update check before presenting the UI? Should you ask them if they want to update? If they do want to update, should they need to go through a web browser to download the update? Should it be a standard installer?

<!--more-->

One principle I like for automatic update is this:

**Assume the user launched your application because they want to do something.**

All of these questions have answers that developers assume they know, but when you start looking at it from a user perspective, things are very different.

## Update checks shouldn't be blocking. ##

Should you wait on an update check before presenting the UI? Let's imagine your host goes down, and the user is stuck waiting and waiting for your application to launch. Or maybe the host is just slow; that's even worse. The *best* case is the user is disconnected from the Internet and failure is immediate.

This doesn't mean you shouldn't start a check, of course. Go ahead. Make it run in the background. If the check finishes before the UI is loaded, you can adjust the UI. Otherwise, you can remember for next launch.



## Update requests shouldn't be blocking, either. ##

Decide if you're going to apply the update automatically or not. The answer should usually be no.

If the update does need to be applied automatically, install it when it won't impose (if you can judge when that will be, and if such a situation even exists).

If the user doesn't need to update immediately, offer the update in a prominent place within your program, but don't make them click to refuse it. Clicking "Not Now" is just going to become a habit. And don't just tell them a new version is available and direct them to a web site. **When they want to investigate, tell them why they'd want it!** Replace nagging with good information.

## Make the update as pain-free as possible. ##

Download the update yourself. Whether automatically or on-demand, apply it yourself.

The decision whether to apply the update can be a painful one for users. It's your job as a developer to provide the information users need to make that decision, and to do it in a way that encourages (rather than demands) the decision be made, and to eliminate any unnecessary pain associated with the update.

[1]: http://warpedvisions.org/2007/11/14/boot-to-windows-do-not-pass-go
