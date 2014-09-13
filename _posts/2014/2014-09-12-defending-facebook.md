---
layout: post
tags : ["Mobile", "iOS", "privacy"]
title: "Defending Facebook"
---

You know what I really hate? Defending Facebook.

CBC has a story right now on how [Facebook Messanger captures more data than you think](http://www.cbc.ca/newsblogs/yourcommunity/2014/09/facebook-messenger-found-to-be-tracking-a-lot-more-data-than-you-think.html). And thanks to how inaccurate that story is, now I have to.

## Analytics

Do you care if Facebook knows which way you hold your phone or which UI elements you use to work?

How you use the UI is useful to them in aggregate, as it helps them improve the UI if they find people taking inefficient paths, backing out of screens immediately (they probably tapped the wrong thing), etc. They can certainly tell all these things if you use the website; that's just part of how the web works. 

I'm not a fan of analytics and I wouldn't do it in my own apps. First, if you don't burst those transmissions with other data, it'll drain the battery a lot faster. Even if you do it'll drain it a bit faster. But also, unless you explicitly opt into the analytics -- and not as part of a general Terms of Service, like you probably did with Facebook -- it's skeevy.

But remember this app is replacing a website. All of this data would be sent to a website from a web browser anyway. For a company replacing a web browser, building in analytics like this probably seems an obvious choice. Certainly, if you think going back to using the website will save you from Facebook knowing how if you opened this menu here or how you to delete a message you're wrong.

Going back to my question: Does it matter if Facebook knows which way you hold the phone when you type, to use one of the examples from the CBC article? No, of course not.

## Memory representation

Zdziarski also makes a point about how credit cards are stored in memory.

Memory is memory; the iPhone never writes swap pages to disk. Everything you do on your computer is stored in memory. It's all transient, and it all goes away.

Worrying about credit cards being stored in memory is alarmist garbage. If you're worried about someone connecting a debugger to your app, stop.

## Private API

Zdziarski says that Facebook Messenger uses private API to get the name of your Wi-Fi SSD.

No, it doesn't. The Wi-Fi SSID is available as part of the public API since iOS 4. I use this on some of my networking screens to let the user know which network they're connected to, so my users can tell if two devices are on the same WiFi network. 

Holding everything else constant, "No iPhones running MyAppName found on PARKSIDE," is simply a better message than "No iPhones running MyAppName found on your Wi-Fi."

I don't have permission to share the code I use. I didn't even ask, because I found similiar code on  [stackoverflow](http://stackoverflow.com/questions/5198716/iphone-get-ssid-without-private-library/15236634#15236634). The key point here is that `CNCopyCurrentNetworkInfo` (a public API) returns a dictionary of information. The SSID is in there. It's part of Apple's public API.

## We're all focusing on the wrong thing

While we're raging about Facebook collecting too much data here because they know which way you're phone is facing, how they store data in memory, or that they know the name of your SSID we're missing the obvious.

Has Facebook built a system where your messages are really secure, not just from *hackers* but from *them*? No.

You should be worried about sending the **contents** of your message through Facebook, whether you're using the website or the app. Are they going to look at it? Probably not. Could they if they wanted to? Absolutely. Will they if it's part of a broad data collection warrant? Yes, of course.
