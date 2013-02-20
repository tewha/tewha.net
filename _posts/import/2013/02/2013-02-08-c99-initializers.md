---
layout: post
tags : ["c99", "Coding"]
title: "C99 initializers"
---
You probably know `CGRectMake`, but did you know it's not the only way to make rectangles? It's not even the best way, really.

There's also [C99 initializer syntax][1].

The main advantage to the C99 syntax is that it gives you some very Objective-C like syntax, where the fields are close to the values rather than implied by positioning. (That's not to say this is intentionally similar, or that it's the only advantage. But it is nice.) It also provides type checking, and since fields are named it catches drifts in meaning that you otherwise wouldn't catch.

It's sometimes slightly *more* typing, but I use it everywhere now.

## The syntax ##

Consider the `CGRectMake` way to make a rectangle:

    CGRect a = CGRectMake(a+c/2, b+d/2, c, d);

In order to understand this, you need to understand the order of the parameters. You also need to be able to catch the commas easily with your eyes. In this case, that's pretty easy, but if the expressions were more complicated you'd probably be storing them in a temporary variable first.

The C99 way:

    CGRect a = (CGRect){
        .origin.x = a+c/2,
        .origin.y = b+d/2,
        .size.width = c,
        .size.height = d
    };

It's longer, but it's more explicit. It's also very easy to follow what is assigned to what, no matter how long the expression are. It's also more like an Objective-C method. After all, if `CGRect` was a class, it would probably look like this:

    CGRect a = [[CGRect alloc] initWithOriginX:x originY:y width:w height:h];

Note that any field you don't explicitly initialize is initialized to zero. This code, for instance, will create a rectangle with an `origin` of 0,0.

    CGRect smallRect = (CGRect){
        .size = mySize
    }

The C99 syntax is a nice compromise; it's more compact than class construction, but still names field values.

## Catching changes ##

Naming fields might seem like extra work, but it's also extra safety. If the names or meanings of the parameters change, you're going to get compiler errors. The compiler will help you find these, now! And if you write new code based on the old rules, compiler errors will point out what you've done.

This isn't much of a concern for `CGRect`; it is how it is. Apple is probably never going to redefine it. But many years ago, QuickDraw used edges for its `Rect` structure instead of points. If you were still trying to break that habit, the compiler would complain every time you did this:

    CGRect a = (CGRect){
        .left = 0,
        .right = 100,
        .top = 0,
        .bottom = 100
    };

In your own code, this may be an active concern to you. You may have `structs` (or use C libraries that have `structs`) that will change layout in the future.

## Type checking ##

That's only the start of C99 initializer coolness, though.

You can also do things like this:

    CGRect a = (CGRect){
        .origin = myOrigin,
        .size = computedSize
    };

Here, you're building a rectangle using a `CGPoint` and `CGSize`. The compiler understands that `.origin` expects a `CGPoint`, and `.size` expects a `CGSize`. You've provided that. All's gravy.

The equivalent code would be `CGRectMake(myOrigin.x, myOrigin.y, size.width, size.height)`. By using `CGRectMake` you're no longer expressing the same kind of meaning to the compiler. It can't stop you from assigning part of the size to the origin. It also won't stop you from assigning the width to the height. It doesn't even give you a good clue about which is the X and Y; if you've used APIs that provide vertical coordinates first, you'll get it wrong. If you're used to APIs that provide two points or something else (like QuickDraw's edges) instead of a point and size you'll also get a compiler error.

You can assign part from a structure and part from floats as well:

    CGRect a = (CGRect){
        .origin = myOrigin,
        .size.width = c,
        .size.height = d
    };

## Drawbacks ##

As I said, this is more typing than `CGRectMake`. What I didn't say is that it's even more typing than you expect, because as of Xcode 4.6, you still can't autocomplete the field names. You really do need to type all that extra code.

I think this is a good pay off for being able to read the code so easily later, but you may disagree.

## Conclusion ##

The `CGRectMake` function predates C99. I have no evidence to this effect, but I think if C99 had come first `CGRectMake` probably wouldn't exist at all; it's the sort of crusty function you write when your language has no direct way to perform the initialization. But now it does.

This doesn't only apply to `CGRect`. Any of the simple `struct` types can be initialized this way, such as `CGPoint`, `CGSize` and `NSRange`.

Avantages:

- **Explicit**: You've named the parameters.
- **Type safe**: You've provided enough meaning to the compiler that it can *help you not screw up*.
- **Easy to read**: Especially with longer expressions, you've eliminated needing to scan for commas when you read the code later.

Disadvantages:

- **More typing**: You read code a lot more than you type it, so I think this is a great tradeoff.

Averaged over time, anything you can screw up you eventually will. Using defensive techniques makes sense. Try it for a while; I think you'll like it!

Special thanks to:

- [Peter Hosey][boredzo] for reminding me how QuickDraw worked and inspiring "Catching changes."
- [Luke Bernardi][luka_bernardi] for reminding me that Xcode's autocompletion can't suggest field names.
- [BJ Homer][bjhomer] for tipping me that unnamed fields are initialized to 0.

  [1]: http://publib.boulder.ibm.com/infocenter/lnxpcomp/v8v101/index.jsp?topic=%2Fcom.ibm.xlcpp8l.doc%2Flanguage%2Fref%2Fstrin.htm
  [boredzo]: https://twitter.com/boredzo
  [luka_bernardi]: https://twitter.com/luka_bernardi
  [bjhomer]: https://twitter.com/bjhomer