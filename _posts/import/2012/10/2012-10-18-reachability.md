---
layout: post
tags : ["iOS Development", "Networking"]
title: "Reachability"
---
Apple has a sample code package called Reachability. It wraps an iOS framework called SystemConfiguration, and can be used to determine network status, and catch events about networking going up and down. In the past, it's been an ugly chunk of sample code, but it's pretty respectable now.

One thing Reachability is not, however, is a crystal ball. Please don't use it as if it were.

How should you use Reachability?

- **Always try your connection *first*.** If you need to upload a change to the server, go ahead and try it. Don't worry about what Reachability last said, or currently says. Your attempt may be what kicks iOS into powering up the wireless hardware or re-establishing a connection. Networking is really hard; the only way to know if your connection will succeed is to try it and see if it **did** succeed.
- **Use Reachability to diagnose a connection failure.** Reachability can't tell you if your request will succeed, but if your request fails Reachability probably accurately reflects the reason why. Use what it tells you to improve your reporting to the user.
- **Use Reachability to retry when the connection goes back online.** Something else may provoke iOS into powering up the wireless hardware, and it may succeed. When this happens, Reachability will send out a notification. It's absolutely appropriate to use this notification to retry your networking.

Reachability is a great tool, but it's a tool for particular tasks. Learn the tasks Reachability is suited to, and your app will be better for it. You wouldn't use a hammer to change a light bulb. Please don't use Reachability to determine if a connection will fail.