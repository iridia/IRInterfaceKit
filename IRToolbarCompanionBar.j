//	IRToolbarCompanionBar.j
	
@import <CGGeometry+IRAdditions/CGGeometry+IRAdditions.j>
@import "CPView+IRInterfaceKitAdditions.j"
@import "IRButtonBar.j"





@implementation IRToolbarCompanionBar : IRButtonBar 





- (id) initWithFrame:(CGRect)aFrame {

	self = [super initWithFrame:aFrame]; if (self == nil) return nil;

	[backgroundView setBackgroundPatternImageNamed:@"IRToolbarCompanionBar.backdrop" sender:self];
	[backgroundView setFrame:CGRectOffset(CGRectMake(0, 0, aFrame.size.width, aFrame.size.height), CGRectOffsetMake(22, 0, 32, 0))];

	[backgroundView setAutoresizingMask:CPViewWidthSizable];

	return self;

}





@end