---
layout: post
tags : ["Coding", "Software Development"]
title: "Completely impossible isn't."
---
An assertion is a check on a condition that you don't expect to ever occur. These checks slow down the program, so they're usually excluded from release builds. They're often used in functions to check the parameters, entry and exit conditions.

<!--more-->


For instance, if you have your own sorted list class ((You shouldn't. There are some great implementations of sorted lists, and thousands more poor ones. Guess which one you'll probably write?)), you might do something like <code>assert(list_in_order())</code> as an entry condition on the search  (because the list assumes it's already sorted, and this should never be untrue), and <code>assert(list_in_order())</code> as an exit condition on the insert (because the list is trying to guarantee it will always be sorted).



Many months ago I thought of a simple assertion I could put in my application. I was redesigning a UI, and it had a progress bar. I briefly thought about adding a check to catch if the progress bar ever rolled backwards. But I decided against it, because it was so obviously impossible for it to occur. The reason? I'd have to add a miniscule amount of logic to actually keep track of the last progress bar value.



Yesterday we found a bug where the progress bar in our application rolled backwards. I fixed it, checked it in, and briefly remembered the assertion idea. "I wish I'd done that," I thought to myself, "I would have found this a month ago!" I posted the next beta of the product and thought nothing more of it.



Today I found another case where the progress bar rolls backwards.



You know, that's probably all I'm going to find. But this time I've put in the assertion. And I'm turning over a new leaf: from now on, I'll really think about my entry and exit conditions and other flow assumptions, and make sure the code to verifies them. I was in that habit a few years ago in Pascal, but never really brought it over to C/C++.