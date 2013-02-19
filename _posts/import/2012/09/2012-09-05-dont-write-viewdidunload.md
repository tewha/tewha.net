---
layout: post
tags : ["objc-arc", "iOS Development", "memory-management"]
title: "Don't write viewDidUnload"
---
A lot of people misunderstand the point of `viewDidUnload`. That's because despite the name that implies otherwise, it is **not** the counterpart of `viewDidLoad`.

You should **never** consider a deallocation in `viewDidUnload` a proper balance for an allocation in `viewDidLoad`. In fact, you should probably shouldn't write a `viewDidUnload`.

## Make your outlets unload automatically ##

The idea behind `viewDidUnload` is that the view is being unloaded out from behind your view controller. This gives you a chance to detach any pointers to it and clear any information you can rebuild easily. Your view will *probably* be loaded back in, at which point you'll need to rebuild any caches. Apple describes this in [UIViewController Class Reference][viewDidUnload]:

> When a low-memory condition occurs and the current view controller’s views are not needed, the system may opt to remove those views from memory. This method is called after the view controller’s view has been released and is your chance to perform any final cleanup. If your view controller stores separate references to the view or its subviews, you should use this method to release those references. You can also use this method to remove references to any objects that you created to support the view but that are no longer needed now that the view is gone. You should not use this method to release user data or any other information that cannot be easily recreated.

This was mostly about handling [dangling pointers][dangle] before Automatic Reference Counting (ARC). But now that you're [using ARC][useARC] and zeroing weak references, the dangling pointers will be cleaned up automatically. No need to write a `viewDidUnload`!

Generally, the stuff people put in `viewDidUnload` is better handled in `viewDidDisappear` or `dealloc`. The only thing left for `viewDidUnload` is nilling any of **your** caches that can be rebuilt without data loss while the view controller is still open, when needed at some point after the view has been reloaded. Really, these caches should be handled in `didReceiveMemoryWarning` instead.

## Clearing out caches ##

Clearing out cached information fits better into `didReceiveMemoryWarning`, so you should write it instead. Apple describes didReceiveMemoryWarning in [UIViewController Class Reference][didReceiveMemoryWarning], too:

> You can override this method to release any additional memory used by your view controller. If you do, your implementation of this method must call the super implementation at some point to allow the view controller to release its view. If your view controller holds references to views in the view hierarchy, you should release those references in the `viewDidUnload` method instead.

Not only does writing your cache purging in 	`didReceiveMemoryWarning` better suit the documentation, but you'll be less confused when you read `didReceiveMemoryWarning` in your code than `viewDidUnload`.

I'm not taking a ridiculous position here, either. `viewDidUnload` is deprecated with iOS 6.

## Summary ##

1. Use ARC.
2. Use weak references for `IBOutlets` that are part of the view hierarchy. They'll automatically be zeroed when the view is unloaded.
3. Use `didReceiveMemoryWarning` to dispose of anything you can rebuild easily, by (for example) removing all objects from a `NSDictionary`. Or, better yet, use `NSCache` where this behaviour is automatic.
4. Use `dealloc` to dispose of any external resources that ARC will handle automatically.
5. Don't even write a `viewDidUnload`, unless you're observing values of outlets with KVO.

If you're still using Manual Release Retain, none of this applies. You should use retained outlets instead. It's better to potentially use memory a little too long than to have a dangling pointer. And you should really think about climbing that fence and joining us on the Automatic Reference Counting side. Unbelievably, the grass is just as green here as it looks.

[viewDidUnload]: http://developer.apple.com/library/ios/documentation/uikit/reference/UIViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40006926-CH3-SW36
[didReceiveMemoryWarning]: http://developer.apple.com/library/ios/documentation/uikit/reference/UIViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40006926-CH3-SW4
[dangle]: http://en.wikipedia.org/wiki/Dangling_pointer
[useARC]: [/2012/05/automatic-reference-counting/]