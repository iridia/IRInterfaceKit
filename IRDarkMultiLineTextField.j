//	IRDarkMultiLineTextField.j
//	Evadne Wu at Iridia, 2010
	
@import <LPKit/LPMultiLineTextField.j>
	
	
	
	
	
@implementation IRDarkMultiLineTextField : LPMultiLineTextField

- (id) initWithFrame:(CGRect)inFrame {

	self = [super initWithFrame:inFrame];
	if (!self) return nil;
	
	self = [[LPMultiLineTextField alloc] initWithFrame:inFrame];
	[self setValue:[CPColor colorWithPatternImage:[CPNinePartImage imageWithBaseName:@"IRDarkTextField.backdrop" inBundleOf:IRDarkTextField withInset:CGInsetMake(8, 8, 8, 8)]] forThemeAttribute:@"bezel-color"];
	[self setValue:[CPColor colorWithPatternImage:[CPNinePartImage imageWithBaseName:@"IRDarkTextField.backdrop.active" inBundleOf:IRDarkTextField withInset:CGInsetMake(8, 8, 8, 8)]] forThemeAttribute:@"bezel-color" inState:CPThemeStateEditing];
		
	[self setValue:CGInsetMake(8, 8, 8, 8) forThemeAttribute:@"content-inset"];
	[self setValue:CGInsetMake(-4, -4, -4, -4) forThemeAttribute:@"bezel-inset"];
	
	[self setValue:[CPFont systemFontOfSize:16.0] forThemeAttribute:@"font"];
	[self setValue:[CPColor whiteColor] forThemeAttribute:@"text-color"];	
	[self setValue:[CPColor colorWithWhite:1 alpha:0.5] forThemeAttribute:@"text-color" inState:CPTextFieldStatePlaceholder];

	return self;

}

@end