//	IRMenuItem.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRMenuItem : CPMenuItem

- (BOOL) boolValue {
	
	return !!([self state] && CPOnState);
	
}

- (void) setBoolValue:(BOOL)inValue {
	
	[self setState:( (!!inValue) ? CPOnState : CPOffState )];
	
}

- (void) setThemeState:(id)inThemeState{

	[self willChangeValueForKey:@"boolValue"];
	[super setThemeState:inThemeState];
	[self didChangeValueForKey:@"boolValue"];
	
}

- (void) unsetThemeState:(id)inThemeState{

	[self willChangeValueForKey:@"boolValue"];
	[super unsetThemeState:inThemeState];
	[self didChangeValueForKey:@"boolValue"];
	
}

@end