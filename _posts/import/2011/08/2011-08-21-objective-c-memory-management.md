---
layout: post
tags : ["cocoa", "Cocoa Touch", "memory-management"]
title: "Objective-C memory management"
---
With Automatic Reference Counting (ARC) coming out soon, you could argue this post is coming almost too late. But there's a lot of confusion over this, and I don't think ARC will help much if you don't understand the *why* of memory management.

After a couple years, I've come to adopt some very simple rules for memory management.

## Concepts

The first step is to pick up a few concepts that will help you as you code.

* **Be lazy in memory management.** Rely on the compiler to do everything it possibly can. The compiler can synthesize property setters that handle memory management according to the rules you set. Rely on this.
* **Ownership.** Think in terms of ownership, rather than reference counting. Thinking in terms of ownership makes problems and solutions obvious. Thinking in terms of ownership will help you keep in mind the *why* of what you're doing, rather than the *what*. After you've got a good grasp of *why*, the *what* becomes obvious.
* **Protect your objects.** Own any object that you want to keep around as long as `self` is around.
* **Avoid circular references.** Never own an object that could own `self`. This means never owning `self`'s delegate or data source.

## Practical guidelines

But how does this translate to code? There's a few specific and concrete things you can do to make this easier on yourself:

* **Use properties to centralize memory management rules.** Use `@property` to establish the rules for memory management of an instance variable. (And `@synthesize` your properties to underscored instance variables to prevent naming conflicts.)
* **Pick the right memory management rule.** Use `retain` properties as your default. Data sources, delegates or other objects that might own the object you're working in should be `assign` properties instead of `retain`.
* **Rely on the centralized memory management rules.** Use property set notation (`self.foo = nil;`) or the property setter (`[self setFoo: nil];`) everywhere you change the property's value except in the property's setter (if you need one) In this way, you rely on the `retain` or `assign` in your `@property` to specify the memory management. If you need to use `retain`, `release` or `autorelease` outside of a setter you're doing too much. (And, also, you'll have more work to do to be compatible with ARC.)
* **Avoid being called once deallocated.** In `dealloc`, `nil` any delegates you've set to `self`. (This eliminates the possibility that the object will survive longer than `self` and try to send messages to `self`.)
* **Protect your private bits, too.** Don't use raw instance variables in objects requiring memory management. Use anonymous properties.
* **Containers own their contents.** You not only don't need to but must not try to manage memory in a system container. An `NSArray` will send a `retain` to objects that are added to it, and a `release` to objects as they are removed. If you try to manually `retain` and `release` objects, you'll miss a case.
* **Verify.** Analyze your code frequently. And profile your code early and often for leaks.