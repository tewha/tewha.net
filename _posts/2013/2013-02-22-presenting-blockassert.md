---
layout: post
tags : ["Objective-C", "Coding"]
title: "Presenting BlockAssert"
---
Assertions are a great tool. As an Objective-C programmer, I use `NSAssert` and `NSCAssert` liberally.

For various reasons, you sometimes can't use `NSAssert` in a block easily. I'm going to explain why and describe a new macro, `BlockAssert`, which solves this.

<!--more-->

## Background ##

An assertion is a predicate (a true–false statement) placed in a program to indicate that the developer thinks that the predicate is always true at that place. (Source: [Wikipedia][1].)

`NSAssert` and `NSCAssert` are Foundation's assertion macros. They're kind of like C's assert macro, but provide an error message in the same form as `NSLog`. The difference between them is that `NSAssert` references `self`, which is only defined for Objective-C methods. `NSCAssert`, then, is `NSAssert` for C functions.

Blocks are often defined in Objective-C methods, but they're not themselves Objective-C methods. Although they're actually implemented as objects of their own, the syntax is more like a C functions. They don't define self, though anything you want from the method scope are captured strongly into the block expression. This means that if you use `NSAssert` you'll be capturing `self`. But that strong reference can cause a circular reference.

A circular reference is formed the block owns the object and the object owns something that owns the block. None of the memory will ever be cleaned up. Even you *do* clean up the memory, you'll get a compiler warning that you need to ignore.

Rather than sort out which of these compiler warnings is valid, a lot of people use this pattern:

    __weak typeof(self) weakSelf = self;
    foo.completionBlock = ^{
    	__strong typeof(self) strongSelf = weakSelf;
        [strongSelf doSomething];
    };

This breaks the circular reference, and because we've used `__weak` we're assured that `weakSelf` is not a dangling pointer. If `self` no longer exists, `weakSelf` is `nil`. Reassigning back to a `__strong` variable presents the variable from being deallocated

*In this case, it's not actually necessary to assign `weakSelf` to a `__strong` variable. The recipient of a message won't be deallocated until the message returns. However, if you are doing multiple things with `weakSelf` — such as doing assertions against it and sending it a message — it could become deallocated between those messages.*

The catch? `NSAssert` still uses the `self` variable by name. This led to an interesting question on StackOverflow about [defining a block-scope self][2], a technique that's valid but requires you to remember to do it every time and [causes a warning if GCC_WARN_SHADOW is on][3].

## A new assertion macro ##

In the past, I've mostly done avoided this by not using assertions in blocks. You don't need them very often, as you can usually do your assertions in the method's scope. But inspired by that question, I've found a better way: I define my own assertion macro.

I have several such macros I define, in a single file that's imported in as part of my precompiled header.

The macro looks like this:

    #define BlockAssert(condition, desc, ...) \
        do { \
            __PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
            if (!(condition)) { \
                [[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd \
                object:strongSelf file:[NSString stringWithUTF8String:__FILE__] \
                    lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
            } \
            __PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
        } while(0)

This is basically a copy-paste of `NSAssert`, but uses `strongSelf` instead of `self`. (Note, however, that we have *not* pretended to be part of Foundation by using a NS prefix.)

To use `BlockAssert`, you need to use the `weakSelf = self; strongSelf = weakSelf;` pattern, but you probably already are. And if not, the compiler will throw an error: **Use of undeclared identifier: 'strongSelf'**. You can either adopt `strongSelf` or switch over to `NSAssert`.

For example:

    - (IBAction)clickButton: (UIButton *)sender {
        sender.disabled = YES;
        [self performActionWithCompletion: ^{
            BlockAssert(state, @"Invalid state");
            sender.disabled = NO;
        }];
    }

## Conclusion ##

I think this is a pretty good approach: If you use `NSAssert` where you meant to use `BlockAssert` and it matters, you'll get a warning about a potential circular reference. If you use `BlockAssert` where you meant to use `NSAssert`, you'll probably get a compiler error.

[1]: http://en.wikipedia.org/wiki/Assertion_(computing)
[2]: http://stackoverflow.com/questions/14194600/is-typeofself-self-weakself-construction-legitimate-inside-block
[3]: {{ production_url }}/2013/02/against-gcc_warn_shadow/