---
layout: post
tags : ["Cocoa Touch", "Software Development"]
title: "Coding tips for new iPhone developers from a new iPhone developer"
---
If any of these seem wrong, please comment!

* The Objective-C syntax is strange. It's really not that hard, though, especially once you realize that part of the reason for the design was to make Objective-C a strict superset of C. That means that the C code you throw at it will compile and means the same thing under C as Objective-C.

* Use <code>NULL</code> for pointers (<code>void*</code>) and <code>nil</code> for instances (<code>NSObject*</code>). They're defined the same, this is just convention.

* Use properties and stay sane. You can leave the dot syntax alone if you like (though I like it), but it's worth using properties anyway because it forces you to document the assignment mechanism you're using.

* Method names that return an object where the name does not contain <code>init</code> must not require the object be released.

* If you're writing the object, this means you're probably calling <code>retain</code> and <code>autorelease</code>.

* If you're using the object, this means it is probably already calling <code>autorelease</code>. If you release the instance yourself, you'll crash later.

* Use <code>alloc</code>, <code>init</code> on the same line.

* If you're going to <code>autorelease</code> an object, do it at immediately on creation rather than later: <code>[[[Object alloc] init] autorelease]</code>.

* Sure, you can avoid using <code>autorelease</code>. Sure, it would perform "better". But can you quantify "better"? Is it significant to you? If it isn't, stick with using <code>autorelease</code>. When you follow the rules, you idiotproof yourself. See the probably in the previous group of points? Stick with the rules and it's basically an "always."

* Remember that debugging is harder than writing code. While you can write something like <code>textView.text = [NSString stringWithFormat:@"%@: %d", [b field:@"test"], [a precision]];</code> you are going to have to debug it later. In most cases, you'll benefit from assigning results to temporary variables before passing them through to Cocoa.

I'm going to write about the major device vs. simulator differences I've noticed another time, but there's one worth mentioning now: <code>CGSize size = [string sizeWithFont:font]</code> with a nil string will return a zero point on the desktop, but will return a random value (stack, maybe?) on the device itself. Check for nil first, as in <code>CGSize size = string ? [string sizeWithFont:font] : CGSizeZero</code>.