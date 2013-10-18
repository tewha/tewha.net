---
layout: post
tags : ["Objective-C", "Coding"]
title: "Change back button title"
---
When you're using a navigation controller, the title of the back button on a particular view controller is pulled from the view it leads to. For instance, if you start with view controller A and push view controller B, the back button's text on view controller B will be pulled from view controller A.

Think of it this way:

    thisViewController.visibleBackButtonTitle =
        previousViewController.navigationItem.backBarButtonItem.title
        ?: previousViewController.navigationItem.title
        ?: previousViewController.title;

This won't compile; `visibleBackButtonTitle` doesn't actually exist.

There are a few reasons to show custom text on the back button. The most obvious is that your title relies on user input that may be too long, and you want something simpler and more generic. This case is simple: select the parent view controller and give it a custom **Back Button** value.

You might also have the opposite problem, where your context is not visible in the navigation title because it's obvious from something else in the view controller. But you still want to leave that more specific title as a breadcrumb for the user.

This is a little more complicated. You'll need to do this at runtime: Set the `title` of the `backBarButtonItem` for the navigation item of the view controller the button leads to. That will prevent the navigation item's `title` from being used.

**But there's a wrinkle.** Let's assume you want to set the title dynamically. You might have something like this in your parent view controller, which is called by your `viewWillAppear` and whatever triggers updates of the view controller:

    - (void)loadData {
        // lots of other stuff
        self.navigationItem.backBarButtonItem.title = @"dynamic title";
    }

This probably isn't going to work for you as is.

You'll find lots of crazy solutions to this; manipulating the `backBarButtonItem` by hand and restoring it after for instance. (There are much crazier solutions.)

The key is understanding why it's not working: `backBarButtonItem` is `nil`.

To make it not `nil`, you have two options:

1. Select the navigation item in the storyboard editor and give **Back Button** a value. This value will cause the `backBarButtonItem` to be automatically created with the view controller is instantiated.
2. Create the `backBarButtonItem` at runtime in your `viewDidLoad`. I don't recommend this; it's much simpler to just put a **Back Button** value into your view controller.

Once it's created — whether in code or by storyboard — its title can be changed.
