//	IRSegmentedButtonBar.j
//	Evadne Wu at Iridia, 2010





@implementation IRSegmenetedButtonBar : IRButtonBar
	
	- (void) handleButtonMouseDown:(id)sender
		
		var buttonBar = //	Code to find the button bar for the sender
		
		var indexOfSender = buttonBarButtons indexOfObject:sender
		
		if (indexOfSender == 0) return;
		if (indexOfSender == ([buttonBarButtons count] - 1)) return;
		
		[self nextButtonRelativeToButton:sender] setThemeState:IRCPSgementedButtonBarHighlightNeighborState
		
	
	- (void) handleButtonMouseUp:(id)sender
	
		[self nextButtonRelativeToButton:sender] unsetThemeState:IRCPSgementedButtonBarHighlightNeighborState] 	
		
@end
		
		
		
		
	
	OR…
	
		IRButtonBar buttonOrdered:relativeTo:
		
		So
		
		- (void) mouseDown:(CPEvent)inEvent {
		
			if ([[self buttonBar] respondsToSelector:@selector(buttonOrdered:relativeTo:)])
			[[[self buttonBar] buttonOrdered:CPOrderAscending relativeTo:self] noteButtonMouseDown:self];
		
		}
		
		
		
		
		