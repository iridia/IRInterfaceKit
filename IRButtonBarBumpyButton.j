@implementation _IRJumpyButton : CPButton

- (void) layoutSubviews {
	
	[super layoutSubviews];

	if (![self buttonBar]) return;
	
	var buttonArray = [[self buttonBar] buttonArrayForButton:self];
	
	var activeButton = [buttonArray activeButton];	//	How do we get this information?
	
	var activeButtonIndex = [buttonArray indexOfObject:activeButton];
	var currentButtonIndex = [buttonArray indexOfObject:self];
	
	if (!activeButton) {
	
		//	restore
		
	} else if ((activeButtonIndex + 1) == currentButtonIndex) {
		
		//	the button to self’s left is active
		
	} else if ((activeButtonIndex - 1) == currentButtonIndex) {
		
		//	the button to self’s right is active
		
	}

}

@end




