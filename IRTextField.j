//	IRTextField.j
//	Evadne Wu at Iridia, 2010
	
@import <AppKit/CPTextField.j>
@import <AppKit/_CPImageAndTextView.j>
	
	
	
	
	
@implementation IRTextField : CPTextField

- (void) setFrameSize:(CGSize)inSize {
	
	var realSize = inSize,
	minSize = [self currentValueForThemeAttribute:@"min-size"],
	maxSize = [self currentValueForThemeAttribute:@"max-size"];
	
	if (maxSize.width >= 0.0) realSize.width = MIN(realSize.width, maxSize.width);
	if (maxSize.height >= 0.0) size.height = MIN(realSize.height, maxSize.height);

	[super setFrameSize:realSize];
	
}

- (CPView) createEphemeralSubviewNamed:(CPString)aName {
	
	var view = [super createEphemeralSubviewNamed:aName];
	if (![view isMemberOfClass:[_CPImageAndTextView class]])
	return view;
	
	view = [[_IRImageAndTextView alloc] initWithFrame:CGRectMakeZero()];
	[view setHitTests:NO];
	return view;

}

@end




var	_IRImageAndTextViewTruncateTailBinding = [CPString stringWithFormat:
	
		"url(%@#delimitText)", 
		[[CPBundle bundleForClass:[IRTextField class]] pathForResource:@"IRMozillaBindings.xml"]
			
	];

@implementation _IRImageAndTextView : _CPImageAndTextView

- (void) layoutSubviews {

	[super layoutSubviews];
	
	var textStyle = (!!_DOMTextElement) ? _DOMTextElement.style : nil;
	if (!textStyle) return;
	
	if (textStyle)
	textStyle.MozBinding = (textStyle.textOverflow == "ellipsis") ? _IRImageAndTextViewTruncateTailBinding : "";

	var shadowStyle = (!!_DOMTextShadowElement) ? _DOMTextShadowElement.style : nil;

	if (shadowStyle)
	shadowStyle.MozBinding = (shadowStyle.textOverflow == "ellipsis") ? _IRImageAndTextViewTruncateTailBinding : "";
	
}

@end




