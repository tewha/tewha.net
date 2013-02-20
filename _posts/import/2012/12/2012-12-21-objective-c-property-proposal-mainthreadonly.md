---
layout: post
tags : ["Objective-C", "Proposal"]
title: "Objective-C property proposal: mainthreadonly"
---
Let me be clear: Objective-C does not do this. But wouldn't it be cool if it did?

    @interface CustomView:UIView
    @property (mainthreadonly) NSString *title;
    @end

The intent is to solve confusion over properties that must be set from the main thread or have no effect.

`mainthreadonly` would be like `nonatomic`. Compared to `nonatomic`, it also warns that the property can only be set from the main thread. `@synthesize` would generate a setter that is not only`nonatomic`, but generates an exception if called from a thread other than the main thread.

Logically, this is the equivalent of:

    - (void)setTitle: (NSString *)title {
        NSAssert([NSThread isMainThread], @"Property title can only be set from the main thread.");
        // everything else a synthesized setter does
    }

Of course, if you provide your own setter it's up to you to enforce main thread or not. Ideally, you should, but if you don't the `@property` definition simply serves as a warning to developers reading your header. You've expressed something to both the developer and the compiler, and I think that's always good.

Another idea is to `dispatch_async` to the main thread automatically, but I suspect this would have too many side effects. Also, it would mean multiple dispatches for sequential property sets. And I feel that setting a property that must be set from the main thread only from a different thread probably **is** a bug that should be fixed.