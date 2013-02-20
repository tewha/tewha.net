---
layout: post
tags : ["Objective-C", "Coding"]
title: "Why you should use instancetype instead of id"
---
In my previous entry, I discussed [when `id` will be promoted to `instancetype`][1]. But now that I've explained this, I'd like to explain why you should *understand* this but not *rely* on it. Instead, you should use `instancetype` directly.

Let me start with this bold statement, then I'll back up and explain it: Use `instancetype` whenever it's appropriate, which is whenever a class returns an instance of that same class.

<!--more-->

First, some definitions:

    @interface Foo:NSObject
    - (id)initWithBar:(NSInteger)bar; // initializer
    + (id)fooWithBar:(NSInteger)bar;  // convenience constructor
    @end

For a convenience constructor, you should **always** use `instancetype`. The compiler does not automatically convert `id` to `instancetype`.

For initializer, it's more complicated. When you type this:

    - (id)initWithBar:(NSInteger)bar

…the compiler will pretend you typed this instead:

    - (instancetype)initWithBar:(NSInteger)bar

This was necessary for ARC. This is why people will tell you it isn't necessary to use `instancetype`, though I contend you should. The rest of this answer deals with this.

There's three advantages:

1. **Explicit.** Your code is doing what it says, rather than something else.
2. **Pattern.** You're building good habits for times it does matter, which do exist.
3. **Consistency.** You've established some consistency to your code, which makes it more readable.

## Explicit ##

It's true that there's no *technical* benefit to returning `instancetype` from an `init`. But this is because the compiler automatically converts the `id` to `instancetype`. You are relying on this quirk; while you're writing that the `init` returns an `id`, the compiler is interpreting it as if it returns an `instancetype`.

These are *equivalent* to the compiler:

    - (id)initWithBar:(NSInteger)bar;
    - (instancetype)initWithBar:(NSInteger)bar;

These are not equivalent to your eyes. At best, you will learn to ignore the difference and skim over it. **This is not something you should learn to ignore.**

## Pattern ##

While there's no difference with `init` and other methods, there **is** a different as soon as you define a convenience constructor.

These two are not equivalent:

    + (id)fooWithBar:(NSInteger)bar;
    + (instancetype)fooWithBar:(NSInteger)bar;

You want the second form. If you are used to typing `instancetype` as the return type of a constructor, you'll get it right every time.

## Consistency ##

Finally, imagine if you put it all together: you want an `init` function and also a convenience constructor.

If you use `id` for `init`, you end up with code like this:

    - (id)initWithBar:(NSInteger)bar;
    + (instancetype)fooWithBar:(NSInteger)bar;

But if you use `instancetype`, you get this:

    - (instancetype)initWithBar:(NSInteger)bar;
    + (instancetype)fooWithBar:(NSInteger)bar;

It's more consistent and more readable. They return the same thing, and now that's obvious.

## Conclusion ##

Unless you're intentionally writing code for old compilers, you should use `instancetype` when appropriate.

You should hesitate before writing a message that returns `id`. Ask yourself: Is this returning an instance of this class? If so, it's an `instancetype`.

There are certainly cases where you need to return `id`; namely, if you're returning a different class. But you'll probably use `instancetype` much more frequently than `id`.

[1]: http://tewha.net/2013/01/when-is-id-promoted-to-instancetype/