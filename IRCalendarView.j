//	IRCalendarView.j
//	Evadne Wu at Iridia, 2010
	
@import <LPKit/LPCalendarView.j>
	
	
	
	
	
@implementation IRCalendarView : LPCalendarView

+ (id) calendarView {
	
	calendarView = [[IRCalendarView alloc] initWithFrame:CGRectMake(0, 0, 7 * 24, 7 * 24)];
	[calendarView setValue:CGSizeMake(24, 24) forThemeAttribute:@"tile-size" inState:CPThemeStateNormal];
	[calendarView setValue:24 forThemeAttribute:@"header-height" inState:CPThemeStateNormal];
	
	if (!calendarView) return nil;
	
	var bezelColor = [CPColor colorWithPatternImage:[CPNinePartImage imageWithBaseName:@"IRDarkerBeigeBox.backdrop" inBundle:[CPBundle bundleForClass:[IRBeigeBox class]] withInset:CGInsetMake(24, 24, 24, 24)]];
	
	[calendarView setValue:[CPColor colorWithWhite:1.0 alpha:0.45] forThemeAttribute:@"grid-color"];
	[calendarView setValue:[CPColor colorWithWhite:0.0 alpha:0.25] forThemeAttribute:@"grid-shadow-color"];

	[calendarView setValue:bezelColor forThemeAttribute:@"bezel-color"];
	[calendarView setValue:CGInsetMake(-16, -16, -16, -16) forThemeAttribute:@"bezel-inset"];

	[calendarView setValue:[CPColor greenColor] forThemeAttribute:@"header-background-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPFont boldSystemFontOfSize:11.0] forThemeAttribute:@"header-font" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor colorWithHexString:@"333"] forThemeAttribute:@"header-text-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor whiteColor] forThemeAttribute:@"header-text-shadow-color" inState:CPThemeStateNormal];
	[calendarView setValue:CGSizeMake(1.0, 1.0) forThemeAttribute:@"header-text-shadow-offset" inState:CPThemeStateNormal];
	[calendarView setValue:CPCenterTextAlignment forThemeAttribute:@"header-alignment" inState:CPThemeStateNormal];

	[calendarView setValue:CGSizeMake(0.0, 0.0) forThemeAttribute:@"header-button-offset" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor redColor] forThemeAttribute:@"header-prev-button-image" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor blueColor] forThemeAttribute:@"header-next-button-image" inState:CPThemeStateNormal];

	[calendarView setValue:0 forThemeAttribute:@"header-weekday-offset" inState:CPThemeStateNormal];
	[calendarView setValue:[CPFont systemFontOfSize:9.0] forThemeAttribute:@"header-weekday-label-font" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"header-weekday-label-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"header-weekday-label-shadow-color" inState:CPThemeStateNormal];
	[calendarView setValue:CGSizeMakeZero() forThemeAttribute:@"header-weekday-label-shadow-offset" inState:CPThemeStateNormal];

	[calendarView setValue:[CPFont boldSystemFontOfSize:11.0] forThemeAttribute:@"tile-font"];
	[calendarView setValue:[CPColor colorWithHexString:@"444"] forThemeAttribute:@"tile-text-color"];
	[calendarView setValue:[CPColor colorWithWhite:1 alpha:0.65] forThemeAttribute:@"tile-text-shadow-color"];
	
	[calendarView setValue:CGSizeMake(0.0, 1.0) forThemeAttribute:@"tile-text-shadow-offset" inState:CPThemeStateNormal];

	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateHighlighted];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"tile-text-shadow-color" inState:CPThemeStateHighlighted];

	[calendarView setValue:[CPColor colorWithWebRed:124 green:137 blue:166 alpha:1] forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateSelected];
	[calendarView setValue:[CPColor whiteColor] forThemeAttribute:@"tile-text-color" inState:CPThemeStateSelected];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"tile-text-shadow-color" inState:CPThemeStateSelected];	

	[calendarView setValue:[CPColor colorWithWhite:0 alpha:0.3] forThemeAttribute:@"tile-text-color" inState:CPThemeStateDisabled];

	return calendarView;	
	
}

@end




