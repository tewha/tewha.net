---
layout: post
tags : ["Coding", "iOS Development"]
title: "Changing UINavigationBar's title text color"
---
How do you change UINavigationBar's title color? You can't, directly, but you can substitute your own view.

For example, start with <a href="http://developer.apple.com/library/ios/#samplecode/NavBar/Introduction/Intro.html">Apple's NavBar sample</a>.  Drop this code into <code>initWithNibName:bundle:</code> in <code>PageThreeViewController.m</code>:

	- (id)initWithNibName:(NSString *)nibNameOrNil
				   bundle:(NSBundle *)nibBundleOrNil
	{
		self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
		if (self)
		{
			// this will appear as the title in the navigation bar
			CGRect frame = CGRectMake(0, 0, 400, 44);
			UILabel *label = [[UILabel alloc] initWithFrame:frame];
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont boldSystemFontOfSize:20.0];
			label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
			label.textAlignment = UITextAlignmentCenter;
			label.textColor = [UIColor yellowColor];
			self.navigationItem.titleView = label;
			label.text = NSLocalizedString(@"PageThreeTitle", @"");
			[label release];
		}
	
		return self;
	}
