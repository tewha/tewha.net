---
layout: post
tags : ["Objective-C", "iOS", "Swift"]
title: "Learn Swift"
---

Jon Friskics suggets [Swift is great, but you should still know Objective-C first](http://venturebeat.com/2014/06/07/swift-is-great-but-you-should-still-know-objective-c-first/). [Dave Mark agrees.](http://www.loopinsight.com/2014/06/09/swift-is-great-but-you-should-still-know-objective-c-first/)

Let me give you a different opinion:

No, newbie, you don't learn Objective-C. You'll miss it from time to time and you might want to pick it up later, but it won't help you much now. And it will color your thinking in a way that might hurt your understanding.

## ARC, an admittedly imperfect analogy

Let me rewind a few years. Apple introduced Automatic Reference Counting, which let the compiler manage its own memory. To this day, people continue to suggest you learn manual release/retain (MRR) before using ARC. I used MRR for years, and it really didn't help me learn ARC. What helped me was understanding the object graph model, which was actually HIDDEN by MRR. I think knowing MRR makes it harder to learn ARC.

So should you learn MRR? No. You should learn the concepts behind good memory management on iOS — something many programmers never learned under MRR — then apply them to ARC. MRR is completely unrelated to this. Saying MRR helps is like saying **1+1 = cheese**.

To any MRR people who just read this and are shaking their heads: No, you really don't need to know it. You and I know that this chunk of code is slow because it's doing extra retains and releases, but the ARC user might instead know it's because they're assigning a strong reference. And the funny thing is that's probably a better way to think of it.

And none of this is to suggest that's not to say people it isn't helpful to learn MRR. MRR offfers a better perspective on some concepts, such as [__autoreleasing, bridge casts, precise lifetime, consumed parameters](https://alpha.app.net/jws/post/32225169). But I'm not at all convinced you need to learn MRR *first*, because I think the ARC concepts are *generally* more useful for a 5,000 foot view of what's going on.

## Swift

Just looking at it and playing for a few minutes, I think Swift is another great example of this. Swift is a teaching language that's probably more useful for day-to-day programming tasks than the language it replaces. It's also likely to be more performant than Objective-C, thanks to… well, that's another article. :)

If you're a new developer reading this, ignore Friskics's article. **Get the concepts down** and then **learn the language you're going to use**. Enjoy it. You don't have to suffer like we did. You get to start from our shoulders, and that's a good thing. Nothing prevents you from learning down as well.

In a few years I'll miss Objective-C. But primarily because I felt there was always something to learn about it, and a better way to write my code. I'm not sure if I'll still have that feeling with Swift, but that nostalgia doesn't mean Objective-C is a better language.

To address his points:

1. You can learn the frameworks in Swift just as easily as Objective-C. Apple's designed Swift to work this way, and their documentation is already ready.
2. Swift will be tried and true before you know it. This isn't something Apple started working on the Tuesday before WWDC, and it's not going final way off in 2016. Sure, Swift isn't the main language yet, but it will be by the time you're ready to ship something.
3. The learning materials and code examples are already appearing, and they're going to continue to appear.
4. Just because you can mix languages if there's a reason for it doesn't mean you have to. Sure, we Objective-C programmers mix C code in if we have to. But it's not the first thing we reach for.
