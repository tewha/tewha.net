---
layout: post
tags : ["afnetworking", "github", "social-coding", "Software Development", "coding"]
title: "AFNetworking: a well managed open source project"
---
Last week, I talked about [Networking using NSURLConnection](/2012/06/networking-using-nsurlconnection). In a future post, I'm going to talk about how to use AFNetworking. But first, I wanted to talk about why you should trust AFNetworking as a project in your project.

I haven't been using github for long. That said, AFNetworking is the best-managed git project I've seen. It's being managed so well that I wanted to write about it. In doing so, I'm not trying to praise Mattt Thompson's efforts. It will probably come across that way, and he deserves it. Instead, I want to say that if you plan to maintain a git project, you should handle it as well as Mattt does.

## Codebase ##

AFNetworking is, ultimately, a simple library. It has only a few classes, and reuses lots of the sane bits of iOS frameworks. Its main class is `AFURLConnectionOperation`, which encapsulates a `NSURLConnection` and its delegate methods in a subclass of `NSOperation`.

Without going into the gory details of Foundation framework classes, this is how iOS networking **should** work. Of course, you could get into a lot of trouble even with the right fundamentals. But AFNetworking doesn't. It's ten source files with headers, and one header to rope it all together.

## Issues ##

As I write this, AFNetworking has 368 closed issues. 358 of them are closed. Alone, this tells you something: He responds to issues.

But if you watch how he handles issues, you'll see qualities to which all developers should aspire:

1. Patience.
2. Humility.

His responses are available to everyone, of course. I came to appreciate how well Mattt was running the project by reading these. Along the way, I learned a lot about AFNetworking.

## Pull requests ##

I have no idea what percentage of the code Mattt has written, vs. code brought in by other contributors. I can tell you that at the moment, AFNetworking has 99 pull requests total. 98 of these are closed. Whether they were merged or not, he's dealt with them.

Some of these pull requests are pretty mundane. I've landed three myself, all very small and ordinary. However, in each case Mattt not only merged the request, but thanked me for it and explained what had happened. The thanks are appreciated. The explanation isn't necessary, but gives me a better feeling of connectedness.

For the pull request that he **didn't** accept, he explained what I was doing wrong (gently and politely), and provided me with an alternative that actually worked better than the pull request I'd made.

Looking through a few pull requests, I don't see anything unusual about the way he treated me.

## Conclusion ##

Look, I'm not saying Mattt Thompson is handling AFNetworking perfectly. That'd be impossible to prove, and you could probably prove otherwise pretty quickly. But he's handling it **well**.

I'm also not going to claim the code is perfect. The library actually swizzles itself, which is one of the craziest things I've seen. But the craziness is localized to a small section of code, and minor overall.

I'm feeling connected to the project, I'm feeling confident, and I'm learning more about it. Even the bits I don't care about yet. And if that isn't a successful open source project, I'm not sure what is.