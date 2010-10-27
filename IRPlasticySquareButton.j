//	IRPlasticySquareButton.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
	kIRPlasticyDefaultSquareButtonStyle = @"IRPlasticySquareButton";
	
	
	
	
	
@implementation IRPlasticySquareButton : CPButton {
	
	IRPlasticyButtonStyle style;
	
}





+ (id) themeAttributes {
	
	var attributes = [[super themeAttributes] mutableCopy];
	if (![attributes isKindOfClass:[CPDictionary class]]) return attributes;
	
	[attributes setObject:[CPNull null] forKey:@"image"];
	
	return attributes;
	
}




+ (CGInset) insetsForStyle:(IRPlasticyButtonStyle)style {
	
	switch (style) {
		
		case kIRPlasticyDefaultSquareButtonStyle:
		return {
				
			bezelColor: CGInsetMake(16, 16, 16, 16),
			bezel: CGInsetMake(-8, -8, -8, -8),
			content: CGInsetMake(0, 16, 0, 16),
			activeCcontent: CGInsetMake(0, 16, 0, 16)
		
		}
		
	}
	
	return null;
	
}





+ (id) buttonWithTitle:(CPString)inTitle {

	return [self buttonWithTitle:inTitle style:kIRPlasticyDefaultSquareButtonStyle];

}

+ (id) buttonWithTitle:(CPString)inTitle style:(IRPlasticyButtonStyle)inStyle {

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
	
	[button setValue:[CPFont systemFontOfSize:13.0] forThemeAttribute:@"font"];
	[button setValue:[CPColor colorWithWhite:1.0 alpha:1.0] forThemeAttribute:@"text-color"];
	[button setValue:[CPColor colorWithWhite:0.95 alpha:0.5] forThemeAttribute:@"text-color" inState:CPThemeStateDisabled];

	[button setValue:[CPColor clearColor] forThemeAttribute:@"text-shadow-color"];
	
	[button setValue:CGSizeMake(0.0, 24.0) forThemeAttribute:@"min-size"];
	[button setValue:CGSizeMake(-1.0, 24.0) forThemeAttribute:@"max-size"];
	
	[button setClipsToBounds:NO];
	
	return button;
	
}

+ (id) incrementButton {
		
	self = [self buttonWithTitle:nil style:kIRPlasticyDefaultSquareButtonStyle];
	if (self == nil) return nil;
	
	[self setImage:[CPImage imageNamed:@"IRInterfaceKit.common.add.mini.png" inBundleOf:self]];
	[self setValue:[CPImage imageNamed:@"IRInterfaceKit.common.add.mini.disabled.png" inBundleOf:self] forThemeAttribute:@"image" inState:CPThemeStateDisabled];
	[self setValue:CPImageOnly forThemeAttribute:@"image-position"];
	[self setValue:CGInsetMake(0, 0, 0, 0) forThemeAttribute:@"content-inset"];
	[self setValue:CGSizeMake(24.0, 24.0) forThemeAttribute:@"min-size"];
	[self setValue:CGSizeMake(24.0, 24.0) forThemeAttribute:@"max-size"];

	return self;
	
}

+ (id) decrementButton {
	
	self = [self buttonWithTitle:nil style:kIRPlasticyDefaultSquareButtonStyle];
	if (self == nil) return nil;
	
	[self setImage:[CPImage imageNamed:@"IRInterfaceKit.common.minus.mini.png" inBundleOf:self]];
	[self setValue:[CPImage imageNamed:@"IRInterfaceKit.common.minus.mini.disabled.png" inBundleOf:self] forThemeAttribute:@"image" inState:CPThemeStateDisabled];
	[self setValue:CPImageOnly forThemeAttribute:@"image-position"];
	[self setValue:CGInsetMake(0, 0, 0, 0) forThemeAttribute:@"content-inset"];
	[self setValue:CGSizeMake(24.0, 24.0) forThemeAttribute:@"min-size"];
	[self setValue:CGSizeMake(24.0, 24.0) forThemeAttribute:@"max-size"];

	return self;
	
}

+ (id) locateButton {
	
	self = [self buttonWithTitle:nil style:kIRPlasticyDefaultSquareButtonStyle];
	if (self == nil) return nil;
	
	[self setImage:[CPImage imageNamed:@"IRInterfaceKit.common.locate.mini.png" inBundleOf:self]];
	[self setValue:[CPImage imageNamed:@"IRInterfaceKit.common.locate.mini.disabled.png" inBundleOf:self] forThemeAttribute:@"image" inState:CPThemeStateDisabled];
	[self setValue:CPImageOnly forThemeAttribute:@"image-position"];
	[self setValue:CGInsetMake(0, 0, 0, 0) forThemeAttribute:@"content-inset"];
	[self setValue:CGSizeMake(24.0, 24.0) forThemeAttribute:@"min-size"];
	[self setValue:CGSizeMake(24.0, 24.0) forThemeAttribute:@"max-size"];

	return self;
	
}

@end