---
layout: post
tags : ["Objective-C", "iOS", "Swift"]
title: "Learn Swift"
---

Jon Friskics suggets [Swift is great, but you should still know Objective-C first](http://venturebeat.com/2014/06/07/swift-is-great-but-you-should-still-know-objective-c-first/). [Dave Mark agrees.](http://www.loopinsight.com/2014/06/09/swift-is-great-but-you-should-still-know-objective-c-first/)

Let me give you a different opinion:

No, newbie, you don't learn Objective-C. You'll miss it from time to time and you might want to pick it up later, but it won't help you much now. And it might hurt you.

People continue to suggest you learn manual release/retain (MRR) before using automatic reference counting (ARC). I used MRR for years, and it really didn't help me learn ARC. What helped me was understanding the object graph model, which was actually HIDDEN by MRR. I think knowing MRR makes it harder to learn ARC.

Just looking at it and playing for a few minutes, I think Swift is another great example of this. Swift is a teaching language that's actually more useful for day-to-day programming tasks than the language it replaces. It's also likely to be more performant than Objective-C, thanks to… well, that's another article. :)

If you're a new developer reading this, ignore Friskics's article. Get the concepts down and learn the language you're going to actually use. Enjoy it. You don't have to suffer like we did.

To address his points:

1. You can learn the frameworks in Swift just as easily as Objective-C. Apple's designed Swift to work this way, and their documentation is already ready.
2. Swift will be tried and true before you know it. This isn't something Apple started working on the Tuesday before WWDC, and it's not going final way off in 2016. Sure, Swift isn't the main language yet, but it will be by the time you're ready to ship something.
3. The learning materials and code examples are already appearing, and they're going to continue to appear.
4. Just because you can mix languages if there's a reason for it doesn't mean you have to. Sure, we Objective-C programmers mix C code in if we have to. But it's not the first thing we reach for.
