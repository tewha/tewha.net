---
layout: post
tags : ["Foundation.Framework", "iOS", "Software Development", "Coding"]
title: "Networking using NSURLConnection"
---
In a previous article, I mentioned how to [handle 302/303 redirects to web services](handling-302303-redirects). But that's a fairly advanced topic, and we should have built up to that.

What I'm going to cover:

- The basics of networking using `NSURLConnection`, part of Apple's Foundation framework.

What I'm not going to cover:

- How to determine if a connection is available before trying a request. (Hint: Don't.)
- How to retry an operation when a connection becomes available. (Hint: Reachability.)
- How to abstract this without losing anything important, and bring it all under control. (Hint: Use [AFNetworking](https://github.com/AFNetworking/AFNetworking/).)

All of these are topics I'll write about in future articles. But today, just the basics!

Also, this code will assuming you're using Automatic Reference Counting. Because [you ought to be](/2012/05/automatic-reference-counting/).

For any HTTP operation, you're going to use `NSURLConnection`. It's not safe to use synchronously from the main thread. This will cause the main thread to stop responding to user-level events, and iOS will quit your application. It behaves exactly as if your application crashed.

On Mac OS X, the system will not quit your application, though your application will become unresponsive and **look** like it's frozen. So on Mac OS X, you should follow the same pattern of avoiding synchronous network requests on the main thread of your application.

That leaves three options:

1. Asynchronous networking on the main thread.
2. Synchronous networking on another thread.
3. Asynchronous networking on another thread.

Under normal circumstances, you don't need to run networking operations on a different thread. There's very few problems that require moving to another thread.

Using asynchronous operation will cause the networking itself to run in the background. You can consider this a dedicated thread by Apple. Your delegate methods will be called in the correct sequence on the main thread to catch up with networking as iOS determines it is appropriate.

Apple includes an example of how to use `NSURLConnection` in [URL Loading System Programming Guide, Using NSURLConnection](https://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/URLLoadingSystem/Tasks/UsingNSURLConnection.html). It's a short article, full of simple code examples. You should spend a few minutes to read this.

In a nutshell, here's the pattern:

1. Keep a `NSMutableData` for your response data.
2. Clear the contents `NSMutableData` instance in `connection:didReceiveResponse:`. (You may receive multiple `connection:didReceiveResponse:` events as the request is redirected, but you should only use data from the last one.)
3. Append the data you receive from didReceiveData to the `NSMutableData`. Don't try to process it immediately; you will usually receive multiple `connection:didReceiveData:` events for a single transfer.
4. In `connectionDidFinishLoading:`, your data is complete. Here, you can do something with it.

The idea here is that your start (or restart) accumulating data in `connection:didReceiveResponse:`, append data in your `connection:didReceiveData:`, and actually do something with the data in `connection:connectionDidFinishLoading:`.

Processing the data shouldn't really be done on the main thread, either. You can start another thread, but it's easier to just `dispatch_async` to a queue that isn't running on the main thread.

It is possible to run an `NSURLConnection` on another thread, of course. That thread will need to be using a run loop to receive the delegate events from networking. But unless there's some reason you need a separate thread, using asynchronous networking is Apple's solution to this.

Using `NSURLConnection` requires a class member to accumulate data as its transferred. That means that if you're going to have multiple simultaneous transfers, you'll need something more complicated. Probably a wrapper class to drive `NSURLConnection`, and keep each response separate. By the time you've written this wrapper class, you've probably written a naive version of `AFHTTPRequestOperation`, a part of AFNetworking.

But we'll get to AFNetworking in a future post.

Assuming you only have a single transfer going on at once, your code should look a bit like this:

	- (void)doNetworkThing {
	
		NSURL *URL = [NSURL URLWithString: @"http://tewha.net/"];
		NSURLRequest *request = [[NSURLRequest alloc] initWithURL: URL];
		NSURLConnection *connection = [[NSURLConnection alloc]
		                               initWithURLRequest: request];
	
		receivedData = [[NSMutableData alloc] init]; // should be a class member
		[connection start];
	}
	
	- (void)connection:(NSURLConnection *)connection
	didReceiveResponse:(NSURLResponse *)response {
		[receivedData setLength:0];
	}
	
	- (void)connection:(NSURLConnection *)connection
	    didReceiveData:(NSData *)data {
		[receivedData appendData:data];
	}
	
	- (void)connection:(NSURLConnection *)connection
	  didFailWithError:(NSError *)error {
		// do something with error here
	}
	
	- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
		dispatch_async(someQueue, ^{
			// do something that takes a long time with receivedData here
			dispatch_async( dispatch_get_main_queue(), ^{
				// access the UI here
			});
		});
	}

See also:

- [URL Loading System Programming Guide, Using NSURLConnection](https://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/URLLoadingSystem/Tasks/UsingNSURLConnection.html)
- [NSURLConnection Class Reference](https://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSURLConnection_Class/Reference/Reference.html)