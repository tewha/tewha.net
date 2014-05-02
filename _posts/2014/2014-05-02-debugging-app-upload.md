---
layout: post
tags : ["Objective-C", "iOS"]
title: "Debugging app upload"
---

I've had some recent troubles trying to upload a build in Xcode. These involved getting a really unhelpful error from Xcode: "No identities were available." Unfortunately, I was stuck there for two days.

It turns out that you can get Xcode to log more information on the handshake with the portal using these two commands:

	defaults write com.apple.dt.Xcode DVTCodesigningAllTheThingsLogLevel 3
	defaults write com.apple.dt.Xcode DeveloperPortalLogLevel 3

Then, open Console. Quit anything spewing to it, clear the display, then try to upload your build again. When you're done, select and copy the spew to Console and paste it into your favorite text editor.

The results aren't exactly easy to interpret, but they are a great deal more detailed than the unhelpful error message Xcode delivers.

When you've solved your problem, you'll probably want to turn it back off:

	defaults delete com.apple.dt.Xcode DVTCodesigningAllTheThingsLogLevel
	defaults delete com.apple.dt.Xcode DeveloperPortalLogLevel

In my case, the problem was my previous project had used a bundle ID of `com.company.product`, whereas my new product was using `com.company.${PRODUCT_NAME:rfc1034identifier}`. That made the effective bundle ID of the new product `com.company.Product`, which was enough that Xcode couldn't find a corresponding application for my bundle.
