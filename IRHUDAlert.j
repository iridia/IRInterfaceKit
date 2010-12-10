//	IRHUDAlert.j
//	Evande Wu at Iridia, 2010
	
	
	
	
	
@import <AppKit/CPAlert.j>
	
	
	
	
	
@implementation IRHUDAlert : CPAlert

- (id) init {
	
	self = [super init];
	if (!self) return nil;
	
	[self setTheme:[CPTheme defaultHudTheme]];
	
	return self;
	
}

- (void) _createWindowWithStyle:(int)forceStyle {
	
	[super _createWindowWithStyle:(forceStyle|CPHUDBackgroundWindowMask)];

}

@end