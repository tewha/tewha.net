---
layout: post
tags : ["Foundation.framework", "Web Services", "Coding"]
title: "Handling 302/303 redirects"
---
If you try to POST to a web API using `NSURLConnection` that redirects you using a [302](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.3.3) or [303](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.3.4) redirect, you'll fall over to a GET request. This is intentional, but you can override it.

<!--more-->

With HTTP status codes 302 and 303, the user agent (in this case, `NSURLConnection`) will change the request type from POST to GET. This is just how 302 was usually implemented; status code 303 was added to HTTP/1.1 to make this behaviour explicit.

HTTP/1.1 also added a status code to redirect without changing the request type from POST to GET. If you can change the web site, getting it to redirect you with a [307](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.3.8) instead will fix the problem.

If not, you can make `NSURLRequest` ignore this aspect of RFC2616.

`NSURLRequest` sends an event to its delegate, in which you can see what `NSURLRequest` plans to do and customize it:

    - (NSURLRequest *)connection: (NSURLConnection *)connection
                 willSendRequest: (NSURLRequest *)request
                redirectResponse: (NSURLResponse *)redirectResponse;
    {
        if (redirectResponse) {
            NSMutableURLRequest *r = [[originalRequest mutableCopy] autorelease];
            [r setURL: [request URL]];
            return r;
        } else {
            return request;
        }
    }

By doing this, you're cloning the original request and changing the URL to match the request suggested by `NSURLConnection` (which is following the RFC).

See also:

- w3.org: [RFC2616 HTTP/1.1, section 10: Status Code Definitions](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)