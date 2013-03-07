---
layout: post
tags : ["Objective-C", "Coding"]
title: "Check your thread"
---
When you start using Grand Central Dispatch or `NSOperation`, you'll want to perform some actions on the main thread and some intentionally off the main thread.

This is a simple and obvious technique, but it took me a while to adopt it: You can do by asserting with `NSAssert` or `NSCAssert` for `[NSThread isMainThread]`, just as you would assert any other condition.

Like this:

    - (void)updateUI {
        NSAssert([NSThread isMainThread], @"Only update UI from main thread");
        // update UI
    }

    - (void)backgroundWork {
        NSAssert(![NSThread isMainThread], @"Only do work off main thread");
        // do work
    }

With assertions like this in place, you'll sort out what executes where in short order.

I wish I had done this to my code right away; it's much simpler to get it right than to go back and fix it all later.