---
layout: post
tags : ["agps", "Apple", "gps", "iPhone", "maps", "navigation", "wifi"]
title: "How the iPhone GPS differs from a standalone navigation GPS"
---
All models of iPhone since the 3G, as well as the iPad 3G and iPad 2 3G, include Assisted GPS (AGPS).

I've heard that this isn't real GPS or that it's somehow inferior to real GPS. AGPS is actually superior to "real" GPS. However, there are ways the iPhone is also inferior to a standalone navigational GPS like a Garmin or Tom Tom. I'm going to explain the differences between them.

## Positioning ##

The iPhone includes a regular GPS receiver, just like your standalone GPS. The "assisted" part means the iPhone is able to get a quick lock based on other data sources, such as nearby cell phone towers or WiFi networks.

I'm not going to try to write an explanation of this. There's a great article on this in Macworld by Glenn Fleishman, "[How the iPhone knows where you are](https://www.macworld.com/article/159528/2011/04/how_iphone_location_works.html)," which you should read. He's a journalist who specializes in wireless technologies, and anything I could write on that subject would fail to measure up to his writing.

But I can summarize that article for you in one paragraph, if you didn't bother to read it:

Because the iPhone has a GPS radio *and* these other data sources, it's quicker at finding your location than a standalone navigational GPS.

Your iPhone does this without sacrificing final accuracy, but may give you several approximations along the way. (These are times a real GPS would still be trying to figure out where you are.) This is simplifying a little; the iPhone needs to conserve battery more than your standalone GPS. If you're not actually using Maps or some other application that needs pinpoint accuracy, it probably powers down the GPS and uses whatever radios it has powered up to do approximate positioning rather than the most accurate positioning it's capable of. But when you need accurate positioning, it's there.

## Maps ##

So why do people think the iPhone's GPS isn't a real GPS? It's because of the one way the iPhone is weaker than your standalone GPS. As shipped by Apple, the iPhone is completely dependent on the Internet for map tile data.

That means that without a data signal, whether WiFi or 3G, the iPhone is unable to show you a map. You end up with a screen like this:

![No Maps](/images/No-Maps.png)

From this, you might conclude that without a data connection your iPhone isn't very good as a navigational tool. You'd be right about that! But you might also conclude that the iPhone doesn't know where you are. In fact, it knows where you are. It just isn't able to put it on a map, because it doesn't actually have a map of the area.

This is where standalone GPS devices are better. Because they don't have the extra radios that the iPhone has, they can't download map data from the Internet. Instead, a standalone GPS includes map data on the device. Storing an entire country's (or even an entire continent's) map data takes a lot of space, so it's often rendered more crudely than the iPhone's maps.

Imagine drawing a map for a friend to get to your house. You know which road they'll be coming on, and you know where they're trying to go. You can fill in the roads they need to pay attention to from memory, and mark turns and the destination. This is how a standalone GPS works, except that if it's up-to-date it knows **all** the roads and can quickly draw everything quickly and to scale. It's rendered using just its memory, without the aid of a 3G or WiFi network.

The iPhone's maps, on the other hand, are from the cloud. The iPhone basically asks for a graphical map from the cloud, with the location and zoom it's interested in. The image the cloud returns can be beautifully rendered and completely up-to-date, but without the cloud, the iPhone can't get anything.

But what if your iPhone did have map data on device? Then it would be able to render maps without a data connection AND get a fix faster than a real standalone GPS. This is where the App Store comes in to play. Tom Tom and Garmin both sell apps that include map data. When running one of these apps, the iPhone is able to find its location faster than a standalone GPS. However, even without a connection to the Internet, the app is able to provide a map.

## Turn-by-turn navigation ##

If you've reached this point, you're probably wondering why the iPhone can't do turn-by-turn navigation. It's a fair question. The answer is complicated, but boils down simply: Apple does not provide the map data. Instead, Apple's map display uses data provided by Google. And Google does not allow Apple to use that map data for turn-by-turn navigation. Apple, in turn, does not allow iPhone developers to submit turn-by-turn navigation apps that use the iPhone's map system.

So why can some Android phones provide turn-by-turn navigation? Google allows it.

This is why any turn-by-turn navigation app is going to require its own map data, rather than working off the cloud when it's available. There's been a few hints that Apple may switch to their own data at some point, but it hasn't happened yet. Being dependent on a competitor interested in keeping your device inferior isn't a good position to be in, even if the reasoning has nothing to do with competition.

**Update:** The next version of iOS 6 will switch the data source to Apple's. The iPhone will still download map data, but instead of downloading just a picture it will now download richer data that will allow it to display rotated maps more cleanly. And Apple is bringing turn-by-turn directions to the iPhone 4S. The iPhone will not get offline navigational data, however.

## Conclusion ##

The iPhone's GPS us very good. Without extra software, however, iPhone **navigation** is entirely dependent on the Internet. But you can see maps as long as the iPhone can reach the cloud. You can download software so you can see maps while away from the cloud. And any photo you take, even while away from the cloud, will still be tagged with the location of the iPhone.

The iPhone makes its connection to the cloud a strength, whereas standalone GPS units have made the lack of a radio their strength. It's a complicated tradeoff. Saying the iPhone does not have "real" GPS or that AGPS is not "real", though, is inaccurate.