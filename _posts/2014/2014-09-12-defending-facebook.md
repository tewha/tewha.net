---
layout: post
tags : ["Mobile", "iOS"]
title: "Defending Facebook"
---

You know what I really hate? Defending Facebook.

CBC has a story right now on how [Facebook Messanger captures more data than you think](http://www.cbc.ca/newsblogs/yourcommunity/2014/09/facebook-messenger-found-to-be-tracking-a-lot-more-data-than-you-think.html). And thanks to how inaccurate that story is, now I have to.

## Analytics

Do you care if Facebook knows which way you hold your phone or which UI elements you use to work?

How you use the UI is useful to them in aggregate, as it helps them improve the UI if they find people taking inefficient paths, backing out of screens immediately (they probably tapped the wrong thing), etc. They can certainly tell all these things if you use the website; that's just part of how the web works. 

I'm not a fan of analytics and I wouldn't do it in my own apps. First, if you don't burst those transmissions with other data, it'll drain the battery a lot faster. Even if you do it'll drain it a bit faster. But also, unless you explicitly opt into the analytics -- and not as part of a general Terms of Service, like you probably did with Facebook -- it's skeevy.

But remember this app is replacing a website. All of this data would be sent to a website from a web browser anyway. For a company replacing a web browser, building in analytics like this probably seems an obvious choice.

## Memory representation

Zdziarski also makes a point about how credit cards are stored in memory.

Memory is memory; the iPhone never writes swap pages to disk. Everything you do on your computer is stored in memory. It's all transient, and it all goes away.

Worrying about credit cards being stored in memory is alarmist garbage. If you're worried about someone connecting a debugger to your app, stop.

## Private API

Zdziarski says that Facebook Messenger uses private API to get the name of your Wi-Fi SSD.

No, it doesn't. The Wi-Fi SSID is available as part of the public API since iOS 4. I use this on some of my networking screens to let the user know which network they're connected to, so my users can tell if two devices are on the same WiFi network. 

Holding everything else constant, "No iPhones running MyAppName found on PARKSIDE," is simply a better message than "No iPhones running MyAppName found on your Wi-Fi."

I don't have permission to share the code I use. I didn't even ask, because I found similiar code on  [stackoverflow](http://stackoverflow.com/questions/5198716/iphone-get-ssid-without-private-library/15236634#15236634). The key point here is that `CNCopyCurrentNetworkInfo` (a public API) returns a dictionary of information. The SSID is in there. It's part of Apple's public API.

## Focus

Am I saying you should trust Facebook? No, not at all. What I'm saying is that you're worrying about the wrong thing.

Who cares which route you take to delete a message? Who cares which way you hold your phone to type? You should be worried about sending the **contents** of your message through Facebook, whether you're using the website or the app.
