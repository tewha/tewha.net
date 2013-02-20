---
layout: post
tags : ["Snapshots", "Xcode", "Coding"]
title: "I've changed my mind about Xcode snapshots"
---
In the recent past, [I've mocked Xcode's snapshots][1]. They were sluggish and not especially reliable. I'd like to say they were inefficient, too, but the truth is that they were so slow and so unreliable I never bothered to find out.

[1]: /2011/09/an-imaginary-conversation-with-xcode-4-regarding-snapshots

Recent versions of Xcode have been a lot better. I'm not sure when archives really improved, but in the most recent build of Xcode archive takes only a split second. So far, they seem reliable. And they work by storing the source in a private `git` repository, so they're pretty efficient, too. This does **not** affect your real `git` repository, even if you're using `git`. This is entirely separate, deep in Xcode's private directory tree deep in your home folder.

Xcode can run a behaviour when a build succeeds. You can customize the behaviour in Xcode's Preferences. I noticed a few days ago that there's also an option to **Create snapshot**.

![Create snapshot](/images/Create-snapshot.png)

You may need to scroll down to see the **Create snapshot** option.

This means that every time my project builds successfully, a snapshot is created. The snapshots are small, basically containing only the changes since the last build. I expect I can leave this on basically forever without running out of disk space.

I commit to `git` many times during the course of the day, but occasionally I'll be in a refactor and I won't be committing every time the project builds. I'll make a few changes, build and fix any errors, make a few more changes. I'll keep this up several times, until I've made the full refactor I want. Only then will I fully test what I've done and commit.

Sometimes I'll make the wrong change, and break the build in ways I can't easily fix. At that point, I either need to struggle my way out of the errors I've introduced or abandon all the changes I've made. Yes, I could commit to `git` every time. But the smaller each individual change is, the less likely I am to bother.

In my defence, I still think the way Xcode uses snapshots by default is useless. They're offered before major but atomic changes, which is right after I've committed to my source control repository manually.

But these continuous snapshots are another matter. This means I can back out of any particular change back to the previous working code without losing all the changes so far in what I consider the full, atomic refactor.

I'm thrilled this feature exists, and I'll be using it from now on. I think you should give it a try, too. Even if you commit to your source control system constantly, this will make commits you won't think to, and without any action on your part.