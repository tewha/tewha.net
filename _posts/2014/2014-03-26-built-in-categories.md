---
layout: post
tags : ["Objective-C", "UIKit", "iOS"]
title: "Built-in categories"
---

**NSIndexPath** is easier to use than you might think.

If you read the documentation for the class, you'll see this:

>Creating Index Paths
>
>\+ indexPathWithIndex:
>
>\+ indexPathWithIndexes:length:
>
>\- initWithIndex:
>
>\- initWithIndexes:length:
>
>\- init

Yes, you can use these to construct an index path. But you probably don't want to. UIKit defines a category on **NSIndexPath** specific to **UITableView**'s needs:

    // This category provides convenience methods to make it easier to use an NSIndexPath to represent a section and row
    @interface NSIndexPath (UITableView)
    
    + (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
    
    @property(nonatomic,readonly) NSInteger section;
    @property(nonatomic,readonly) NSInteger row;
    
    @end

There's a similar category defined by **UICollectionView**:

    @interface NSIndexPath (UICollectionViewAdditions)
    
    + (NSIndexPath *)indexPathForItem:(NSInteger)item inSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
    
    @property (nonatomic, readonly) NSInteger item NS_AVAILABLE_IOS(6_0);
    
    @end

The absence of section in this category isn't significant; the same property is already defined by **NSIndexPath (UITableView)**.

UIKit defines other categories, such as drawing categories on **NSString**.

Why are these separated? Well, **NSIndexPath** is part of Foundation. **UITableView** is part of UIKit. String drawing is added to **NSString** which is part of Foundation, but Foundation, but uses **UIFont** which is part of UIKit. In short, there's good technical reasons for this to be splatted out. But knowing that is not helpful to us developers.

So how do you find out about these methods? I don't think there's a good way to find categories like these in Apple's class references. Some of them are mentioned in Apple's less reference-like material. For instance, there's "[Collections Programming Topics: Index Paths: Storing a Path Through Nested Arrays][1]":

[1]: https://developer.apple.com/library/ios/Documentation/Cocoa/Conceptual/Collections/Articles/IndexPaths.htm

> In iOS, UITableView and its delegate and data source use index paths to manage much of their content and to handle user interaction. To assist with this, UIKit adds programming interfaces to NSIndexPath to incorporate the rows and sections of a table view more fully into index paths. For more information, see NSIndexPath UIKit Additions. For instance, index paths are used to designate user selections using the tableView:didSelectRowAtIndexPath: delegate method.

Google searches are probably your best bet, such as [index path from row and section][2].

[2]: https://www.google.com/#q=nsindexpath+from+row+and+section

I hope we'll see improvements on this in the future.