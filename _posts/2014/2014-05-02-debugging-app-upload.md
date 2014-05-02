---
layout: post
tags : ["Objective-C", "iOS", "code-signing"]
title: "Debugging app upload"
---

I've had some recent troubles trying to upload a build in Xcode. These involved getting a really unhelpful error from Xcode: "No identities were available." Unfortunately, I was stuck there for two days.

It turns out that you can get Xcode to log more information on the handshake with the portal using these two commands:

	defaults write com.apple.dt.Xcode DVTCodesigningAllTheThingsLogLevel 3
	defaults write com.apple.dt.Xcode DeveloperPortalLogLevel 3

Then, open Console. Quit anything spewing to it, clear the display, then try to upload your build again. When you're done, select and copy the spew to Console and paste it into your favorite text editor. You're looking for `DeveloperPortal` and `DVTCodesigningAllTheThings` rows.

The results aren't exactly easy to interpret, but it does give you a better idea of what's being reported to Xcode, as opposed to what Xcode displays. Xcode is probably simplifying the error message.

When you've solved your problem, you'll probably want to turn it back off:

	defaults delete com.apple.dt.Xcode DVTCodesigningAllTheThingsLogLevel
	defaults delete com.apple.dt.Xcode DeveloperPortalLogLevel

In my case, I solved my major problem literally seconds before I learned about this logging trick: I had used a bundle ID of `com.company.product`, whereas I was now using `com.company.${PRODUCT_NAME:rfc1034identifier}`. That made the effective bundle ID of the new product `com.company.Product`, which was enough that Xcode couldn't find a corresponding application for my bundle. I don't know what that would have looked like in the log.

This logging trick did solve me with a subsequent problem, however, by letting me know it was based on permissions. As a result, I spent only seconds on that one, and my app is now waiting in Apple's review queue.

I don't know if this will help you or not, but if you're getting only a generic error message it's worth a try.
