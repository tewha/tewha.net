---
layout: post
tags : ["3g", "iOS", "Networking", "Proxy Server"]
title: "Wireless proxies may re-compress your files"
---
If you're downloading a file with widely-recognized lossy compression, your user's cellular provider may interfere with it. This has always been true of internet connections; I first ran into this with dialup years ago. But it went away for a while with broadband, is back with wireless.

The simplest example is a JPEG. You may get the JPEG you expect, but it's also possible for the proxy to deliver a smaller JPEG than you expect. The cell provider considers it "close enough", and the doubly-compressed JPEG is smaller (and far uglier).

<!--more-->

This may be true of other file types as well, if they're commonly recognized as lossy and computationally easy to re-compress.

I have read reports of T-Mobile and O2 doing this. I think it's been noted with other cell providers, too.

There's two possible fixes:

* Switching to HTTPS will fix this problem as the proxy will no longer be in the middle of the communication. If your resource is available via HTTPS, this is a fantastic and simple fix.
* Add a HTTP header to defeat this. The idea is to add a no-transform cache-control HTTP header to your request. This should disallow the server from making this kind of change. See [RFC 2616, section 14.9.5](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9.5).

*Thanks to [Tony Milllion](http://www.tonymillion.com) for pointing out the HTTPS solution, and letting me know it affected O2 as well.*