//	IRDarkTextField.j
//	Evadne Wu at Iridia, 2010
	
	
	
		
	
@implementation IRDarkTextField : IRTextField

+ (IRDarkTextField) textFieldWithStringValue:(CPString)aStringValue placeholder:(CPString)aPlaceholder width:(float)aWidth {

	var textField = [super textFieldWithStringValue:aStringValue placeholder:aPlaceholder width:aWidth theme:[CPTheme defaultTheme]]
	[textField setFrame:CGRectMake(0.0, 0.0, aWidth, 32.0)];
	
	[textField setValue:[CPColor blueColor] forThemeAttribute:@"bezel-color"];
	[textField setBezeled:YES];	
	
	[textField setValue:[CPColor colorWithPatternImage:[CPNinePartImage imageWithBaseName:@"IRDarkTextField.backdrop" inBundleOf:self withInset:CGInsetMake(8, 8, 8, 8)]] forThemeAttribute:@"bezel-color"];
	[textField setValue:[CPColor colorWithPatternImage:[CPNinePartImage imageWithBaseName:@"IRDarkTextField.backdrop.active" inBundle:[CPBundle bundleForClass:[self class]] withInset:CGInsetMake(8, 8, 8, 8)]] forThemeAttribute:@"bezel-color" inState:CPThemeStateEditing];
		
	[textField setValue:CGInsetMake(4, 4, 4, 4) forThemeAttribute:@"content-inset"];
	[textField setValue:CGInsetMake(6, 4, 4, 4) forThemeAttribute:@"content-inset" inState:CPThemeStateEditing];
	[textField setValue:CGInsetMake(-4, -4, -4, -4) forThemeAttribute:@"bezel-inset"];

	[textField setValue:[CPFont boldSystemFontOfSize:12.0] forThemeAttribute:@"font"];	
	[textField setValue:CPCenterTextAlignment forThemeAttribute:@"alignment"];
	[textField setValue:CPCenterVerticalTextAlignment forThemeAttribute:@"vertical-alignment"];
	[textField setValue:CPLineBreakByTruncatingTail forThemeAttribute:@"line-break-mode"];

	[textField setValue:[CPColor colorWithWhite:1 alpha:1] forThemeAttribute:"text-color"];
	[textField setValue:[CPColor colorWithWhite:1 alpha:.75] forThemeAttribute:@"text-color" inState:CPTextFieldStatePlaceholder];
	
//	[textField sizeToFit];
	
	[textField setClipsToBounds:NO];
	
	return textField;

}

@end