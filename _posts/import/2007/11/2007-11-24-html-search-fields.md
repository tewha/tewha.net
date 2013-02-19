---
layout: post
tags : ["iPod", "Safari"]
title: "HTML search fields"
---
A few days ago I re-added a search field to this site. I was pleasantly surprised at how easy it was; the CSS was a little fussy, but that's more of a fun puzzle than a hard problem.



However, it took a long time to get the search field itself (which uses <a href="http://weblogs.mozillazine.org/hyatt/archives/2004_07.html#005890"><code>&lt;input type="search"/&gt;</code></a>) working nicely on the iPod touch. Of course, it turned out to be my fault: My CSS had an extra <code>}</code> in it just above the entry that limited the field's width. So the width is properly limited to something reasonable now. On the other hand, the search field doesn't seem to get a different appearance from the text field or the search history. I can live with that.



It seems to degrade fairly nicely on other browsers. Of course, it doesn't get the grey "click here to search"-type text, but I don't really feel that's worth adding. Hopefully, this will be adopted by the standard and end up in other browsers, too. In the meantime, I can live with this limitation, too. It certainly makes the code cleaner.



More on the input tag another time...