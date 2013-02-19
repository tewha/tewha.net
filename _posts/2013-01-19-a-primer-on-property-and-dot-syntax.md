---
layout: post
tags : [dot syntax, objective-c, Objective-C 2.0, property]
title: "A primer on @property and dot syntax"
---

Properties were new in Objective-C 2.0, introduced in 2006. While pretty uncontroversial, along with them came dot syntax. Dot syntax is much more controversial.

##Properties

Properties are awesome. A `@property` declaration formalizes some things that previously had to be explained in comments or by convention.

Without properties, you'd specify a getter and setter like this:

    @interface Bar : NSObject
    - (void)setFoo: (NSObject *)foo;
    - (NSObject *)foo;
    @end

With properties, you can specify it like this:

    @interface Bar : NSObject
    @property (readwrite, atomic, strong) NSObject *foo;
    @end

Whereas a set accessor defines only the owning object and the new value, a `@property` declaration specifies the memory management model for the new value. Is the setter going to copy it, own it, or just assign it? With ARC, these become even more useful: You can copy it, specify that it's kept via a strong reference, specify that it's a weak, zeroing reference, or specify that it's a weak reference that could become a dangling pointer.

Further, you can specify whether the property is atomic: If two threads try to access a property at the same time, is the behaviour fully defined?

Even more useful, if your getter and setter are trivial Objective-C can synthesize them for you. (In older compilers, you needed to specify this with `@synthesize`; in the latest version, the compiler will do this for you.)

Note: If you write your own getter/setter, you're responsible for making sure it complies with the memory model and atomicity you've specified in the `@property`. The `@property` is a promise to other compilation units, and your object is not held to that promise by the compiler.

##What is dot syntax?

Dot syntax is syntactical sugar for accessing properties. Whereas the `@property` statement defines the property, dot syntax is an option for **calling** it.

Excluding dot syntax these are equivalent:

    _view1.frame = _view2.frame;
    [_view1 setFrame: [_view2 frame]];

There are some unexpected gotchas involving dot syntax. This, for instance, does not compile:

    _view1.frame.size.width = 10;

The reason is it's equivalent to this:

    [_view1 frame].size.width = 10;

You can't change a field in a rvalue like this. Instead, you need to do this:

    CGFrame frame = _view1.frame;
    frame.size.width = 10;
    _view1.frame = frame;

This shows an important distinction: dot syntax may *look* like struct access, but it isn't the same thing at all.

##Using dot syntax

In some cases the compiler will even let you get away with dot syntax for methods that aren't properties. But you really shouldn't; Objective-C isn't Visual Basic (where this is supported) and this runs counter to the language. In the past, I've seen Apple engineers argue that doing so is taking advantage of a compiler limitation that will probably eventually be fixed. Or maybe it's a compiler limitation that they'll never get around to fixing. In either case, it's taking advantage of a compiler limitation.

There's a huge grey area here. Some will argue setting a property shouldn't have side effects, shouldn't perform an action, or many things between.

Clearly, setting something without side effects is a property. I think most Objective-C developers will agree with this, though some argue that calling code at all makes dot syntax inappropriate. The argument is that it looks like struct access, so it should behave **exactly** like struct access. I don't agree with this, but some very wise people do.

By UIKit convention, visual side effects (such as changing a frame) is acceptable. Some of these are true properties, complete with a `@property` definition. Some lack the `@property` definition, as `@proeprty` predates much of UIKit but make sense as properties anyway. (I picked UIKit here because it's more modern than AppKit, but the same applies there.)

However, a method that takes no parameters but does not return a value is clearly **not** a property. Obviously, a method that takes parameters that do not conform to a getter/setter signature does not represent part of a property.

This, while legal under some configurations, is never appropriate:

    obj.release;

Dot syntax should be limited to things that are semantically properties only. Whether you further limit that to things that are only defined with `@property` is up to you. I do for my own objects, but I prefer to believe that Apple would fix UIKit's missing `@property` definitions before enforcing this at a compiler level. If I'm wrong, it'll be easy enough to remove dot syntax from the affected code. But I think it's more likely that Apple won't enforce this at the compiler level.

There are even greyer areas to this. What constitutes a property? For instance, is `NSArray`'s count a property? I would argue it isn't; it's an attribute, a side-effect based on the other properties of the `NSArray`. But Apple template code uses the count of an array as if it was a property, and the result is not horrible. You could certainly argue it's wrong, but I view it as just over the line.

##Conclusion

Embrace `@property`. The additional information it supplies regarding memory management and thread safety is great. Not only that, but it's less code than the old way of declaring your getter and setter.

Use dot syntax where appropriate. You need to decide where the line is for yourself, as there are no hard rules about this. Everyone has an opinion over it, and the only thing you can be sure of is that there's little consensus, except that some things are always inappropriate.