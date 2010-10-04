//	IRActionSheetController.j
//	Evadne Wu at Iridia, 2010
	
	
	
	

@implementation IRActionSheetController : CPWindowController {
	
//	The backdropView provides the boxy backdrop
	CPView backdropView;	

	CPView wrapperView;
	
	CPView headerView;
	CPView footerView;

	CPScrollView contentWrapperView;
	CPView contentView;
	
	id representedObject @accessors;
	
}

- (void) loadWindow {
	
	if (_window) return;
	
	[self setWindow:[[IRActionSheetAnchoredWindow alloc] initWithContentRect:CGRectMake(0, 0, 512, 512) styleMask:CPDocModalWindowMask]];
	[[self window] setContentView:[[IRActionSheetLayoutView alloc] initWithFrame:CGRectMakeZero()]];
	[[self window] setHasShadow:NO];
	[[self window]._windowView setClipsToBounds:NO];
	
	
	backdropView = [[IRBeigeBox alloc] initWithFrame:CGRectMake(0, -32, 512, 512 + 32)];
	[[[self window] contentView] addSubview:backdropView];
	
		[backdropView setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];
		[[_window contentView] setClipsToBounds:NO];
		[[_window contentView] setAutoresizesSubviews:YES];
	
	
	contentWrapperView = [[IRSkinnyScrollView alloc] initWithFrame:CGRectMake(0, 0, 512, 512)];
	[contentWrapperView setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];
	[[[self window] contentView] setContentView:contentWrapperView];
	[contentWrapperView setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];

		[contentWrapperView setHasHorizontalScroller:YES];
		[contentWrapperView setHasVerticalScroller:YES];
		[contentWrapperView setAutohidesScrollers:NO];
		[contentWrapperView setInvertedColor:NO];

}


- (void) setHeaderView:(CPView)inHeaderView {

	[inHeaderView setAutoresizingMask:CPViewWidthSizable|CPViewMaxYMargin];
	[[[self window] contentView] setHeaderView:inHeaderView];
	
	headerView = inHeaderView;

}

- (CPView) headerView {
	
	return headerView;
	
}

- (void) setFooterView:(CPView)inFooterView {
	
	[inFooterView setAutoresizingMask:CPViewWidthSizable|CPViewMinYMargin];
	[[[self window] contentView] setFooterView:inFooterView];
	
	footerView = inFooterView;
	
}

- (CPView) footerView {
	
	return footerView;
	
}

- (void) setContentView:(CPView)inContentView {
	
	[contentWrapperView setDocumentView:inContentView];
	contentView = inContentView;
	
}

- (CPView) contentView {
	
	return [contentWrapperView documentView];
	
}


- (void) resizeSheetToFitDocumentView {
	
	if (!contentView) return;

//	Width: the document view, or window width - 128px, the smaller, but larger than the minimum width, 384px
	
	var MINIMAL_SHEET_WIDTH = 384;
	var MINIMAL_SHEET_HEIGHT = 0;

	var documentWrapperViewFrame = [contentWrapperView frame];		
	var documentViewFrame = [contentView frame];
	if (!documentViewFrame) documentViewFrame = CGRectMake(0, 0, 384, 384);


//	The maximum allowed frame is a visually spacious maximum for really large document views
		
	var windowFrame = [[self window] frame];
	var platformWindowFrame = [[[self window] platformWindow] visibleFrame];

	maximumAllowedWidth = platformWindowFrame.size.width - 128;
	maximumAllowedHeight = platformWindowFrame.size.height - 64;

	
//	Suggest a frame that simply fits everything.  Notice the frame is not centered.
	
	var suggestedWidth = documentViewFrame.size.width;
	var suggestedHeight = windowFrame.size.height + (documentViewFrame.size.height - documentWrapperViewFrame.size.height);
	
	var finalWidth = MIN(suggestedWidth, maximumAllowedWidth);
	var finalHeight = MIN(suggestedHeight, maximumAllowedHeight);
		
	var finalFrame = CGAlignedRectMake(
	
		CGRectMake(0, 0, finalWidth, finalHeight), kCGAlignmentPointRefTop,
		platformWindowFrame, kCGAlignmentPointRefTop
		
	);
	
	[[self window] setFrame:finalFrame display:YES animate:YES];
	
}

@end










@implementation IRActionSheetLayoutView : CPView  {
	
	CPView headerView @accessors;
	CPView contentView @accessors;
	CPView footerView @accessors;
	
}

- (void) setHeaderView:(CPView)inView {
	
	if (!inView || inView == headerView) return;
	if (headerView) [headerView removeFromSuperview];

	headerView = inView;
	[self addSubview:headerView positioned:CPWindowAbove relativeTo:contentView];
	
}

- (void) setContentView:(CPView)inView {
	
	if (!inView || inView == contentView) return;
	if (contentView) [contentView removeFromSuperview];

	contentView = inView;
	[self addSubview:contentView];
	
}

- (void) setFooterView:(CPView)inView {
	
	if (!inView || inView == footerView) return;
	if (footerView) [footerView removeFromSuperview];

	footerView = inView;
	[self addSubview:footerView positioned:CPWindowAbove relativeTo:contentView];
	
}


- (void) layoutSubviews {
	
	if (!contentView) return;
	
	var	totalWidth = CGRectGetWidth([self frame]),
		totalHeight = CGRectGetHeight([self frame]), 
		headerViewHeight = headerView ? CGRectGetHeight([headerView frame]) : 0,
		footerViewHeight = footerView ? CGRectGetHeight([footerView frame]) : 0;
	
	if (headerView) [headerView setFrame:CGRectMake(
		
		0, 
		0, 
		totalWidth, 
		headerViewHeight
		
	)];
	
	[contentView setFrame:CGRectMake(
		
		0, 
		headerViewHeight, 
		totalWidth, 
		totalHeight - headerViewHeight - footerViewHeight
		
	)];
	
	if (footerView) [footerView setFrame:CGRectMake(
		
		0, 
		totalHeight - footerViewHeight, 
		totalWidth, 
		footerViewHeight
		
	)];
	
}

@end










@implementation IRActionSheetAnchoredWindow : CPWindow 

- (CPWindow) parentWindow {
	
	return self._parentView;
	
}

- (void) becomeKeyWindow {
	
	[super becomeKeyWindow];
	
	if (self._isSheet)
	[[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(parentWindowDidResize:) name:CPWindowDidResizeNotification object:[self parentWindow]];
	
}

- (void) parentWindowDidResize:(CPNotification)inNotification {

//	TODO: Perhaps handle additional resizing work here

	[self setFrameOrigin:CGPointMake((CGRectGetWidth([[self parentWindow] frame]) - CGRectGetWidth([self frame])) / 2,  0)];
	
}

@end



