---
layout: post
tags : ["Objective-C", "Coding", "iOS"]
title: "On Frameworks"
---

A coworker sent me a link to [this posting on the state of libraries on iOS][1]. I sent back a quick reply, with the intent to write a blog post on the subject later.

I've since decided that this replay says almost everything I wanted to say, so I decided to just edit it a bit.

I’m pretty torn on this whole subject. Dynamic libraries can lead to inefficiencies in storage space if a developer isn’t careful, and I’ve no reason to believe iOS developers are careful. Include Google Toolbox for one function? Sure, why not? Apple's always balanced the experience towards users, and even when it makes my life more difficult I like that.

The static library approach isn’t a good approach either. Sometimes I’ve had less than complete debugging info, and been missing information in crash logs. And its code stripping isn't as good as it should be, either. The final straw for me was when [HockeyApp's crash reporter][2] stopped producing useful stack crawls. I spent a few hours trying to fix this, even got a little help (HockeyApp is excellent, and their support is outstanding) but quickly realized I was spending too much time on a problem with a very pragmatic fix.

(What was the problem? I'm not sure. It seemed to be related to an Xcode update, but after a few hours I grew less interested in solving it and more interested in shipping what was a critical update to my app.)

[Cocoapods][3] tries to solve this, but I think it does so the wrong way. You still have the same problems, it’s just a little less trouble to keep it going. It's probably better than nothing, but it wasn't the approach I wanted to take.

What I’ve been doing recently is including the sources in groups within my project. This is harder for me, but better for the compiler/linker (it has a better sense of everything I'm trying to do), debugger (all the symbol information is built as part of the main project) **and** the end user (who gets a better stripped executable).

What we need is not static libraries or dynamic libraries or frameworks. We need something better, more tuned to iOS.

There's a few options:

* A project include file, which lets you specify a source group to build but is linked into the main project. This has the advantage of being linked separately.
* A *dynamic* dynamic library, where the library is built by the main project based on the subproject with an understanding of what parts of library the main project uses.

Until Apple has a good solution to this, I’m going to continue to avoid static libraries (except for very specific libraries, like HockeyApp) and put the sources in a group.

I really hope Apple comes up with a good solution soon, though. This is indeed painful. I think Landon's radar is entirely positive; Apple isn't too likely to just do the easy thing. They'll think about, evaluate possibilities, then do something that we can hopefully live with. Hopefully something better than any of us anticipated.

[1]: http://landonf.bikemonkey.org/code/ios/Radar_15800975_iOS_Frameworks.20140112.html
[2]: http://hockeyapp.net/
[3]: http://cocoapods.org