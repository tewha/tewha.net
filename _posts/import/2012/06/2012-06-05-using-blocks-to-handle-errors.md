---
layout: post
tags : ["Blocks", "Cocoa", "Cocoa Touch", "Error Handling"]
title: "Using blocks to handle errors"
---
In the past, I've talked about [Using blocks to remove redundancy](/2011/07/blocks-to-remove-redundancy/). But now I want to explain the pattern I've adopted since, which is my favorite block pattern of all. Even though it, too, is all about removing redundancy: handling errors.

Although Objective-C supports exceptions, they're not commonly used. A thrown exception is usually not caught, making it a fatal error.

<!--more-->

[The Objective-C Programming Language](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocExceptionHandling.html#//apple_ref/doc/uid/TP30001163-CH13-TPXREF168) describes it thus:

> **Important** In many environments, use of exceptions is fairly commonplace. For example, you might throw an exception to signal that a routine could not execute normally—such as when a file is missing or data could not be parsed correctly. Exceptions are resource-intensive in Objective-C. You should not use exceptions for general flow-control, or simply to signify errors. Instead you should use the return value of a method or function to indicate that an error has occurred, and provide information about the problem in an error object. For more information, see [Error Handling Programming Guide](http://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorHandling/ErrorHandling.html#//apple_ref/doc/uid/TP40001806).

What, then, is the usual pattern for handling non-fatal errors. The answer is the `NSError class`, along with a few simple conventions:

1. Any method that can fail should return 0 (or an equivalent) on failure.
2. Any method that fails by returning 0 (or an equivalent) on failure should take a pointer to return a `NSError` instance, which it populates with error details.
3. If the error pointer is `NULL`, the method should not return an error.

For instance:

    - (BOOL)doSomethingWithError: (NSError **)error {
    
        // other code
        NSError *e;
        if ( ![self bitWithError: &e] ) {
            if (error) *error = e;
            return NO;
        }
        
        return YES;
    }

This seems pretty reasonable, but can get unmanageable quickly:

    - (BOOL)doSomethingWithError: (NSError **)error {
        
        NSError *e;
        
        if ( ![self part1WithError: &e] ) {
            if (error) *error = e;
            return NO;
        }
        
        if ( ![self part2WithError: &e] ) {
            if (error) *error = e;
            return NO;
        }
        
        if ( ![self part3WithError: &e] ) {
            if (error) *error = e;
            return NO;
        }
        
        return YES;
    }

Thankfully, blocks can simplify this for us!

    - (BOOL)doSomethingWithError: (NSError **)error {
    
        BOOL(^fail)(NSError *e) = ^(NSError *e) {
            if (error) *error = e;
            return NO;
        };
        
        NSError *e;
        if ( ![self part1WithError: &e] ) return fail(e);
        
        if ( ![self part2WithError: &e] ) return fail(e);
        
        if ( ![self part3WithError: &e] ) return fail(e);
        
        return YES;
    }

Using a fail block has a few advantages:

* You have a single place through which all errors in this method are routed. You can put a breakpoint here, or add logging.
* If you change what doSomethingWithError returns, you change just the return type of the block and the return within the block.
* You eliminate a lot of redundant code, therefore lessening the chance of an error in one of the copies.

Footnote: Usually, if I am writing an if statement, I'll write it like this:

    if (foo) {
        // statement
    }

I do this even when it's not necessary, because what if I expand on it later? And I think this is a good principle. But for a fail block like this, I'm *never* going to add an extra statement. The whole point of the block is to make sure that the failure code is a single statement.