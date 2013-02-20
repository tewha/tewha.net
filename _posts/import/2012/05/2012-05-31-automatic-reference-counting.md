---
layout: post
tags : ["objc-arc", "iOS", "iOS 5", "Memory Management", "Software Development", "Xcode", "coding"]
title: "Automatic Reference Counting"
---
If you're an application developer: Yes, you should use Automatic Reference Counting (ARC).

<!--more-->

Odds are, the compiler understands Objective-C and Cocoa better than you. I don't mean this as an insult; it certainly understands it better than me. I think you could safely say it understands the rules better than all but maybe a dozen people worldwide. And it knows tricks to use them to a degree that you and I can't repeat, even if we understood as well as it does.

The rest is just details, but they're important:

1. You will write a lot less boring code. Code so boring it's easy to make mistakes.
2. As a blended compile time and run time process, it has access to tricks that you don't.
3. It will a better a job of writing memory management code than you can, even if you write the theoretical perfect memory management code.
4. It will reduce "high tide" memory usage (somewhat) without any effort on your part.

If you are starting a new application, stop thinking about it and just use it.

If you have an existing application, you need to think about it. You're balancing the ease of future development vs. a need to re-test the app. The ARC conversion isn't awful, but it isn't painless or foolproof either. You will need to make sure you have no circular references, and you will need to make sure that objects don't disappear sooner than you think.

If you have an existing application that targets iOS before iOS 5, zeroing weak references are not supported. You can find people who will tell you that zeroing weak references aren't a big deal. They're wrong. While it's true you can use assign to prevent circular references, weak references are what turns ARC from a useful way to write less code to a fantastic way to write stable applications. You should seriously consider requiring iOS 5.

If you have an existing application that targets iOS before iOS 4, you can't use it at all. What are you thinking, supporting a version of iOS that old?

See also:

* [Transitioning to ARC](https://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226): Apple's ARC overview. A great overview, but possibly less than you need to know.
* [Automatic Reference Counting](http://clang.llvm.org/docs/AutomaticReferenceCounting.html): The living and detailed ARC specification and rationales. Certainly much more information than you require.