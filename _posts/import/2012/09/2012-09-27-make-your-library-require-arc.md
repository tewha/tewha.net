---
layout: post
tags : ["objc-arc", "Cocoa", "Cocoa Touch", "Objective-C", "Open Source"]
title: "Make your library enforce ARC"
---
If you have an open source library that requires Automatic Reference Counting (ARC), you may have issues with your users trying to build it without ARC turned on. Luckily, it's pretty simple to *enforce* ARC.

I'm going to discuss how to do so, and why it's a good idea.

<!--more-->

Here's an example, which I submitted to AFNetworking:

	#if !__has_feature(objc_arc)
	#error AFNetworking must be built with ARC.
	// You can turn on ARC for only AFNetworking files by adding -fobjc-arc to the build phase for each of its files.
	#endif

When the user builds the unit, the error will be highlighted. They'll see the comment just below, explaining how to resolve the problem.

Adding it to every .m file may seem overkill, but there's two good reasons for this:

1. No matter which file gets compiled first an error will top the list instead of warnings. It's sufficient to add it only to a central file, but you'll probably still get support requests that way. You're better off adding it everywhere; this is all about reducing your work.
2. ARC can be decided on a per-file basis. If you include it in only one file, the user may add -fobjc-arc to just that one file!

But do not add this to your headers. Even if your code requires ARC, there's no reason to require that the user's code also use ARC. Apple did the right thing here.