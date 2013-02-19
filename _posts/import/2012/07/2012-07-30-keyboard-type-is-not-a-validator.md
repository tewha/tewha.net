---
layout: post
tags : ["ios", "Software Development", "coding"]
title: "Keyboard type is not a validator"
---
So you've set your `UITextField`'s `keyboardType` to only accept numbers. Or email addresses, or URLs, or whatever. Fine. You're done, right?

What are you going to do if they enter something else in there?

`UITextField`'s keyboard type is a *keyboard type*, not a validator.

Here's two examples:

## Emoji ##

1. Edit a contact in Contacts.
2. Tap a name field.
3. Switch to the Emoji keyboard.
4. Tap the phone number field.

Contacts will stop you from actually putting Emoji into the phone number field, but this is a feature of **Contacts** not of `UITextField`. If you try this in your own app, you'll be able to enter Emoji there.

## Paste ##
1. Edit a contact in **Contacts**.
2. Tap a name field.
3. Tap and hold.
4. Select some text.
5. Tap **Copy**.
6. Tap the phone number field.
7. Tap and hold.
8. Tap **Paste**.

## So what do you do? ##

Now that you've started thinking about this, I bet you can find other ways to reproduce this.

This is not your bug. It's probably not a bug at all. But you need to adjust your expectations appropriately.

You could probably trap `textField:shouldChangeCharactersInRange:replacementString:` like Contacts does. This may be doing more work than necessary.

However, you **absolutely** should test your code to see how it handles bendy inputs. If it crashes, you really should make your code more paranoid about its inputs. Whoever's bug it is, it's not a good excuse to crash.