---
layout: post
tags : ["clang", "Compiler", "gcc", "Warnings", "Xcode"]
title: "Better Xcode warnings through .xcconfig files"
---
Peter Hosey <a href="http://boredzo.org/blog/archives/2009-11-07/warnings">posted a list of warnings he turns on</a>. Here's the warnings I turn on. It's mostly the same list.

Rather than set these per project, I have a .xcconfig file I add to my project. I then base each build configuration off this file. Changing the .xcconfig file changes all projects based on it (though with the current Xcode, it's sometimes necessary to reload the project to get the settings to take).

	//
	//  MoreWarnings.xcconfig
	//
	//  Created by Steven Fisher:
	//      http://tewha.net/2010/11/xcode-warnings/
	//  See also:
	//      http://boredzo.org/blog/archives/2009-11-07/warnings
	//
	
	GCC_WARN_CHECK_SWITCH_STATEMENTS = YES
	GCC_WARN_SHADOW = YES
	GCC_WARN_64_TO_32_BIT_CONVERSION = YES
	GCC_WARN_INITIALIZER_NOT_FULLY_BRACKETED = YES
	GCC_WARN_ABOUT_RETURN_TYPE = YES
	GCC_WARN_MISSING_PARENTHESES = YES
	GCC_WARN_ABOUT_MISSING_FIELD_INITIALIZERS = YES
	GCC_WARN_ABOUT_MISSING_NEWLINE = YES
	GCC_WARN_SIGN_COMPARE = YES
	GCC_WARN_UNDECLARED_SELECTOR = YES
	GCC_WARN_UNUSED_FUNCTION = YES
	GCC_WARN_UNUSED_LABEL = YES
	GCC_WARN_UNUSED_VALUE = YES
	GCC_WARN_UNUSED_VARIABLE = YES
	GCC_WARN_ABOUT_MISSING_PROTOTYPES = YES
	GCC_WARN_TYPECHECK_CALLS_TO_PRINTF = YES
	GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS = YES
	GCC_WARN_HIDDEN_VIRTUAL_FUNCTIONS = YES
	GCC_WARN_ABOUT_INVALID_OFFSETOF_MACRO = YES
	GCC_WARN_NON_VIRTUAL_DESTRUCTOR = YES
	GCC_TREAT_WARNINGS_AS_ERRORS = YES
	RUN_CLANG_STATIC_ANALYZER = YES

Peter wrote a great explanation of why you'd want most of these warnings, which I'm not going to attempt. I've added some C++ warnings, too. They don't do anything with clang 1.6, but might be useful in the future.

A few notes:

* Like Peter, I don't turn on `GCC_WARN_UNUSED_PARAMETER`. Although you can add `__unused` to each parameter to disable the warning, doing so breaks Xcode's code formatting. I use code formatting constantly, so anything that breaks it isn't acceptable.
* The warnings that were the most painful to turn on were `GCC_WARN_64_TO_32_BIT_CONVERSION` and `GCC_WARN_SIGN_COMPARE`. If you use `int` and `NSInteger` interchangeably, you're going to have a tough time with these. (I don't, but some of the internal libraries I use do.) These are also some of the more dangerous warnings to fix; if you've got automated tests, you should run them after every few corrections.
* `RUN_CLANG_STATIC_ANALYZER` will roughly double (or more) the time your project takes to compile. I consider this a good trade: I rarely trigger a static analyzer warning now, but when I do I want to fix it.
* Also note the `GCC_TREAT_WARNINGS_AS_ERRORS`. If you are applying these to an existing project, you may start with hundreds of warnings. You'll probably want to start with this set to `NO` and change it to `YES` after you've fixed the warnings.
* Remember, too, that this changes the **defaults** for settings. You can still specify different settings in the build configuration! If the static analyzer is taking too long to run in one project, just turn it off in that one project but leave the .xcconfig file alone!
