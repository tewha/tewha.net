---
layout: post
tags : ["Objective-C", "Coding"]
title: "Change back button title"
---
When you're using a navigation controller, the title of the back button on a particular view controller is pulled from the view it leads to.

Although this can be initially confusing, this actually makes a lot of sense. If two different view controllers (say, Circles and Squares) might push the same view controller (Details), shouldn't the text in the top left of that view controller depend on which controller pushed it (Circles or Squares)?

Think of it this way:

    thisViewController.visibleBackButtonTitle =
        previousViewController.navigationItem.backBarButtonItem.title
        ?: previousViewController.navigationItem.title
        ?: previousViewController.title;

This won't compile; `visibleBackButtonTitle` doesn't actually exist.

There are a few reasons to show custom text on the back button.

## More generic

The most obvious reason is that your title relies on user input that may be too long, and you want something simpler and more generic.

This might be the case if the user taps an event. The title in the navigation controller should be the event's title, but you might want to use something shorter like Event on the back button.

This case is simple: select the parent view controller and give it a custom **Back Button** value.

## More specific

You might also have the opposite problem, where your context is not visible in the navigation title because it's obvious from something else in the view controller. But you still want to leave that more specific title as a breadcrumb for the user.

An example of this might be an address without a label. The first line of the address doesn't make sense as a navigation title, as it duplicates the view. But if you tap deeper than that, you might want to include *something* about the address, such as as the position in the list.

This is a little more complicated. You'll need to do this at runtime: Set the `title` of the `backBarButtonItem` for the navigation item of the view controller the button leads to. That will prevent the navigation item's `title` from being used.

**But there's a wrinkle.** Let's assume you want to set the title dynamically. You might have something like this in your parent view controller, which is called by your `viewWillAppear` and whatever triggers updates of the view controller:

    - (void)loadData {
        // lots of other stuff
        self.navigationItem.backBarButtonItem.title = @"dynamic title";
    }

This probably isn't going to work for you as is.

You'll find lots of crazy solutions to this; manipulating the `backBarButtonItem` by hand and restoring it after for instance. (There are much, much crazier solutions.)

The key is understanding why it's not working: `backBarButtonItem` is `nil`.

To make it not `nil`, you have two options:

1. Select the navigation item in the storyboard editor and give **Back Button** a value. This value will cause the `backBarButtonItem` to be automatically created with the view controller is instantiated.
2. Create the `backBarButtonItem` at runtime in your `viewDidLoad` or `awakeFromNib` ([suggested by @calebd](https://twitter.com/calebd/status/391068542076207105)). I don't recommend doing this in code; you're already using a storyboard or nib, so it's much simpler to just put a **Back Button** value into your view controller.

Once it's created — whether in code or by storyboard — its title can be changed. You can change `backBarButtonItem`'s title at any time when the parent is displayed, as often as you like: it'll only be shown when you push something else on top of it.

## Summary

If the text is always the same:

1. Select the parent view controller's **Navigation Item** in the editor.
2. Put the text into the **Back Button** value.

If the text is dynamic:

1. Select the parent view controller's **Navigation Item** in the editor.
2. Put *some* text into the **Back Button** value.
3. Set the title in the *parent* view controller, when its contents change: `self.navigationItem.backBarButtonItem.title = dynamicText;`
