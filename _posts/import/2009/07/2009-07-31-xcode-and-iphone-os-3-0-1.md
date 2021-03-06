---
layout: post
tags : ["iOS", "Software Development", "Xcode"]
title: "Xcode and iPhone OS 3.0.1"
---
To get Xcode 3.1.3 working with iPhone OS 3.0.1, you'll need to teach Xcode how to target iPhone OS 3.0.1.


Xcode will automatically recognize iPhone OS 3.0.1 and look for a new SDK at a set path. The problem is that SDK doesn't exist. The good part is that the iPhone OS 3.0 SDK works perfectly for developing 3.0.1. The only apparent change is the SMS fix.

<!--more-->

Assuming you've installed to /Developer, the iPhone OS 3.0 SDK is here:

    /Developer/Platforms/iPhoneOS.platform/DeviceSupport/3.0 (7A341)

When using Xcode with iPhone OS 3.0.1, Xcode looks for the iPhone OS 3.0.1 SDK here:

    /Developer/Platforms/iPhoneOS.platform/DeviceSupport/3.0.1</code>

The trick, then, is to build a symbolic link that connects what Xcode is looking for with what it needs to find.

So what do you do? Assuming you've installed Xcode in the standard location, this is a Terminal command to fix the problem:

    ln -s /Developer/Platforms/iPhoneOS.platform/DeviceSupport\
    /3.0\ \(7A341\) /Developer/Platforms/iPhoneOS.platform/\
    DeviceSupport/3.0.1

This will not add a SDK to Xcode's list, it will just teach Xcode to map your device to the 3.0 SDK.

A few other tips:

* If you still can't debug restarting your iPhone may help. Most of the iPhones I've tried to debug on, I've had to restart first.
* If you get an error regarding code signing, try downloading your provisioning profile again and re-installing it. Also, select it again in your build settings.

Based on information from [iPhone OS 3.0.1 Advisory][1].

[1]: http://developer.apple.com/iphone/download.action?path=/iphone/iphone_sdk_3.0__final/iphone_os_3.0.1_advisory.pdf
