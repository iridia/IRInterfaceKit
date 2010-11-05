//	IRDarkRadio.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRDarkRadio : CPRadio

- (id) initWithFrame:(CGRect)inFrame {
	
	self = [super initWithFrame:inFrame]; if (!self) return nil;
	
	[self setValue:CGSizeMake(0.0, 32.0) forThemeAttribute:@"min-size"];
	[self setValue:CGSizeMake(-1.0, -1.0) forThemeAttribute:@"max-size"];
	
	var img = function (inName) {
		
		return [CPImage imageNamed:@"IRDarkRadio." + inName + @".png" size:CGSizeMake(32.0, 32.0) inBundleOf:IRDarkRadio];
		
	};
	
	
	[self setValue:img(@"backdrop") forThemeAttribute:@"image"];
	[self setValue:img(@"selected.backdrop") forThemeAttribute:@"image" inState:CPThemeStateSelected];
	[self setValue:img(@"selected.highlighted.backdrop") forThemeAttribute:@"image" inState:CPThemeStateSelected|CPThemeStateHighlighted];
	[self setValue:img(@"highlighted.backdrop") forThemeAttribute:@"image" inState:CPThemeStateHighlighted];
	[self setValue:img(@"disabled.backdrop") forThemeAttribute:@"image" inState:CPThemeStateDisabled];
	[self setValue:img(@"selected.disabled.backdrop") forThemeAttribute:@"image" inState:CPThemeStateSelected|CPThemeStateDisabled];
	
	[self setValue:8.0 forThemeAttribute:@"image-offset"];
	[self setValue:CGInsetMake(0, 0, 0, 0) forThemeAttribute:@"content-inset"];
	[self setValue:CGInsetMake(0, 0, 0, 0) forThemeAttribute:@"bezel-inset"];
	
	[self setValue:[CPFont boldSystemFontOfSize:11.0] forThemeAttribute:@"font"];
	[self setValue:CPLeftTextAlignment forThemeAttribute:@"alignment"];
	[self setValue:[CPColor colorWithWhite:0.65 alpha:1.0] forThemeAttribute:@"text-color"];
	[self setValue:[CPColor colorWithWhite:1.0 alpha:1.0] forThemeAttribute:@"text-color" inState:CPThemeStateSelected];
	[self setValue:[CPColor colorWithWhite:0.45 alpha:0.5] forThemeAttribute:@"text-color" inState:CPThemeStateDisabled];

	[self setValue:[CPColor clearColor] forThemeAttribute:@"text-shadow-color"];
	
	return self;
	
}

@end