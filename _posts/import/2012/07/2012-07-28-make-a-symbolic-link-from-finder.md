---
layout: post
tags : ["Automator", "Finder", "Tip", "How To"]
title: "Make a symbolic link from Finder"
---
In a previous entry, I explained [How to Sync Xcode's Settings][1] via [Dropbox][2]. This involves creating symlinks in Terminal, and cleverly moving files about.

You can't create symlinks in Finder with what Apple provides you, but you **can** create an Automator workflow to do so easily.

<!--more-->

1. Create a new service in Automator.
2. Select: Service receives **selected files or folders** in **any application**.
3. Drag a Run Shell Script action.
4. Shell: **/bin/bash** (Even if you're using another shell as your default shell, this script is for bash.)
5. Pass input: **as arguments**.
6. Use this script:<pre>
	while [ $# -ne 0 ]; do
		ln -s "$1" "$1 symlink"
		shift
	done</pre>
7. The result should look like this:<br/>![Dropbox Workflow](/Images/Make-Symlink-Workflow.png)

Alternately, you can [download my finished service][3] from Dropbox. It should be stored in **~/Library/Services**.

You should now have a Make SymLink command when you right- or control-click a file or folder in the Finder:

![Make SymLink menu command](/Images/Make-Symlink-Menu.png)

You can even add a keyboard shortcut for it in System Preferences:

![Services Shortcut Key](/Images/Make-Symlink-Shortcut.png)

*Remember:* A symlink does not follow the original file if the original file moves on your hard drive.

[1]: /2012/07/how-to-sync-xcode-4s-key-bindings-and-code-snippets/
[2]: http://db.tt/ht6NoXF8
[3]: http://dl.dropbox.com/u/1606770/Goodies/Make%20SymLink.workflow.zip