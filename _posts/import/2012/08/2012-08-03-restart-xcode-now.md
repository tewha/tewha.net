---
layout: post
tags : ["Automator", "Software Development", "Xcode"]
title: "Restart Xcode now"
---
If you're a heavy user of Xcode, you've probably had it go sideways on you. Thankfully, the crashes that plagued previous versions are mostly gone. But in its place are some awkward debugger connection failures, long delays and such.

Here's how I created a shortcut key to relaunch Xcode.

You may find [Programmer's KillSwitch][killswitch] more practical.

## Automator ##

Mac OS X includes a service called Automator, that can be used to build workflows. These are like AppleScripts, but less like code and more like macros.

Start with an Application workflow, and drag a Shell Script action to it. Use this code:

    pkill -9 -x Xcode
    sleep 0.3

Depending on how fast your Mac is, you may need to increase the sleep value. If Xcode doesn't always return, increase it.

Next, drag a Launch Application action. Pick Xcode.

![Relaunch Workflow](/wp-content/uploads/2012/08/Screen-Shot-2012-08-03-at-4.18.23-PM.png)

*In this workflow, I also remove the DerivedData directory.*

Save, and you have an application you can run at any time to kill and relaunch Xcode.

This is a great start, but now let's make it even easier.

## FastScripts ##

Red Sweater Software has a great utility we can use called [FastScripts][1]. FastScripts adds a menu to the right of the menu bar, and can launch scripts and other useful things from selecting them in the menu or a keyboard shortcut.

Copy the application you built to FastScript's folder, then set it to a keyboard command shortcut. I use command-control-delete, which feels like ctrl-alt-del. Very satisfying to hit ctrl-alt-del whenever Xcode starts to act up!

## Other possibilities ##

This combination of shell scripting + FastScripts is great for frequent but annoying tasks. I have shell scripts to `purge` cached memory, and another Xcode restart workflow that clears Xcode's derived data.

With a few scripts and keyboard shortcuts, you can make Xcode bow to your whim, rather than the other way around.

[killswitch]: https://github.com/boredzo/programmers-killswitch
[1]: http://www.red-sweater.com/fastscripts/