#	IRInterfaceKit

UI Toolkit for Cappuccino.  Requires [CGGeometry+IRAdditions](http://github.com/iridia/CGGeometry-IRAdditions) and optionally [IRDelegation](http://github.com/iridia/IRDelegation).  Drop this project into your Cappuccino project as a submodule in Frameworks and say

	@import <IRInterfaceKit/IRInterfaceKit.j>

in your app delegate, or anywhere you’ll use the controls and all will be fine.  This project is a mix between a heavy pile of custom pixels and a bit of interactivity code, and is put upon the public domain in hope that it would be useful.  Some classes that are not explicitly documented may not be implemented, but the existence of their names signifies that they will be implemented as our projects using the kit mature.


##	What’s inside

*	Styled views.  The `IRStyledView` is a starting point for a lot of styled views.
*	HUD-style buttons, text and search fields.
*	iOS-style scroll views.

*	`IRButtonBar` which keeps left-, center- and right-aligned views.
*	An `IRActionSheetController` that controls an action sheet (undergoing development).

*	Original design document.




