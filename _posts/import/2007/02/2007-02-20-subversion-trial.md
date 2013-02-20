---
layout: post
tags : ["cvs", "Perforce", "Impressions", "Software Development", "svn"]
title: "Subversion trial"
---
As a long time user of [Perforce][1] and a moderately experienced [CVS][2] user, I was glad to hear that our company was considering [Subversion][3]. I was even more happy to be part of the in-house trial of it.

[1]: http://www.perforce.com
[2]: http://www.nongnu.org/cvs/
[3]: http://subversion.tigris.org/

<!--more-->

## High expectations ##

I'd heard from various sources that Subversion was like cvs, but without the suck. I'd heard it compared favorably to Perforce; certainly, it had features I missed from Perforce that cvs just didn't deliver (notably, I missed atomic commits and, hence, easy updating to a specific version). Subversion's home page claims "Subversion's interface to a particular feature is similar to CVS's, except where there's a compelling reason to do otherwise."

## Initial thoughts on Subversion ##

I wasn't involved in the server side setup of the repository, so I can't talk about that. I can, however, talk about the import. It was indeed an experience a lot like CVS, but without the suck. I removed my temporary files, did the `svn import`, and went from there. Painless and completely like CVS, really.

## All new suck ##

Almost immediately, I ran into problems. In fact, my very first Subversion operation was to add some files to source control.

Remember above, where I quoted the Subversion web page? It turns out their idea of compelling is different than any other rational human being.

Every CVS command has a two character equivalent. As a heavy keyboard user, I've grown really accustomed to this. This is not true of Subversion. In fact, some of the CVS command aliases aren't supported in Subversion. If this sounds like I'm whining, sure, maybe I am a little. When an experience is promised, it should be delivered. If Subversion really isn't going to support CVS commands in the interest of [keeping their command namespace clean][4], they've clearly deviated from their goal. Sure, one character savings isn't much. But when users need to edit a submitted command to fix it, and request the command alias over and over again, we have a larger problem. The fingers have knowledge; denying that knowledge for so little reason is foolish.

[4]: http://svn.haxx.se/dev/archive-2006-10/0095.shtml

## CVS suck removed ##

I hate deep trees. Our root directory for our repository was `/home/subversion/productname` However, because of Subversion's branch style, my source ended up in `/home/subversion/productname/trunk/projectname`. Ugly, but not that big a problem. Instead of checking out `/home/subversion`, it turns out I can check out `/home/subversion/productname/trunk/projectname`. The difference between module names and directories was a big part of CVS's suck, so it's great to see this part of the suck removed.

As I mentioned above, Subversion commits are atomic. It wasn't long before my code was not running correctly on Mac vs. Windows. `svn up -r` to the rescue. Because the entire repository shares a a single version number, doing a binary search for the change that broke the code was really easy. The code worked in v1 and didn't in v15, and a few minutes later I determined that the break was v8.

Another mistake I made was not thinking through my directory structure in advance. But that's okay, since Subversion supports a move command. Oddly enough, the move command does not support wildcards, but I was able to work around that fairly easily. There's always a work around for the Unix shell, but the lack of wildcard support for mv is mildly confusing.

[Subversion's ignore list is directory specific][ignore]. This let me add masks that covered all of Qt's temporary files easily, without worrying about them impacting other things in the repository. More on Qt later.

[ignore]: http://svnbook.red-bean.com/en/1.1/ch07s02.html#svn-ch-7-sect-2.3.3

## Overall picture ##

The bottom line is that Subversion is indeed an improvement over CVS. The lack of two character command aliases is frustrating, and it means the fingers of many CVS users will need to relearn how to do various functions. Worse, the commands are close enough that this will take a while.

The attitude towards this deficiency is even more disturbing. An oversight is one thing, but choosing to break user habits for no good reason is something else entirely. You could argue that it's open source, and I could just fix this myself, and you'd even be right. However, I fail to see a good reason why compatibility with CVS commands should require a custom build. Still, sooner or later I'll probably go this route.

It's less clear of a win over Perforce. The Subversion command line interface is better, but so far none of the GUIs are as good as Perforce's p4v. However, considering Perforce costs $800 US per user, I'm willing to put up with a less capable GUI client. Also, there are already some GUI clients appearing. I don't need to forever put up with what a single vendor offers as I did with Perforce. I'll cover the GUI clients later, too.