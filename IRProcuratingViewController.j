//	IRProcuratingViewController.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRProcuratingViewController : CPViewController

- (void) setRepresentedObject:(id)inObject {

	[super setRepresentedObject:inObject];
	[self updateBoundProperties];
	
}

- (void) updateBoundProperties {
	
	//	No implementation.  subclasses should implement their own handling and update bound properties here.
	
}

@end