---
layout: post
tags : ["Cross Platform", "qt4", "Software Development"]
title: "Qt part 1: Project configuration"
---
We develop applications for multiple platforms here. How to do this is something of a challenge; in the past, I've favored writing custom interfaces and using common business logic. To be blunt, I still think this makes a lot of sense, although in the past we've made some choices as to the various languages to write things in that turned out pretty poorly over the years.



Another developer here suggested we evaluate Qt. To make a long story short, we've placed an order and plan to use it.



<strong>Project configuration made easy.</strong>



Qt's cross platform abstraction starts with the project file. For instance, a trivial QT project file might look like this:

<blockquote class="codechunk">TEMPLATE = app

SOURCES += main.cpp</blockquote>

Type qmake on the Mac and it's converted to a Project Builder or Xcode project. I believe makefiles are supported on Mac, too, but I haven't tried that yet. Import it into Visual Studio with Qt's Visual Studio integration and it becomes a vcproj.



Want to add precompiled headers and make it a debug build?

<blockquote class="codechunk">CONFIG +=debug

PRECOMPILED_HEADER = stable.h</blockquote>

(This assumes that stable.h #includes your headers that aren't going to change.)



Run qmake again on the host platform (or import into Visual Studio), and the project file will be regenerated to use stable.h as a precompiled header and we're using debug libraries and appropriate settings.



Want a universal build on the Mac?

<blockquote class="codechunk">QMAKE_MAC_SDK = /Developer/SDKs/MacOSX10.4u.sdk

CONFIG +=x86 ppc</blockquote>

Want to build a Visual Studio project? Move over to Visual Studio 2005 and choose <strong>Open Solution from .pro File</strong>. A second later, you're looking at a Visual Studio project with the equivalent configuration.



It really is that easy. The difficulty is in finding the variable names, and that's documented on TrollTech's website.