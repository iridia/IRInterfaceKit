//	IRDarkPopUpButton.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
	kIRDarkDefaultPopUpButtonStyle = @"IRDarkPopUpButton";
	
	
	
	
	
@implementation IRDarkPopUpButton : CPPopUpButton {
	
	IRDarkPopUpButtonStyle style;
	
}





+ (CGInset) insetsForStyle:(IRDarkPopUpButtonStyle)style {
	
	switch (style) {
		
		case kIRDarkDefaultPopUpButtonStyle:
		return {
				
			bezelColor: CGInsetMake(0, 24, 0, 8),
			bezel: CGInsetMake(-6, -4, -6, -4),
			content: CGInsetMake(0, 16, 0, 8),
			activeCcontent: CGInsetMake(0, 16, 0, 8)
		
		}
		
	}
	
	return null;
	
}





+ (id) buttonWithTitle:(CPString)inTitle {

	CPLog(@"kIRDarkDefaultPopUpButtonStyle is %@", kIRDarkDefaultPopUpButtonStyle);
	return [self buttonWithTitle:inTitle style:kIRDarkDefaultPopUpButtonStyle];

}

+ (id) buttonWithTitle:(CPString)inTitle style:(IRDarkPopUpButtonStyle)inStyle {

	var button = [super buttonWithTitle:inTitle theme:[CPTheme defaultTheme]]; if (button == nil) return nil;
	
	style = inStyle;
	
	var bundle = [CPBundle bundleForClass:[self class]];
	var insets = [self insetsForStyle:inStyle];
	
	var bezelColorInset = insets.bezelColor;
	var bezelInset = insets.bezel;
	var contentInset = insets.content;
	var activeContentInset = insets.activeCcontent;
	
	var color = function (inSuffix) {
		
		return [CPColor colorWithPatternImage:[CPNinePartImage imageWithBaseName:[style stringByAppendingString:inSuffix] inBundle:[CPBundle bundleForClass:[self class]] withInset:bezelColorInset]];
		
	}
	
	[button setValue:color(@".backdrop") forThemeAttribute:@"bezel-color"];
	[button setValue:color(@".backdrop.active") forThemeAttribute:@"bezel-color" inState:CPThemeStateHighlighted];
	[button setValue:color(@".backdrop.disabled") forThemeAttribute:@"bezel-color" inState:CPThemeStateDisabled];
	[button setValue:bezelInset forThemeAttribute:@"bezel-inset"];
	[button setValue:contentInset forThemeAttribute:@"content-inset"];
	[button setValue:activeContentInset forThemeAttribute:@"content-inset" inState:CPThemeStateHighlighted];
	
	[button setValue:[CPFont systemFontOfSize:11.0] forThemeAttribute:@"font"];
	[button setValue:CPCenterTextAlignment forThemeAttribute:@"alignment"];
	[button setValue:[CPColor colorWithWhite:1.0 alpha:1.0] forThemeAttribute:@"text-color"];
	[button setValue:[CPColor colorWithWhite:0.95 alpha:0.5] forThemeAttribute:@"text-color" inState:CPThemeStateDisabled];

	[button setValue:[CPColor clearColor] forThemeAttribute:@"text-shadow-color"];
	
	[button setValue:CGSizeMake(16.0, 18.0) forThemeAttribute:@"min-size"];
	[button setValue:CGSizeMake(-1.0, 18.0) forThemeAttribute:@"max-size"];
	
	[button setClipsToBounds:NO];
	
	return button;
	
}

@end