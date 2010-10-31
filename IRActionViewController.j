//	IRActionViewController.j
//	Evadne Wu at Iridia, 2010





@implementation IRActionViewController : CPViewController {
	
	CPString title  @accessors;
	
	BOOL isFinished @accessors;
	BOOL isSkippable @accessors;
	
	BOOL needsFullLayout;
	
}

- (void) setRepresentedObject:(id)inObject {

	//	The represented object is a global context.
	//	The action view needs to bind its various ivars with its various subviews and controls
	//	When -setRepresentedObject: is called, the action view reconfigures its ivars and updates its views thru bindings
	//	Also remember that in setValue:forKey:, set the values back to the represented object.
	//	We can’t bind those values directly to the represented object, because the represented object might be changed.
	
	//	First, unbind any bindings if there are any, so the new changes do not get populated over to the old represented object.
	
	[super setRepresentedObject:inObject];
	
	//	Bind all ivars with the ivars of the newly set represented object.
	
}

- (void) viewWillShow {

	
	
}

- (void) viewWillHide {
	
	
	
}

- (CPDictionary) persistView {
	
	return state;
	
}

- (void) restoreView:(CPDictionary)inState {
	
	
}

@end




