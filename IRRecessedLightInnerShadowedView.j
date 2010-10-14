//	IRRecessedLightInnerShadowedView.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRRecessedLightInnerShadowedView : IRStyledView {
	
	CPView backgroundViewBaseView;
	
}





- (IRRecessedLightInnerShadowedView) initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame]; if (self == nil) return nil;

	var topBackdropView = [[CPImageView alloc] initWithFrame:CGRectMake(0, -16, frame.size.width, 32)];
	[self addSubview:topBackdropView];
	[topBackdropView setImage:[CPImage imageNamed:@"IRRecessedLightInnerShadowedView.topBackdrop.png" inBundleOf:self]];
	[topBackdropView setAutoresizingMask:CPViewWidthSizable|CPViewMaxYMargin];
	[topBackdropView setHitTests:NO];

	var bottomBackdropView = [[CPImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - 16, frame.size.width, 32)];
	[self addSubview:bottomBackdropView];
	[bottomBackdropView setImage:[CPImage imageNamed:@"IRRecessedLightInnerShadowedView.bottomBackdrop.png" inBundleOf:self]];
	[bottomBackdropView setAutoresizingMask:CPViewWidthSizable|CPViewMinYMargin];
	[bottomBackdropView setHitTests:NO];

	[self setClipsToBounds:NO];
	
//	[self setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];

	return self;
	
}





@end