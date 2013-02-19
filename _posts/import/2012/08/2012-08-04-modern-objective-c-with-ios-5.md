---
layout: post
tags : ["iOS Development", "objective-c"]
title: " Modern Objective-C with iOS 5"
---
Modern Objective-C contains subscripting support.

Instead of writing:

	NSString *value = [dict objectForKey: @"Key"];

You can now write:

	NSString *value = dict[@"Key"];

Unfortunately, this requires SDK support. While the OS X SDK provides this support, the iOS one doesn't (yet).

## Allow subscripting everywhere ##

The iOS SDK provides routing from the new messages to the old via arclite, a library included automatically whenever you use Automatic Reference Counting. To add support for subscripts to Objective-C, you just need to inform the compiler it's allowed to make those calls using a category.

Peter Steinberger explains and offers such a header in [Using Subscripting With Xcode 4.4 and iOS 4.3+][1]

You can `#import` this where needed, or add it to your precompiled header. There's no need to add an implementation; it's handled automatically by `arclite`. (If you are not using ARC, you will have to force the linker to include `arclite`. But you don't have to actually switch to using ARC.)

I don't recommend this, however. This will let you use subscript syntax with every type, not just those actually provided by the runtime. But if you use subscript syntax with a class that doesn't support it, you'll get a runtime error.

For instance, this will work:

	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	dict[@"foo"] = @"bar";

This, however, will build but cause a runtime error:

	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSLog(@"the value of key is %@", userDefaults[@"key"]);

We can do better.

## Target only those classes supporting subscripts ##

We can also add subscripting support only on types you plan to use that you are certain arclite adds subscript support to.

Use a header like this:

	#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
	@interface NSDictionary(subscripts)
	- (id)objectForKeyedSubscript:(id)key;
	@end
	
	@interface NSMutableDictionary(subscripts)
	- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
	@end
	
	@interface NSArray(subscripts)
	- (id)objectAtIndexedSubscript:(NSUInteger)idx;
	@end
	
	@interface NSMutableArray(subscripts)
	- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
	@end
	#endif

This will add subscripting support only to `NSArray` and `NSDictionary`. I don't know what other classes Apple provides subscripting support for via arclite; if there's a list, I haven't found it yet.

I have put this code in a [public github repository][2]; do with it as you will.

  [1]: http://petersteinberger.com/blog/2012/using-subscripting-with-Xcode-4_4-and-iOS-4_3/
  [2]: https://github.com/tewha/iOS-Subscripting