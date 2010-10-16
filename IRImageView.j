//	IRImageview.j
//	Evadne Wu at Iridia, 2010
	
@import <AppKit/CPImageView.j>
	
	
	
	
	
@implementation IRImageView : CPImageView {
	
	int borderRadius @accessors;
	
}


- (id) initWithFrame:(CGRect)inFrame {
	
	self = [super initWithFrame:inFrame]; if (self == nil) return nil;
	
	[self setBorderRadius:0];
	
	return self;
	
}

- (void) setBorderRadius:(int)inBorderRadius {
	
	[self willChangeValueForKey:@"borderRadius"];
	borderRadius = inBorderRadius;
	[self didChangeValueForKey:@"borderRadius"];

	_DOMImageElement.style.WebkitBorderRadius = borderRadius + "px";
	_DOMImageElement.style.MozBorderRadius = borderRadius + "px";
	
}

- (void) setImage:(id)inImage {
	
	[super setImage:inImage];
	[self setBorderRadius:[self borderRadius]];
	
}



@end