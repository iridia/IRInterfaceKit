//	IRCalendarView.j
//	Evadne Wu at Iridia, 2010
	
@import <LPKit/LPCalendarView.j>
	
	
	
	
	
@implementation IRCalendarView : LPCalendarView

+ (id) calendarView {
	
	calendarView = [[IRCalendarView alloc] initWithFrame:CGRectMake(0, 0, 7 * 24, 7 * 24)];
	[calendarView setValue:CGSizeMake(24, 24) forThemeAttribute:@"tile-size" inState:CPThemeStateNormal];
	[calendarView setValue:24 forThemeAttribute:@"header-height" inState:CPThemeStateNormal];
	
	if (!calendarView) return nil;
	
	[calendarView setValue:[CPColor colorWithWhite:0.0 alpha:0.25] forThemeAttribute:@"grid-color"];
	[calendarView setValue:[CPColor colorWithWhite:1.0 alpha:0.75] forThemeAttribute:@"grid-shadow-color"];

	[calendarView setValue:[CPColor yellowColor] forThemeAttribute:@"bezel-color"];

	[calendarView setValue:[CPColor greenColor] forThemeAttribute:@"header-background-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPFont boldSystemFontOfSize:11.0] forThemeAttribute:@"header-font" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor colorWithHexString:@"333"] forThemeAttribute:@"header-text-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor whiteColor] forThemeAttribute:@"header-text-shadow-color" inState:CPThemeStateNormal];
	[calendarView setValue:CGSizeMake(1.0, 1.0) forThemeAttribute:@"header-text-shadow-offset" inState:CPThemeStateNormal];
	[calendarView setValue:CPCenterTextAlignment forThemeAttribute:@"header-alignment" inState:CPThemeStateNormal];

	[calendarView setValue:CGSizeMake(0.0, 0.0) forThemeAttribute:@"header-button-offset" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor redColor] forThemeAttribute:@"header-prev-button-image" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor blueColor] forThemeAttribute:@"header-next-button-image" inState:CPThemeStateNormal];

	// Weekday labels
	[calendarView setValue:0 forThemeAttribute:@"header-weekday-offset" inState:CPThemeStateNormal];
	[calendarView setValue:[CPFont systemFontOfSize:9.0] forThemeAttribute:@"header-weekday-label-font" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"header-weekday-label-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"header-weekday-label-shadow-color" inState:CPThemeStateNormal];
	[calendarView setValue:CGSizeMake(0.0, 1.0) forThemeAttribute:@"header-weekday-label-shadow-offset" inState:CPThemeStateNormal];

	/* Day Tile View
*/
	// Normal
	var bezelColor = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:
	[
	[_CPCibCustomResource imageResourceWithName:@"LPCalendarView/default-tile-bezel-left.png" size:CGSizeMake(1.0, 21.0)],
	[_CPCibCustomResource imageResourceWithName:@"LPCalendarView/default-tile-bezel-center.png" size:CGSizeMake(21.0, 21.0)],
	nil
	]
	isVertical:NO]];

	[calendarView setValue:[CPFont boldSystemFontOfSize:11.0] forThemeAttribute:@"tile-font" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor colorWithHexString:@"333"] forThemeAttribute:@"tile-text-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor colorWithWhite:1 alpha:0.8] forThemeAttribute:@"tile-text-shadow-color" inState:CPThemeStateNormal];
	[calendarView setValue:CGSizeMake(1.0, 1.0) forThemeAttribute:@"tile-text-shadow-offset" inState:CPThemeStateNormal];

	[calendarView setValue:bezelColor forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateNormal];

	// Highlighted
	var highlightedBezelColor = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:
	[
	nil,
	[_CPCibCustomResource imageResourceWithName:@"LPCalendarView/highlighted-tile-bezel.png" size:CGSizeMake(21.0, 21.0)],
	nil
	]
	isVertical:NO]];
	[calendarView setValue:highlightedBezelColor forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateHighlighted];        
	[calendarView setValue:[CPColor colorWithHexString:@"555"] forThemeAttribute:@"tile-text-color" inState:CPThemeStateHighlighted];

	// Selected
	var selectedBezelColor = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:
	[
	nil,
	[_CPCibCustomResource imageResourceWithName:@"LPCalendarView/selected-tile-bezel.png" size:CGSizeMake(15.0, 15.0)],
	nil
	]
	isVertical:NO]];

	[calendarView setValue:[CPColor colorWithHexString:@"fff"] forThemeAttribute:@"tile-text-color" inState:CPThemeStateSelected];
	[calendarView setValue:[CPColor colorWithWhite:0 alpha:0.4] forThemeAttribute:@"tile-text-shadow-color" inState:CPThemeStateSelected];
	[calendarView setValue:selectedBezelColor forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateSelected];

	var selectedHighlightedBezelColor = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:[nil, [_CPCibCustomResource imageResourceWithName:@"LPCalendarView/selected-highlighted-tile-bezel.png" size:CGSizeMake(15.0, 15.0)], nil] isVertical:NO]];
	[calendarView setValue:selectedHighlightedBezelColor forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateHighlighted | CPThemeStateSelected];

	[calendarView setValue:[CPColor colorWithWhite:0 alpha:0.3] forThemeAttribute:@"tile-text-color" inState:CPThemeStateDisabled];

	var disabledSelectedBezelColor = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:[nil, [_CPCibCustomResource imageResourceWithName:@"LPCalendarView/selected-disabled-tile-bezel.png" size:CGSizeMake(21.0, 21.0)], nil] isVertical:NO]];
	
	[calendarView setValue:disabledSelectedBezelColor forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateSelected|CPThemeStateDisabled];
	[calendarView setValue:[CPColor colorWithWhite:0 alpha:0.4] forThemeAttribute:@"tile-text-color" inState:CPThemeStateSelected|CPThemeStateDisabled];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"tile-text-shadow-color" inState:CPThemeStateSelected|CPThemeStateDisabled];

	return calendarView;	
	
}

@end




