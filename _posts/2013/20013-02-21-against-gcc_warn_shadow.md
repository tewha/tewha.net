---
layout: post
tags : ["Objective-C", "Coding", "C"]
title: "Against GCC_WARN_SHADOW"
---
Over the years I have tweaked which compiler warnings I use. There's one in particular that I used to turn on but will turn off from now on: `GCC_WARN_SHADOW`.

`GCC_WARN_SHADOW` is essentially drawing your attention to you *possibly* doing something other than you intended. This is like most warnings, but the difference is that the behaviour `GCC_WARN_SHADOW` is blocking is very useful.

This is the sort of things the more paranoid compiler warnings are good at. The downside is that it's difficult (not impossible) to drop a particular warning to indicate that you know what you're doing.

With `GCC_WARN_SHADOW` on, this code will generate a warning:

	int a = 5;
	int b = 3;
	int c = 4;
    int value = MAX(a,MAX(b,c));

Despite that, it will function perfectly. The reason for the warning is that it compiles down to this:

    ({
       int __a = (a);
       int __b = (({
           int __a = (b);
           int __b = (c);
           __a < __b ? __b : __a;
       }));
       __a < __b ? __b : __a;
    })

This is horribly ugly code. You wouldn't want to write this code. You wouldn't want to read it. But here's the catch: it's perfectly valid to the compiler, and hiding the ugliness *is why `MAX()` exists*.

There's to ways to avoid this. The first is to not use the `MAX()` macro at all:

	int a = 5;
	int b = 3;
	int c = 4;
    int value = a < b ? (b < c ? c : b) : a;

Or, you could do this:

	int a = 5;
	int b = 3;
	int c = 4;
	int temp = MAX(b,c);
    int value = MAX(a,temp);

If you're interested in `temp` — if it's a value that has meaning — this is a fine approach. Give it a better name than `temp` and run with it. But if it's a value that has no meaning other than an uninteresting temporary variable on your way to `value`, you've made your code worse.

The third approach is better: Stop using `GCC_WARN_SHADOW`.

These are artificial examples, granted. But let's pull this back to Objective-C, and something a typical Cocoa or Cocoa Touch programmer might have to do:

Also, if you use this you'll need to name error variables in blocks differently:

	NSError *e;
	[self somethingWithError: &e];
	[self runWithCompletion:^{
		NSError *e;
		[self recoverFromError:&e]; // warning, or rename inner error to e2
	}];

Overall, I didn't think it was worth the extra effort anymore. Your mileage will (of course) vary.