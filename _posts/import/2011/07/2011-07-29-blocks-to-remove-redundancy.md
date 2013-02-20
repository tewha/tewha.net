---
layout: post
tags : ["Blocks", "Coding", "How To", "Objective-C"]
title: "Blocks to remove redundancy"
---
Blocks have many complicated uses, from event-based code to multithreading. But they can also be used for very trivial tasks, such as removing redundant lines from code.

Here's a common operation for me: Split a list into sublists based on some piece of data changing within a loop. When the loop is over, dump whatever's left into another sublist.

<!--more-->

Without blocks, this looks like this:

	- (NSArray *)splitArray: (NSArray *)array
				   valueKey: (NSString *)valueKey
				   labelKey: (NSString *)labelKey;
	{
		id sections = [NSMutableArray array];
		id sectionValue = nil;
		id sectionRecords = [NSMutableArray array];
		
		for (id record in array) {
			id recordValue = [record objectForKey: valueKey];
			if ( ![recordValue isEqual: sectionValue] ) {
				if ( [sectionRecords count] ) {
					id lastRecord = [sectionRecords objectAtIndex: 0];
					id label = [lastRecord objectForKey: labelKey];
					id section = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSArray arrayWithArray: sectionRecords], @"Records",
								  label, @"Name",
								  nil];
					[sections addObject: section];
					[sectionRecords removeAllObjects];
				}
				sectionValue = recordValue;
			}
			[sectionRecords addObject: record];
		}
		if ( [sectionRecords count] ) {
			id lastRecord = [sectionRecords objectAtIndex: 0];
			id label = [lastRecord objectForKey: labelKey];
			id section = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSArray arrayWithArray: sectionRecords], @"Records",
						  label, @"Name",
						  nil];
			[sections addObject: section];
			[sectionRecords removeAllObjects];
		}
		
		return [NSArray arrayWithArray: sections];
	}

The redundancy makes this hard to maintain, but I don't really want to split it off into a different function. That means passing all the parameters in to the second function.

But wait! Can we use blocks to clean this up? Yes, we can! We can define the code we want to execute in a block, then use the block as necessary within the function.

With blocks, the code looks like this:

	- (NSArray *)splitArray: (NSArray *)array
				   valueKey: (NSString *)valueKey
				   labelKey: (NSString *)labelKey;
	{
		id sections = [NSMutableArray array];
		id sectionValue = nil;
		id sectionRecords = [NSMutableArray array];
		
		dispatch_block_t split = ^{
			if ( [sectionRecords count] ) {
				id lastRecord = [sectionRecords objectAtIndex: 0];
				id label = [lastRecord objectForKey: labelKey];
				id section = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSArray arrayWithArray: sectionRecords], @"Records",
							  label, @"Name",
							  nil];
				[sections addObject: section];
				[sectionRecords removeAllObjects];
			}
		};
		
		for (id record in array) {
			id recordValue = [record objectForKey: valueKey];
			if ( ![recordValue isEqual: sectionValue] ) {
				split();
				sectionValue = recordValue;
			}
			[sectionRecords addObject: record];
		}
		split();
		
		return [NSArray arrayWithArray: sections];
	}

Since the block by default has read-only access to any variable it wants as long as it's in scope, there's no need to pass parameters into the block.

As I said in the introduction, blocks are a lot more powerful than this. See Apple's <a href="http://developer.apple.com/library/ios/#DOCUMENTATION/Cocoa/Conceptual/Blocks">Block Programming Topics</a> for more about that. However, they're a great tool for small problems as well that you shouldn't overlook.