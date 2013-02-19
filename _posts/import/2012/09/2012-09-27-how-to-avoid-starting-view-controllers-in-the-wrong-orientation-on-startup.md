---
layout: post
tags : ["blocks", "Cocoa Touch", "ios", "iOS Development", "rotation"]
title: "How to avoid starting view controllers in the wrong orientation on startup"
---
This is a bit obscure, but I ran into it earlier this week. Why would a view controller appear in the wrong orientation on startup?

When your iPad application first launches it will be in portrait mode, even if it's held in landscape mode. The rotate event is already in the queue and is consumed early enough that it'll never actually be shown like that. So no problem, right?

The problem is that the rotate event will not have been consumed when your `viewWillAppear:` is first called. Opening a new view controller in `viewWillAppear:` (whether using `presentModalViewController:` or a storyboard segue) will open that new view controller in portrait mode, rather than landscape mode. Even that wouldn't be a problem, except iOS will not add a rotate event added for the new view controller.

This all makes a great deal of sense when you think it through: The rotate events for the initial view controller or controllers are already on queue before `viewWillAppear` is called. iOS already recognizes the device has been rotated; as far as it's concerned, the rotation is done. Your app is just lagging a bit behind as part of the startup process, with everything all queued up.

Conceptually, this is a hard problem.

But in practice, there's a very simple and very elegant solution using blocks.

All you need to do is delay your view controller's appearance. Before blocks, you might have had to use a timer. But now you can just use `dispatch_async` to schedule the new view controller for later.

That's a little confusing, so here's an example:

I have a view controller that appears when my application is first installed, to walk the user through the signup process. (Later, if there's an authentication problem, I fall back on the standard username and password alert view.)

This view controller, then, needs to appear when my main view first appears. If I use this code, the view controller that appears will always be in portrait, even if the device is started in landscape.

    - (void)viewWillAppear: (BOOL)animated {
        [super viewWillAppear:animated];
        if (freshInstall) {
            [self performSegueWithIdentifier: @"firstRun" sender: self];
        }
    }

If I use this code, however, the view controller that appears will match the device (and the view controller it's appearing over):

    - (void)viewWillAppear: (BOOL)animated {
        [super viewWillAppear:animated];
        if (freshInstall) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self performSegueWithIdentifier: @"firstRun" sender: self];
            });
        }
    }

Later in this case is *still before* the user has a chance to interact, or even before the UI really and truly appears onscreen. The block for showing the view controller will be added to the queue. Everything will just work. By the time your block is run from the main queue, the rotation event will be dealt with and your app will really and truly be in landscape orientation. However, it'll still be early enough for your view controller to look like part of early application startup.

*Note: This was done on my "stable" branch, so it was probably on iOS 5. I have not yet tried this on iOS 6, but [I've read reports this is no longer necessary][shusta]. Either way, it's a good trick if you plan on maintaining iOS 5 compatibility (which you should, for a while at least).*

[shusta]: https://twitter.com/shusta/statuses/251389962661027842