//	IRSelectableToolbar.j
//	Evadne Wu at Iridia, 2010
	
	
	
	

@implementation IRSelectableToolbar : CPToolbar {
	
 	Class selectedViewControllerClass @accessors;
	CPView selectedItemBackdrop;
	
}

- (CPArray) selectableItems {
	
	var	responseArray = [CPMutableArray array],
		enumerator = [_items objectEnumerator], 
		object = nil;
		
	while (object = [enumerator nextObject])
	if ([object isKindOfClass:[IRSelectableToolbarItem class]])
	if ([[self delegate] viewControllerClassForToolbarItemWithIdentifier:[object itemIdentifier]] != nil)
	[responseArray addObject:object];
	
	return responseArray;

}

- (void) activateSelectableItemAtIndex:(int)inIndex {
	
	var itemToInvoke = [[self selectableItems] objectAtIndex:inIndex];
	if (!itemToInvoke) return;
	
	[[itemToInvoke target] performSelector:[itemToInvoke action] withObject:itemToInvoke];
	
}





- (void) _reloadToolbarItems {
	
	[super _reloadToolbarItems];
	
	var enumerator = [[self selectableItems] objectEnumerator], object = nil;
	while (object = [enumerator nextObject])
	if ([[self delegate] viewControllerClassForToolbarItemWithIdentifier:[object itemIdentifier]] != nil) {

		[object setTarget:self];
		[object setAction:@selector(handleSelectableToolbarClick:)];
				
	}
	
}

- (IBAction) handleSelectableToolbarClick:(id)sender {

	var item = [self toolbarItemForToolbarItemOrSubstitutedMenuItem:sender];
	
	var enumerator = [[self selectableItems] objectEnumerator], object = nil;
	while (object = [enumerator nextObject])
	[object setVisibilityPriority:CPToolbarItemVisibilityPriorityHigh];
	
	[item setVisibilityPriority:CPToolbarItemVisibilityPriorityUser];
	[_toolbarView tile];
	
	
	var associatedViewController = [[self delegate] viewControllerClassForToolbarItemWithIdentifier:[item itemIdentifier]];
	
	if ([self selectedViewControllerClass] == associatedViewController) return;
		
	[self setSelectedViewControllerClass:associatedViewController];

//	Nudge the toolbar view handlerhere
	[self _toolbarView];
	
	[_toolbarView yieldBackdropForItem:item];
		
	if ([[self delegate] respondsToSelector:@selector(toolbar:didSelectViewControllerClass:)])
	[[self delegate] toolbar:self didSelectViewControllerClass:[self selectedViewControllerClass]];
	
}





- (CPView) _toolbarView {

	if (!_toolbarView) {

		_toolbarView = [[IRSelectableToolbarView alloc] initWithFrame:CPRectMake(0.0, 0.0, 1200.0, 59.0)];
		[_toolbarView setToolbar:self];
		[_toolbarView setAutoresizingMask:CPViewWidthSizable];
		[_toolbarView reloadToolbarItems];
	
	}

}

- (CPToolbarItem) toolbarItemForToolbarItemOrSubstitutedMenuItem:(id)inItem {
	
	if ([inItem isKindOfClass:[CPMenuItem class]]) {
		
		var itemIndexInMenu = [[[_toolbarView additionalItemsButton] itemArray] indexOfObject:inItem] - 1;
		var itemsToMatch = [[_toolbarView invisibleItems] mutableCopy];
		var enumerator = [[_toolbarView invisibleItems] objectEnumerator], object = nil;
		
		if (itemIndexInMenu == -2)
		return nil;
		
		while (object = [enumerator nextObject])
		if ([object itemIdentifier] === CPToolbarSpaceItemIdentifier || [object itemIdentifier] === CPToolbarFlexibleSpaceItemIdentifier)
		[itemsToMatch removeObject:object];

		return [itemsToMatch objectAtIndex:itemIndexInMenu];
	
	} else if ([inItem isKindOfClass:[CPToolbarItem class]]) {
	
		return inItem;
		
	} else {

		return nil;
		
	}
	
}

@end





@implementation IRSelectableToolbarView : _CPToolbarView {
	
	CPView selectedItemBackdrop;
	CPToolbarItem selectedItem;
	
}
	
- (void) tile {
	
	[super tile];
	
	if (selectedItem)
	[self yieldBackdropForItem:selectedItem];
	
}





//	This button is exposed so we can see which toolbar item is represented by the menu item
//	and get the identifier so we can associate with a view controller

- (CPPopUpButton) additionalItemsButton {

	return _additionalItemsButton;

}

- (CPArray) invisibleItems {

	return _invisibleItems;

}





- (void) yieldBackdropForItem:(CPToolbarItem)inItem {
	
	selectedItem = [[self toolbar] toolbarItemForToolbarItemOrSubstitutedMenuItem:inItem];

	if (!selectedItemBackdrop) {

		selectedItemBackdrop = [[IRSelectableToolbarItemBackdropView alloc] initWithFrame:CGRectMake(0, 0, 128, [self frame].size.height)];

		[selectedItemBackdrop setHidden:YES];

		[self addSubview:selectedItemBackdrop positioned:CPWindowBelow relativeTo:nil];
	
	}
	
	
	[selectedItemBackdrop setHidden:NO];
	
	var itemView = [self viewForItem:selectedItem];
	if (!itemView) {
	
	//	The item is in a “more” menu
		[selectedItemBackdrop setHidden:YES];
		return;
		
	}
	
	var itemViewFrame = [[self viewForItem:selectedItem] frame];
	
	[selectedItemBackdrop setFrameOrigin:itemViewFrame.origin];
	[selectedItemBackdrop setFrameSize:CGSizeMake(
	
		itemViewFrame.size.width,
		[selectedItemBackdrop frame].size.height
		
	)];
	
	[selectedItemBackdrop setHidden:[[self viewForItem:selectedItem] isHidden]];
	
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
		inFrame.size.width + 32,
		48
		
	)];
	
	[backgroundView centerVerticallyInSuperview];
	
	[backgroundView setBackgroundColor:[CPColor colorWithPatternImage:[CPThreePartImage imageWithBaseName:@"IRSelectableToolbar.item.backdrop.active" inBundleOf:self withInset:CGInsetMake(0.0, 32.0, 0.0, 32.0) thickness:48.0 vertical:NO]]];
	
	return self;
	
}

@end





@implementation _CPToolbarItemView (Override)

- (void) mouseDown:(CPEvent)anEvent {

	if ([_toolbarItem view]) {

		if ([[_toolbarItem view] hitTests])
		return [[self nextResponder] mouseDown:anEvent];

		if ([_toolbarItem target] && [_toolbarItem action])
		return [[_toolbarItem target] performSelector:[_toolbarItem action] withObject:_toolbarItem];
	
	}

    var identifier = [_toolbarItem itemIdentifier];

    if (identifier === CPToolbarSpaceItemIdentifier ||
        identifier === CPToolbarFlexibleSpaceItemIdentifier ||
        identifier === CPToolbarSeparatorItemIdentifier)
        return [[self nextResponder] mouseDown:anEvent];

    [super mouseDown:anEvent];

}

@end




