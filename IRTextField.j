//	IRTextField.j
//	Evadne Wu at Iridia, 2010
	
@import <AppKit/CPTextField.j>
@import <AppKit/_CPImageAndTextView.j>
	
	
	
	
	
@implementation IRTextField : CPTextField

- (void) setFrameSize:(CGSize)inSize {
	
	var	realSize = inSize,
		minSize = [self currentValueForThemeAttribute:@"min-size"],
		maxSize = [self currentValueForThemeAttribute:@"max-size"],
		font = [self currentValueForThemeAttribute:@"font"];
	
	if (!inSize || isNaN(inSize.width) || isNaN(inSize.height)) {
		
		if (!minSize) {
		
			realSize = [CPPlatformString sizeOfString:[self stringValue] withFont:font forWidth:null];
		
		} else {
			
			realSize = minSize;
			
		}
		
	}
	
	if (minSize) {
	
		if (minSize.width >= 0.0) realSize.width = MAX(realSize.width, minSize.width);
		if (minSize.height >= 0.0) realSize.height = MAX(realSize.height, minSize.height);
	
	}

	if (maxSize) {

		if (maxSize.width >= 0.0) realSize.width = MIN(realSize.width, maxSize.width);
		if (maxSize.height >= 0.0) realSize.height = MIN(realSize.height, maxSize.height);
	
	}
	
	[super setFrameSize:realSize];
	[self layoutSubviews];

}

- (CPView) createEphemeralSubviewNamed:(CPString)aName {
	
	if (aName == @"content-view") {
		
		var view = [[_IRImageAndTextView alloc] initWithFrame:CGRectMakeZero()];
		[view setHitTests:NO];
		return view;		
		
	}
	
	return [super createEphemeralSubviewNamed:aName];
	
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
		
		stringSize = sizeOfString(_text),
		
		assignText = function (inElement, inString) {

			if (CPFeatureIsCompatible(CPJavascriptInnerTextFeature)) {

				inElement.innerText = inString;

			} else if (CPFeatureIsCompatible(CPJavascriptTextContentFeature)) {

				inElement.textContent = inString;

			}

		}		
		
	var shouldTruncate = !!(stringSize.width > textRectSize.width);	
	if (!shouldTruncate) {
	
		if (_DOMTextElement) assignText(_DOMTextElement, _text);
		if (_DOMTextShadowElement) assignText(_DOMTextShadowElement, _text);
		
		return;
		
	}
		
		
	var	ellipsisSize = sizeOfString(@"…"),
		
		allowedStringWidth = textRectSize.width,
		
		stringFits = function (inString) {
		
			return !!( ((sizeOfString(inString)).width + ellipsisSize.width) <= allowedStringWidth );
			
		};
			
	switch (_lineBreakMode) {
		
	case CPLineBreakByTruncatingMiddle:
	
		var	prefixString = _text.substring(0, FLOOR(_text.length / 2)),
			suffixString = _text.substring(prefixString.length, _text.length),
			finalString = prefixString + "…" + suffixString,
			trimmingPrefix = true;

		while (!stringFits(finalString))
		if (finalString.length != 0) {
			
			if (trimmingPrefix)
			if (prefixString.length != 0)
			prefixString = prefixString.substring(0, prefixString.length - 1);
			
			if (!trimmingPrefix)
			if (suffixString.length != 0)
			suffixString = suffixString.substring(1, suffixString.length);
			
			trimmingPrefix = !trimmingPrefix;
			finalString = prefixString + "…" + suffixString;
			
		}

		break;
	
	case CPLineBreakByTruncatingHead:
	
		var finalString = _text;

		while (!stringFits(finalString))
		if (finalString.length != 0)
		finalString = finalString.substring(1, finalString.length);
	
		finalString = (finalString == "") ? _text : ("…" + finalString);
	
		break;

	case CPLineBreakByTruncatingTail:
	
		var finalString = _text;
	
		while (!stringFits(finalString))
		if (finalString.length != 0)
		finalString = finalString.substring(0, finalString.length - 1);
		
		finalString = (finalString == "") ? _text : (finalString + "…");
		break;
		
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




