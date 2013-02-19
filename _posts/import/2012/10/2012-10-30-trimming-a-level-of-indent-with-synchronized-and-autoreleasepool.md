---
layout: post
tags : ["autoreleasepool", "synchronized", "objective-c"]
title: "Trimming a level of indent with @synchronized and @autoreleasepool"
---
I haven't seen this discussed anywhere, but you can eliminate a level of indentation when using `@synchronized` and `@autoreleasepool` blocks in a loop or conditionally. This falls naturally as a result of the way the C language works, and how these blocks work, but it took me a while to realize it.

You may have code that looks like this:

	if (_foo) {
		@synchronized(self) {
			// stuff here
		}
	}

This can also be expressed more simply:

	if (_foo) @synchronized(self) {
		// stuff here
	}

Note that you can't use this if your `if` has an `else` statement.

This is also true of `@autoreleasepool`, and may be even more handy there:

	for (NSDictionary *item in items) {
		@autoreleasepool {
			// lots of stuff here
		}
	}

Can become:

	for (NSDictionary *item in items) @autoreleasepool {
		// lots of stuff here
	}

Now, always making C statements compound in a condition or loop is a pretty common convention. And if you stick by this convention in other places (as I do), that's fine. But the reasoning behind it doesn't really apply with `@autoreleasepool` and `@synchronized`: you can just consider them part of the opening bracket.

Unfortunately, you can't do this at the top level of message handlers. Wouldn't that be nice?