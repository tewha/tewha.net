---
layout: post
tags : [Memory]
title: "Comparing Mac Minis to PowerBooks"
---
I've been frustrated lately by slow build times on my mini. I found out why a few days ago, and have been from time to time adding a few notes to a draft article. The time has come to declare the article done...

An Xcode build on my personal PowerBook (it has 768MB of RAM), with a bunch of applications open:

<!--more-->

	VM: 5.81G +  150M   220631(1) pageins, 60523(0) pageouts

The highest number I saw there was about 200, and it appeared only once or twice. The vast majority of the build, it was 0.

An Xcode build on the Intel Mac Mini (it has 512MB of RAM), with only Finder and Xcode running:

	VM: 8.93G + 7.19M   760989(93) pageins, 277742(22) pageouts

The highest number I saw was 3,180. Usually, it hovered around 100-200, with occasional drops to 0 depending on the phase the build was in.

There's a couple obvious points here:

* The mini is doing at least one order of magnitude more swapping than the PowerBook. The total pageins don't reflect that the PowerBook has seen much heavier use since the last restart, but that's irrelevant to the recent pageins. More pageins is to expected; after all, the mini has less memory.
* The mini is using *much* more VM to accomplish less than the PowerBook. This I didn't expect. The PowerBook is running more applications and is even using a FileVault-encrypted home directory. The mini, on the other hand, is as bare as I could get it without wasting time on it.