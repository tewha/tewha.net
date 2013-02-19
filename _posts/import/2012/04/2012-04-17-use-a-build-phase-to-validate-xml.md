---
layout: post
tags : ["Xcode", "xml", "coding"]
title: "Use a Build Phase to validate XML"
---
My application includes some XML files that are used while running to map data from a web service. This has drastically simplified the code I needed to write to parse data from the web service, since I can describe how to decode all of the types of object the web service interacts with simply.

If I accidentally provide bad XML, I don't know until my app tries to parse it. That may be some time into its run. If the XML is processed because of a specific user action, I've broken that specific user action.

Obviously, I want to test everything in my app before I post it to the iTunes Store. But finding this problem even *hours* later makes it harder to diagnose and fix. I can detect this error immediately (and fix it right away) by adding a build phase to validate my XML.

I added a run script to my target that does this:

    find "${PROJECT_DIR}" -name *.xml -exec xmllint {} \;

*See update below.*

![Validation Build Phase](/images/Validation-Phase.png)

Xcode will run this script when building my target. It will find all XML files in my project directory, and run `xmllint` on them. `xmllint` returns an error if the document is malformed.

I gave this build phase a good name so I can find it easily later, then dragged the script as high in my build phase order as possible to get the results early. This may not actually prevent the project from building, but at least I get a big red error.

This validates **all** the XML in my project directory. If you have XML you don't need, you'll have to do something more complicated:

- Provide a more specific starting path
- Use one of the other variables validate the built .app package instead, or
- Hard code each XML file's path

## Update

This command works better:

    find "${PROJECT_DIR}" -name *.xml -print0 | xargs -n 1 -0 xmllint

With this command, the error not only stops Xcode, but Xcode highlights the line that xmllint reports as the offender.