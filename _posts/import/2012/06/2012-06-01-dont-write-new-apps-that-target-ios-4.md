---
layout: post
tags : ["compatibility", "ios", "iOS 5", "iPhone", "Software Development"]
title: "Don't write new apps that target iOS 4"
---
So you're writing your first iPhone app. Welcome! But which version of iOS should you target?

This is pretty simple. There's very little reason not to write for iOS 5.0.

## Market share ##

According to [iOS 5 penetration percentage](http://www.game4mob.com/index.php/tech-articles/67-ios-5-penetration-percentage), iOS 5 has more than 80% of the market at this point. This is only covering one developer's apps, but it's cool nonetheless because the data is updated daily.

A bigger sample has been analyzed in [iOS Ebb and Flow](http://pxldot.com/post/18754186750/ios-ebb-and-flow). This article says that across multiple developers' apps iOS 5 had captured 76% of all iOS users by March 1, 2012.

## Technology ##

As big a release as iOS 5 was for users, it was even bigger for developers. You're going to want to use some of Apple's new technologies.

If you try to target anything older, there's a couple major features you'll be unable to use *at all*:

* **Automatic Reference Counting with weak references.** Instead of writing memory management code, you describe the relationship between objects and the compiler writes the memory management code for you. On iOS 4, you can get Automatic Reference Counting without support for weak references. But ARC and weak references are a **huge** deal; see [Automatic Reference Counting](/2012/05/automatic-reference-counting/) for more.
* **Storyboards.** Storyboards aren't available on iOS 4. Storyboards mean that instead of creating each screen's layout in its xib and writing code to connect them, you define a single storyboard defines all your screens and even strings them together. You'll still need to write code, of course, but the code will be less concerned with the minutiae of transitioning between screens.

There's several more features you can take advantage of iOS 5. Unlike the above list, you can build these into an iOS 4 project, but you'll need to be careful not to try to use them on iOS 4:

* iCloud
* Twitter integration
* Notification center
* Enhanced AirPlay
* Enhanced Core Image

## Hardware ##

You'll have a much harder time finding devices to test on. It isn't enough to target iOS 4, test on iOS 5, and declare it'll work on iOS 4. It probably won't without some fixes.

Remember, also, that iPhones cannot be downgraded to a previous version of iOS. If it ships with iOS 5 or you ever accidentally update it, it's an iOS 5-only device.

But what about hardware support? Who can't run iOS 5?

Well, every iPhone since the 3GS can be upgraded to iOS 5. The newest iPhone that can't run iOS 5 was discontinued in June 2010. Apple hasn't released a software update to it since November 2010. It not only doesn't run iOS 5, but doesn't run the latest version of iOS 4. Even if a person bought that phone on its last days on a two year contract, that contract will be up before you finish your app.

Finally, you'll get to skip supporting the armv6 CPU architecture. Apple's had some significant armv6 code generation bugs. While at the moment they're still trying, how long will they continue to try?

Apple doesn't ship armv6 devices anymore, and the effort to keep the armv6 code generation working seems significant. Each time they slip up, someone gets embarrassed. I can't imagine they'll continue to support armv6 code generation for long.

## Over The Air ##

Now that I've convinced you to target iOS 5, let me suggest you target only the latest version of iOS, currently 5.1.1. The comments above about not being to downgrade a device from iOS 5 to iOS 4 also apply on downgrading from iOS 5.1.1 to iOS 5.0.

I think you'd probably be on much more solid ground developing for 5.1.1 and allowing operation on 5.0, but if you ever find a bug that occurs only on iOS 5.0 you're probably not going to be able to recreate it.

Meanwhile, updating from iOS 5.0 to 5.1.1 is just a simple, small over the air update away, and is supported by every device running iOS 5.0. It turns out that [users upgrade fast](http://david-smith.org/blog/2012/05/11/ios-5-dot-1-1-upgrade-stats/index.html).

## Conclusion ##

If you try to support iOS 4 you are giving up a lot of OS features, and going against the grain of Apple's tool development, just to chase an ever-shrinking (in both real and percentage terms) market of users who are less likely to be interested in new software.

Are you *nuts*?