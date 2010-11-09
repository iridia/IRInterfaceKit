//	IRSplitView.j
//	Evadne Wu at Iridia, 2010

@import <AppKit/CPSplitView.j>





@implementation IRSplitView : CPSplitView

- (void) resizeSubviewsWithOldSize:(CPSize)oldSize {

	[super resizeSubviewsWithOldSize:oldSize];	
	
	if (_subviews[0]) {
		
		var	max = [self maxPossiblePositionOfDividerAtIndex:0],
			min = [self minPossiblePositionOfDividerAtIndex:0],
			current = [_subviews[0] frame].size.width;

			[self setPosition:MIN(max, MAX(min, current)) ofDividerAtIndex:0];
	
	}
	
}

- (float) maxPossiblePositionOfDividerAtIndex:(int)dividerIndex {
	
	if (![_delegate respondsToSelector:@selector(splitView:maxPossiblePositionOfDividerAtIndex:)])
	return [super maxPossiblePositionOfDividerAtIndex:dividerIndex];
	
	var positionOrNull = [_delegate splitView:self maxPossiblePositionOfDividerAtIndex:dividerIndex];
	if (positionOrNull != null) 
	return positionOrNull;
	
	return [super maxPossiblePositionOfDividerAtIndex:dividerIndex];

}

- (float) minPossiblePositionOfDividerAtIndex:(int)dividerIndex {
	
	if (![_delegate respondsToSelector:@selector(splitView:minPossiblePositionOfDividerAtIndex:)])
	return [super minPossiblePositionOfDividerAtIndex:dividerIndex];
	
	var positionOrNull = [_delegate splitView:self minPossiblePositionOfDividerAtIndex:dividerIndex];
	if (positionOrNull != null) 
	return positionOrNull;
	
	return [super minPossiblePositionOfDividerAtIndex:dividerIndex];	
	
}

@end