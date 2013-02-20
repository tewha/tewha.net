---
layout: post
tags : ["instancetype", "Objective-C", "Coding"]
title: "When is id promoted to instancetype?"
---
`instancetype` is a special type that can be returned from an Objective-C method. It specifies that the return is an object of the same type as the receiving class. In some cases, the compiler promotes an `id` return to an instancetype: For instance, despite the definition of `[[NSString alloc] init]`, the compiler knows that it returns an `NSString`.

<!--more-->

When?

This is straight from [Clang Language Extensions](http://clang.llvm.org/docs/LanguageExtensions.html#related-result-types):

* the first word is “alloc” or “new”, and the method is a class method, or
* the first word is “autorelease”, “init”, “retain”, or “self”, and the method is an instance method.

Left unsaid is whether it's better to actually specify `instancetype` for these rather than rely on automatic promotion of `id`. Most code I've seen relies on the automatic promotion. I'm not sure what combination this is of momentum, readability, compatibility and convention. I've kept to using `id` in these cases, but that's mostly due to momentum.

However, you should certainly use `instancetype` if you want to specify that an instance of the receiving class is returned in cases where autopromotion doesn't occur, such as a convenience factory.

For example, in this case:

    MyObject *bar = [MyObject objectWithParameter: foo];

…you would want `MyObject` to specify that `objectWithParameter` returns an `instancetype` rather than an `id`.

See also:

* Mattt Thompson: [instancetype](http://nshipster.com/instancetype/).