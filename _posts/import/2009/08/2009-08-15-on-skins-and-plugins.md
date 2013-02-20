---
layout: post
tags : ["Design", "Plugins", "Rant", "Skins", "Software Development", "Themes"]
title: "On skins and plugins"
---
I started this post over six months ago, but never quite got around to finishing it. It might never be finished. But this is a thorn to me, so I'm just going to post it as is.

Should your new application support skins?

Probably not. Skins are often a programmer's way of saying "Oh, I don't do UI. We'll let someone else get it right." Only nobody ever does, at least not in your product. Your UI just isn't as compelling [as the one it's replacing][1].

[1]: http://www.codinghorror.com/blog/archives/000789.html

The corollary to this is that if lots of people are demanding skins, it means your UI sucks. Once you add skins, you'll never be rid of those skins, and you won't have fixed your application either.

**You'd probably do better to fix your application's appearance and behavior.**

Now, should you do a custom appearance?

If you're planning a completely custom appearance for your applications, odds are it will suck. Unless you have artists that are beyond simply competent, but brilliant, you'll probably fail.

First, you need a UI that looks and feels good. Secondly, it probably needs to fit in with the native platform. If you're planning a full screen game, it's fine to not fit in. But if you're building a Windows-based BIOS updater, that custom UI that you think looks so amazing? The truth is, it [looks like complete shit][2].

[2]: http://support.asus.com/technicaldocuments/technicaldocuments_content.aspx?no=714

**You're better off fitting custom UI into the OS rather than changing your whole application to fit them.**

Now, finally: What about plugins?

This one is a little less clear. There's great reasons to do plugins. Integration with another system (whether technical such as a web site or social such as particular requirements for reporting) is a good one.

But you know what isn't a great reason? Making your product a **platform**. Do you want to be a product people use, or a platform people struggle with?

Firefox's plugins make me flinch. They're usually poor quality, craptacular tools that lunge for a particular nugget of a good idea and fall flat on their faces a few yards away from it. There are a few that are interesting, but they'd [benefit from being rolled in][3], or being a [separate stand-along product][4] on their own.

[3]: https://addons.mozilla.org/en-US/firefox/addon/1843
[4]: https://addons.mozilla.org/en-US/firefox/addon/5817

Pick your features carefully. 37signals didn't become popular by picking an extensive list of features or allowing people to write their own features. Instead, they built something they wanted to use. And they're not alone. There are a few things I'd love to see ([Markdown][5] instead of [Textile][6], for instance), but even if a hypothetical plugin system could add these things, they'd be overwhelmed by the layer of suck.

[5]: http://daringfireball.net/projects/markdown/
[6]: http://textile.thresholdstate.com/

**Before you build a plugin architecture, put the effort into your application.**