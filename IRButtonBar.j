//	IRButtonBar
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRButtonBar : IRStyledView {
	
	CPMutableArray leftButtons;
	CPMutableArray centerButtons;
	CPMutableArray rightButtons;
	
	BOOL patterned;
	
	id delegate @accessors;
	
	float buttonPadding @accessors;
	float headPadding @accessors;
	float tailPadding @accessors;
	
}





- (void) initWithFrame:(CGRect)inFrame {
	
	self = [super initWithFrame:inFrame]; if (self == nil) return;
	
	buttonPadding = 16;
	headPadding = 16;
	tailPadding = 16;
	
	return self;
	
}





- (void) setPatterned:(BOOL)flag {
	
	patterned = flag;
	
	if (flag) {
		
		[self setBackgroundPatternImageNamed:@"IRActionSheet.backdrop.stripes"]
	
	} else {
		
		[self setBackgroundColor:[CPColor clearColor]];
		
	}
	
}

- (BOOL) patterned {
	
	return patterned;
	
}





- (void) removeLeftButtons {
	
	if (!leftButtons) return;
	
	var enumerator = [leftButtons objectEnumerator], object = nil;
	while (object = [enumerator nextObject]) {

		[leftButtons removeObject:object];
		[object removeObserver:self forKeyPath:@"hidden"];
		[object removeFromSuperview];
	
	}
	
	[self setNeedsLayout];
	
}

- (void) addLeftButton:(CPView)aButton {
		
	if (!leftButtons)
	leftButtons = [CPMutableArray array];
	
	[leftButtons addObject:aButton];
	[self addSubview:aButton];
	[aButton addObserver:self forKeyPath:@"hidden" options:null context:null];
	[aButton setAutoresizingMask:CPViewMaxXMargin];
	[self setNeedsLayout];
	
}





- (void) removeCenterButtons {
	
	if (!centerButtons) return;
	
	var enumerator = [centerButtons objectEnumerator], object = nil;
	while (object = [enumerator nextObject]) {

		[centerButtons removeObject:object];
		[object removeObserver:self forKeyPath:@"hidden"];
		[object removeFromSuperview];
	
	}
	
	[self setNeedsLayout];
	
}

- (void) addCenterButton:(CPView)aButton {
		
	if (!centerButtons)
	centerButtons = [CPMutableArray array];
	
	[centerButtons addObject:aButton];
	[self addSubview:aButton];
	[aButton addObserver:self forKeyPath:@"hidden" options:null context:null];
	[aButton setAutoresizingMask:CPViewMinXMargin|CPViewMaxXMargin];
	[self setNeedsLayout];
	
}





- (void) removeRightButtons {
	
	if (!rightButtons) return;
	
	var enumerator = [rightButtons objectEnumerator], object = nil;
	while (object = [enumerator nextObject]) {

		[rightButtons removeObject:object];
		[object removeObserver:self forKeyPath:@"hidden"];
		[object removeFromSuperview];
	
	}
	
	[self setNeedsLayout];
	
}

- (void) addRightButton:(CPView)aButton {
	
	if (!rightButtons)
	rightButtons = [CPMutableArray array];
	
	[rightButtons addObject:aButton];
	[self addSubview:aButton];
	[aButton addObserver:self forKeyPath:@"hidden" options:null context:null];
	[aButton setAutoresizingMask:CPViewMinXMargin];
	
	[self setNeedsLayout];
	
}





- (void) layoutSubviews {
	
	var subviews = [self subviews];
	var enumerator = [subviews objectEnumerator], object = nil;
	
	while (object = [enumerator nextObject])
	if ([leftButtons containsObject:object] || [rightButtons containsObject:object])
	[object centerVerticallyInSuperview];
	
	if ([leftButtons count] != 0) {
		
		var enumerator = [leftButtons objectEnumerator], object = nil, leftOffset = 0;
		
		var leftPadding = headPadding;
		
		while (object = [enumerator nextObject]) {
			
			if ([object isHidden]) 
			continue;
			
			[object setFrameOrigin:CGPointMake(leftOffset + leftPadding, 0)];
			
			[object centerVerticallyInSuperview];
			
			leftOffset += CGRectGetWidth([object frame]) + leftPadding;
			
			leftPadding = buttonPadding;

		}
		
	}
	
	if ([centerButtons count] != 0) {
		
		var	enumerator = [centerButtons objectEnumerator], 
			object = nil, 
			centerPoint = (CGRectGetWidth([self frame]) / 2),
			totalWidth = 0;
			
		//	Calculate the total width
		
		while (object = [enumerator nextObject]) {
			
			if ([object isHidden])
			continue;
			
			totalWidth += CGRectGetWidth([object frame]);
		
		}
		
		totalWidth += buttonPadding * ([centerButtons count] - 1);
		
		enumerator = [centerButtons objectEnumerator];
		object = nil;
		
		var startingLeftPoint = centerPoint - totalWidth * 0.5;
		
		while (object = [enumerator nextObject]) {
			
			if ([object isHidden]) continue;
			
			[object setFrameOrigin:CGPointMake(
				
				startingLeftPoint, 
				0
				
			)];
			
			[object centerVerticallyInSuperview];
			
			startingLeftPoint += CGRectGetWidth([object frame]) + buttonPadding;
			
		}
		
	}
	
	if ([rightButtons count] != 0) {
		
		var	enumerator = [rightButtons objectEnumerator], object = nil, rightOffset = 0,
			availableWidth = CGRectGetWidth([self frame]);
		
		var rightPadding = tailPadding;
		
		while (object = [enumerator nextObject]) {
			
			if ([object isHidden])
			continue;

			var objectWidth = CGRectGetWidth([object frame]);
			
			[object setFrameOrigin:CGPointMake(
				
				availableWidth - rightOffset - objectWidth - rightPadding, 
				0
				
			)];
			
			[object centerVerticallyInSuperview];
			
			rightOffset += objectWidth + rightPadding;
			
			rightPadding = buttonPadding;

		}
		
	}
	
}





- (void) sizeToFit {
	
	var	leftButtonsEnumerator = [leftButtons objectEnumerator],
		rightButtonsEnumerator = [rightButtons objectEnumerator],
		object = nil,
		totalWidth = 0;
	
	if (leftButtons) {	
		
		while (object = [leftButtonsEnumerator nextObject])
		totalWidth += CGRectGetWidth([object frame]);
		
		totalWidth += buttonPadding * ([leftButtons count] - 1);
		
	}
	
	if (rightButtons) {
		
		while (object = [rightButtonsEnumerator nextObject])
		totalWidth += CGRectGetWidth([object frame]);
		
		totalWidth += buttonPadding * ([rightButtons count] - 1);
	
	}
	
	totalWidth += headPadding;
	totalWidth += tailPadding;
	
	[self setFrameSize:CGSizeMake(totalWidth, CGRectGetHeight([self frame]))];
	
}





- (void) handleButtonClick:(id)sender {
	
	if ([[self delegate] respondsToSelector:@selector(buttonBar:didReceiveActionFromButton:)])
	[[self delegate] buttonBar:self didReceiveActionFromButton:sender];
	
}





- (void) observeValueForKeyPath:(CPString)inKeyPath ofObject:(id)inObject change:(CPDictionary)inChange context:(id)inContext {
	
	if (inKeyPath == @"hidden")
	[self setNeedsLayout];

}





@end