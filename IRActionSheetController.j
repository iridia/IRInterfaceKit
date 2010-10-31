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
	
	CGSize contentSize;
	BOOL contentWantsFullLayout @accessors;
	
	CPArray actionControllers;
	
}

- (void) enqueueActionController:(CPViewController)inController {
	
	//	TODO: Implement
	
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
	[[[self window] contentView] setContentView:contentWrapperView];
	[contentWrapperView setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];

		[contentWrapperView setHasHorizontalScroller:YES];
		[contentWrapperView setHasVerticalScroller:YES];
		[contentWrapperView setAutohidesScrollers:NO];
		[contentWrapperView setInvertedColor:NO];
		
	contentWantsFullLayout = NO;
	
	[[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowWillBeginSheetNotification:) name:CPWindowWillBeginSheetNotification object:nil];
	
	[[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowDidEndSheetNotification:) name:CPWindowDidEndSheetNotification object:nil];

}





- (void) handleWindowWillBeginSheetNotification:(CPNotification)inNotification {
	
	var sheetHostingWindow = [inNotification object];
	
	if (!sheetHostingWindow._irShadeWindow) {
	
		sheetHostingWindow._irShadeWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];

		[[sheetHostingWindow._irShadeWindow contentView] setBackgroundColor:[CPColor blackColor]];
	
	}
	
	[sheetHostingWindow._irShadeWindow orderFront:self];
	[[sheetHostingWindow._irShadeWindow contentView] setAlphaValue:0.0];
		
	var backgroundAnimation = [[LPViewAnimation alloc] initWithViewAnimations:[{

		@"target": [sheetHostingWindow._irShadeWindow contentView],
		@"animations": [
		
			[LPFadeAnimationKey, 0.0, 0.75]

		]

	}]];
	
	[backgroundAnimation setAnimationCurve:CPAnimationEaseOut];
	[backgroundAnimation setDuration:.125];
	[backgroundAnimation setShouldUseCSSAnimations:NO];

	[backgroundAnimation startAnimation];

}





- (void) handleWindowDidEndSheetNotification:(CPNotification)inNotification {
	
	var sheetHostingWindow = [inNotification object];
	
	if (!sheetHostingWindow._irShadeWindow) return;
	
	var backgroundAnimation = [[LPViewAnimation alloc] initWithViewAnimations:[{

		@"target": [sheetHostingWindow._irShadeWindow contentView],
		@"animations": [
		
			[LPFadeAnimationKey, 0.75, 0.0]

		]

	}]];
	
	[backgroundAnimation setAnimationCurve:CPAnimationEaseInOut];
	[backgroundAnimation setDuration:.25];
	[backgroundAnimation setShouldUseCSSAnimations:NO];
	[backgroundAnimation startAnimation];
	
	[sheetHostingWindow._irShadeWindow performSelector:@selector(orderOut:) withObject:self afterDelay:.26];
	
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
	[contentWrapperView setPageScroll:0.0];
	
	contentView = inContentView;
	var contentWrapperSize = [contentWrapperView frame].size;
	
	if (contentWantsFullLayout) {
		
		[contentView setFrame:CGRectMake(0, 0, contentWrapperSize.width, contentWrapperSize.height)];
		[contentView setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];
		
	} else {
		
		[contentView setFrameOrigin:CGPointMake(0, 0)];
		[contentView setAutoresizingMask:null];
		
	}
	
	[contentView setNeedsLayout];
	[contentWrapperView setNeedsLayout];
	
}

- (CPView) contentView {
	
	return [contentWrapperView documentView];
	
}





- (void) resizeSheetToFitDocumentView {

	[self resizeSheetToFitDocumentViewAnimated:YES];
	
}

- (void) resizeSheetToFitDocumentViewAnimated:(BOOL)shouldAnimate {
		
	if (!contentView) return;
		
	var currentWindowSize = ([[self window] frame]).size;
	var platformWindowFrame = [[[self window] platformWindow] visibleFrame];
	var platformWindowSize = platformWindowFrame.size;
	
	var minimumSize = CGSizeMake(384, 384);
	var maximumSize = CGSizeMake(platformWindowSize.width - 128, platformWindowSize.height - 32);

	
//	Suggest a frame that simply fits everything.  Notice the frame is not centered.
		
	var preferredSize;
	if (contentWantsFullLayout) {
		
		preferredSize = maximumSize;
		
	} else {
	
		preferredSize = [[[self window] contentView] preferredSizeWithContentView:contentView];
		preferredSize = CGSizeMake(
		
			MAX(minimumSize.width, MIN(preferredSize.width, maximumSize.width)),
			MAX(minimumSize.height, MIN(preferredSize.height, maximumSize.height))
			
		);
				
	}
	
	
	var finalFrame = CGAlignedRectMake(
	
		CGRectMake(0, 0, preferredSize.width, preferredSize.height), kCGAlignmentPointRefTop,
		platformWindowFrame, kCGAlignmentPointRefTop
		
	);
	
	[[[self window] contentView] setFrame:CGRectMake(0, 0, currentWindowSize.width, currentWindowSize.height)];
	[[[self window] contentView] setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];
	[[self window] setFrame:finalFrame display:YES animate:shouldAnimate];
	
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

- (CGSize) preferredSizeWithContentView:(CPView)inContentView {

	var preferredWidth = 0, preferredHeight = 0;

	if (headerView)
	preferredHeight += CGRectGetHeight([headerView frame]);
	
	preferredWidth += CGRectGetWidth([inContentView frame]);
	preferredHeight += CGRectGetHeight([inContentView frame]);
	
	if (footerView)
	preferredHeight += CGRectGetHeight([footerView frame]);

	return CGSizeMake(preferredWidth, preferredHeight);
	
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
	
	if (![self parentWindow]) return;

	[self setFrameOrigin:CGPointMake(
		
		(CGRectGetWidth([[self parentWindow] frame]) - CGRectGetWidth([self frame])) / 2,  
		0
		
	)];
	
	[_windowController resizeSheetToFitDocumentViewAnimated:NO];
	
}

@end




