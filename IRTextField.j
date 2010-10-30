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





@implementation _IRImageAndTextView : _CPImageAndTextView

- (void) layoutSubviews {

	[super layoutSubviews];
	
	if (_lineBreakMode != CPLineBreakByTruncatingHead)
	if (_lineBreakMode != CPLineBreakByTruncatingMiddle)
	if (_lineBreakMode != CPLineBreakByTruncatingTail)
	return;
		
	if (!_DOMTextElement)
	return;
		
		
	var	textStyle = (_DOMTextElement && _DOMTextElement.style) || nil,
		
		intFromPixels = function (inString) {
		
			return parseInt(inString.replace(/px/, ""), 10);
		
		},
		
		sizeOfString = function (inString) {
			
			return [CPPlatformString sizeOfString:inString withFont:_font forWidth:NULL];
			
		},
		
		textRectSize = CGSizeMake(
			
			intFromPixels(textStyle.width), intFromPixels(textStyle.height)
			
		),
		
		stringSize = sizeOfString(_text);
		
		
	var shouldTruncate = !!(stringSize.width > textRectSize.width);
	if (!shouldTruncate) return;
		
		
	var	ellipsisSize = sizeOfString(@"…"),
		
		allowedStringWidth = textRectSize.width - ellipsisSize.width,
		
		stringFits = function (inString) {
			
			return !!( ((sizeOfString(inString)).width + ellipsisSize.width) <= allowedStringWidth );
			
		},
		
		finalString = _text;
		
		
	switch (_lineBreakMode) {
		
	case CPLineBreakByTruncatingMiddle:
	case CPLineBreakByTruncatingHead:
	case CPLineBreakByTruncatingTail:
		
		while (!stringFits(finalString))
		if (finalString.length != 0)
		finalString = finalString.substring(0, finalString.length - 1);
		
		finalString = (finalString == "") ? _text : (finalString + "…");
		
	}
		
	var assignText = function (inElement, inString) {
		
		if (CPFeatureIsCompatible(CPJavascriptInnerTextFeature)) {
			
			inElement.innerText = inString;
			
		} else if (CPFeatureIsCompatible(CPJavascriptTextContentFeature)) {
			
			inElement.textContent = inString;
		
		}
		
	}
		
	if (_DOMTextElement) assignText(_DOMTextElement, finalString);
	if (_DOMTextShadowElement) assignText(_DOMTextShadowElement, finalString);
	
}

@end




