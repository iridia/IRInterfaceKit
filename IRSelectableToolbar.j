//	IRSelectableToolbar.j
//	Evadne Wu at Iridia, 2010
	
	
	
	

@implementation IRSelectableToolbar : CPToolbar {
	
 	Class selectedViewControllerClass @accessors;
	CPView selectedItemBackdrop;
	
}

- (void) _reloadToolbarItems {
	
	[super _reloadToolbarItems];
	
	var enumerator = [_items objectEnumerator], object = nil;
	while (object = [enumerator nextObject])
	if ([object isKindOfClass:[IRSelectableToolbarItem class]])
	if ([[self delegate] viewControllerClassForToolbarItemWithIdentifier:[object itemIdentifier]] != nil) {

		[object setTarget:self];
		[object setAction:@selector(handleSelectableToolbarClick:)];
				
	}
	
}

- (IBAction) handleSelectableToolbarClick:(id)sender {
	
	var associatedViewController = [[self delegate] viewControllerClassForToolbarItemWithIdentifier:[sender itemIdentifier]];
	
	if ([self selectedViewControllerClass] == associatedViewController) return;
		
	[self setSelectedViewControllerClass:associatedViewController];

//	Nudge the toolbar view handlerhere
	[self _toolbarView];
	
	var itemViewFrame = [[_toolbarView viewForItem:sender] frame];
	
	[selectedItemBackdrop setFrameOrigin:itemViewFrame.origin];
	[selectedItemBackdrop setFrameSize:CGSizeMake(
	
		itemViewFrame.size.width,
		[selectedItemBackdrop frame].size.height
		
	)];
	[selectedItemBackdrop setHidden:NO];
	
	if ([[self delegate] respondsToSelector:@selector(toolbar:didSelectViewControllerClass:)])
	[[self delegate] toolbar:self didSelectViewControllerClass:[self selectedViewControllerClass]];
	
}





- (CPView) _toolbarView {

	if (!selectedItemBackdrop)
	selectedItemBackdrop = [[IRSelectableToolbarItemBackdropView alloc] initWithFrame:CGRectMake(0, 0, 128, [[super _toolbarView] frame].size.height)];
//	[selectedItemBackdrop setBackgroundColor:[CPColor redColor]];
	[selectedItemBackdrop setHidden:YES];

	[super _toolbarView];
	
	[_toolbarView addSubview:selectedItemBackdrop positioned:CPWindowBelow relativeTo:nil];

}

@end





@implementation IRSelectableToolbarItem : CPToolbarItem {
	
	id representedObject @accessors;
	
}

- (IRSelectedToolbarItem) initWithItemIdentifier:(CPString)anItemIdentifier {
	
	self = [super initWithItemIdentifier:anItemIdentifier];
	if (self === nil) return nil;
		
	return self;
	
}

@end





@implementation IRSelectableToolbarItemBackdropView : IRStyledView 

- (id) initWithFrame:(CGRect)inFrame {
	
	self = [super initWithFrame:inFrame]; if (self == nil) return nil;
	
	[backgroundView setFrame:CGRectMake(
	
		inFrame.origin.x - 16,
		inFrame.origin.y,
		inFrame.size.width,
		48
		
	)];
	
	[backgroundView centerVerticallyInSuperview];
	
	[backgroundView setBackgroundColor:[CPColor colorWithPatternImage:[CPThreePartImage imageWithBaseName:@"IRSelectableToolbar.item.backdrop.active" inBundleOf:self withInset:CGInsetMake(0.0, 32.0, 0.0, 32.0) thickness:48.0 vertical:NO]]];
	
	CGRectDump(inFrame, @"frame to work with the item");
	CGRectDump([backgroundView frame], @"background view frame");
	
	return self;
	
}

@end




