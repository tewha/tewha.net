---
layout: post
tags : ["Apple", "dts", "Software Development", "tech-support"]
title: "ADC incidents"
---
In the past, I've tried to avoid using ADC incidents. You get two a year per program, and most years I've avoided using any. This year, I decided to use them both the iOS ones up before renewing.

The first one was clarification on how to fix a bug demonstrated by some Apple sample code. I got a response, but it wasn't especially satisfying. But that's okay, because in the end I found a way to do a different UI and avoid the bug entirely. Let's call it a draw.

The second one, however, was a mistake in how I was using UIKit that I didn't realize was a mistake. I boiled it down to a [test case][test-case] and submitted the project to Apple. As part of solving the incident, Apple not only explained what I was doing wrong, but provided snippets of code that would work.

This would be gold, but they also fully corrected my code the code I'd sent.

Of course, when I tried to integrate the solution back into my real application, I ran into other problems. However, the explanation Apple had offered me was enough that I was able to solve those other problems, too.

Basically, I got a fantastic code review out of that DTS incident by someone who clearly knows iOS and UIKit better than I ever will. Total win.

I don't plan on wasting these in the future, but neither will I horde them in case of emergency. They're worth using for the really nasty problems, and they're not incredibly expensive to replace — $99 buys another two incidents.

[test-case]: https://github.com/tewha/ExtraGridLines