---
layout: post
tags : ["Mac OS X", "Mac OS X Leopard", "Security", "Time Machine"]
title: "Mac OS X runs deleted applications"
---
I filed this as radar #5574036, but it seems significant to share:

Imagine that you trash an application because of a security flaw. Say, it handles the URL type foofoo, and is proven to be a security risk. But the developer won't fix it (or hasn't fixed it yet), so you've removed the application from your hard drive to keep yourself safe.

It doesn't work that way — you're not safe. Time machine has made a copy in your time machine backup that Mac OS X will cheerfully launch without a warning.

Steps to reproduce:

1. Have existing, up-to-date Time Machine backups.
2. Delete a protocol handler.
3. Visit a web site that uses that protocol.

Expected results:

* Mac OS X will respect that the application has been removed.

Actual results:

* Mac OS X will hand it off to the application on the Time Machine backup volume.

This seems to also be true of standard Finder document bindings. I tried double clicking a TextWrangler document after deleting TextWrangler and it cheerfully launched out of the Time Machine backup. Not that I think there's anything wrong with TextWrangler; it was just a program I knew I could delete safely (and restore after).

It was pointed out to me on the [Macworld Forums][1] by Rob Griffiths that there is a way to permanently delete a file from all backups. You need to use the context menu within time machine to delete all backups of a file. This means there's a workaround, but it's still a problem that Mac OS X launches applications from the backup folder without even a warning.

[1]: http://www.macworld.com/forums/ubbthreads/showflat.php?Cat=0&Number=547953

**Update:** Apparently, some don't understand why this is a bug. Let me give you a simple example: You find out Adium (for example) has an available exploit that the developers haven't patched yet. You remove Adium, but it continues to exist in your backup. You visit a web page that activates the Adium bug, and Adium is launched from your backup. That you can launch Adium from your backup is not a bug. That Mac OS X will do so **automatically** without confirmation is a bug. The backup should be considered a vault for the **user**, not Launch Services.