---
layout: post
tags : ["iPhone", "iOS", "Software Development"]
title: "One App At a Time... Always?"
---
Gruber at Daring Fireball [writes about the restriction][1] of one application at a time on the iPhone. Read it before you go on.

Writing a background task for Touch OS X would be very, very hard. Well, actually, not so much hard as taking a lot of skill, time and effort. I can really understand why Apple wouldn't want just anyone doing it. But before I get too stressed over it, it's worth asking a few questions:

<!--more-->

First, what kind of program does this actually affect? Not many, probably. In fact, basically, polling network software or network software that receives pushes is the most common scenario. ((Time-based software is also a possibility, but let's discard that for the moment.)) An instant messenger program is an obvious example; it needs to keep the connection alive and plays some sort of beep when a message comes in.

So we've established a program this affects. Now it's worth asking a second question: Is it possible this rule is up for negotiation? At the right price, would it go away? And if so, what might the right price be?

* An application that background operation is critical to.
* An application that Apple thinks is important enough to be worth the resources on the iPhone and the effort. Because make no mistake, it's going to take effort from Apple.
* Doing the work on campus with an Apple engineer's help.
* Payment for the engineer, possibly to be waived in some cases.

In short, if I was to write a program that beeped on the hour, I probably wouldn't get an exception. I wouldn't even know who to ask. But AOL Instant Messenger? That might happen. AOL might not even have to ask. (Although I doubt they have anything running in the background at this point. For the purposes of a prototype/demo, a simple, customized back end would make more sense.)

As developers we need to worry more about **we** are going to do, than what someone like AOL is going to do.

[1]: http://daringfireball.net/2008/03/one_app_at_a_time
