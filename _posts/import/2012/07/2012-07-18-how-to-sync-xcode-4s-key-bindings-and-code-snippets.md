---
layout: post
tags : ["tip", "How To"]
title: "How to sync Xcode 4's key bindings and code snippets"
---
You can use Dropbox to synchronize Xcode 4's key bindings, code snippets, named tabs, and font & color schemes. If you don't have a Dropbox account yet, [you can sign up here][1].

The secret is *symlinks*. These are different from the aliases you can create in Finder, so you'll need to do this in the shell.

The problem with this is that Xcode 4 will not follow symlinks. Luckily, Dropbox will. (Note, however, that Dropbox will **not** follow aliases.)

On your first computer:

1. Quit Xcode.
2. Create a directory for your sync on Dropbox. I use `~/Dropbox/Sync`. In it, I have a subdirectory for Xcode.
3. Move Xcode's UserData directory to your Dropbox:<br>`mv ~/Library/Developer/Xcode/UserData ~/Dropbox/Sync/Xcode/UserData`
4. Let Dropbox upload everything.
5. Pause Dropbox's syncing.
6. Move them back to where Xcode stores them: <br>`mv ~/Dropbox/Sync/Xcode/UserData ~/Library/Developer/Xcode/UserData`
7. Create a symbolic link from your UserData to DropBox:<br>`ln -s ~/Library/Developer/Xcode/UserData ~/Dropbox/Sync/Xcode/UserData`
7. Resume Dropbox syncing.
8. Relaunch Xcode.

On any other computer:

1. Quit Xcode.
2. Let Dropbox download everything, if it hasn't yet.
3. Pause Dropbox syncing.
4. Remove your local Xcode user data:<br>`rm -R ~/Library/Developer/Xcode/UserData`
5. Move your UserData from Dropbox to Xcode:<br>`mv ~/Dropbox/Sync/Xcode/UserData ~/Library/Developer/Xcode/UserData`
6. Create a symbolic link from your UserData to DropBox:<br>`ln -s ~/Library/Developer/Xcode/UserData ~/Dropbox/Sync/Xcode/UserData`
7. Resume Dropbox syncing.
8. Relaunch Xcode.

You can also synchronize your Archives directory, using the same technique.

This technique is not perfect, as Xcode will probably not recognize changes while running. However, it is better than having to manually copy these directories between computers.

[1]: http://db.tt/ht6NoXF8