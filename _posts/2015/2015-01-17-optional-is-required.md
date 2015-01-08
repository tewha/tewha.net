---
layout: post
tags : ["iOS", "UITableView"]
title: "Optional is required"
---

Do you haven app where the row heights in a table view shift, especially when navigating away from a view controller?

This seems to be an iOS bug and is caused by using autolayout within a table cell without a `tableView:estimatedHeightForRowAtIndexPath:` method.

If you do not implement this method, the UITableView will treat that as an estimated row height of `0`. AutoLayout will panic and try to compensate for this, and you'll still see an incorrect size. (I believe this to be the minimum size that it thinks would satisfy your content without any spacing, but I'm not sure of this.) You see this bug in some of Apple's apps, including Settings.

To fix it, you need to implement tableView: `estimatedHeightForRowAtIndexPath:` and return a rough estimate of the size of the row. iOS includes a constant for this, if you have no good estimate: `UITableViewAutomaticDimension`.

This may introduce a few other (minor) problems, as providing estimates can lead to views being poorly sized as you scroll. Apple discusses this in their documentation. If you are impacted by something like that, a `tableView:estimatedHeightForRowAtIndexPath:` that returns values closer to actual might help. That said, while I had problems from rough estimation on the **simulator** I've never noticed it on a real device. Seems like the logic is a bit different between them.

However:

* You should **not** attempt to calculate real height values. The entire point of this method is to short-circuit involved height calculation. It's just unnecessary.
* You should not attempt to cache heights returned by the real `tableView:heightForRowAtIndexPath:`, either. The values in that cache will be wrong when estimatedHeightForRowAtIndexPath is first called anyway; they're really no better than `UITableViewAutomaticDimension`.

So what _should_ you do? It really is this simple:

    - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return UITableViewAutomaticDimension;
    }

And you're done!
