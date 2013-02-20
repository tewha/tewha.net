---
layout: post
tags : ["Software Development", "Windows"]
title: "Windows Installers made... less painful"
---
Let's face it, deploying an application on Windows is never fun. We've been using WiX, which is about as unfun as one can possibly get. I actually think the exact number is slightly higher than this, but I've gotten used to saying "1,200 lines of XML to install 7 files." Not a big deal, until you have several components needing separate installers.

Adding XML to a problem means you have two problems: The original problem, plus XML.

<!--more-->

Visual Studio 2005 has a much better installer system built into it, though, called Windows Setup.

The first few times I tried it, I quickly moved on because it popped up a installer dialog. It turns out I just needed more patience: After several minutes of waiting, it asked for the Visual Studio CD and installed the components it needed. And that was that. The installer popping up to build an installer wasn't a daily stupidity, just a one-time thing.

The tool is (comparatively) a joy to use, using Visual Studio editors and the property inspectors. Better, it deals with dependencies in a way that only someone with direct access to the idiot that designed the system could manage. I still don't fully understand what the installer is doing, but I find that I don't really care: It works, and works well. I can't imagine going back to WiX at this point.