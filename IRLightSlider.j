//	IRLightSlider.j
//	Evadne Wu at Iridia, 2010





@import <CGGeometry+IRAdditions/CGGeometry+IRAdditions.j>

@implementation IRLightSlider : CPSlider





+ (IRLightSlider) verticalSlider {
	
	var slider = [[IRLightSlider alloc] initWithFrame:CGRectMake(0.0, 0.0, 48.0, 256.0)];
	
	
	[slider setValue:[CPColor colorWithPatternImage:[CPImage imageNamed:@"IRLightSlider.track.knob.vertical.png" inBundleOf:self]] forThemeAttribute:@"knob-color"];

	[slider setValue:[CPColor colorWithPatternImage:[CPImage imageNamed:@"IRLightSlider.track.knob.vertical.disabled.png" inBundleOf:self]] forThemeAttribute:@"knob-color" inState:CPThemeStateDisabled];
	
	[slider setValue:[CPColor colorWithPatternImage:[CPImage imageNamed:@"IRLightSlider.track.knob.vertical.active.png" inBundleOf:self]] forThemeAttribute:@"knob-color" inState:CPThemeStateHighlighted];
	
	[slider setValue:CGSizeMake(32.0, 16.0) forThemeAttribute:@"knob-size"];
	
	
	[slider setValue:32.0 forThemeAttribute:@"track-width"];
	[slider setValue:[CPColor redColor] forThemeAttribute:@"track-color"];
	
	[slider setValue:[CPColor colorWithPatternImage:[CPThreePartImage imageWithBaseName:@"IRLightSlider.track.vertical" inBundleOf:self withInset:CGInsetMake(8, 0, 8, 0) thickness:32.0 vertical:YES]] forThemeAttribute:@"track-color" inState:CPThemeStateVertical];

	[slider setValue:[CPColor colorWithPatternImage:[CPThreePartImage imageWithBaseName:@"IRLightSlider.track.vertical.disabled" inBundleOf:self withInset:CGInsetMake(8, 0, 8, 0) thickness:32.0 vertical:YES]] forThemeAttribute:@"track-color" inState:CPThemeStateVertical|CPThemeStateDisabled];
	
	
	return slider;

}





- (float) _valueAtPoint:(CGPoint)aPoint {
	
	if ([self isContinuous]) return [self __valueAtPoint:aPoint];
	return Math.floor([self __valueAtPoint:aPoint]);
	
}





- (float)__valueAtPoint:(CGPoint)aPoint {
	
	if (![self isVertical]) return [super _valueAtPoint:aPoint];

	var bounds = [self bounds],
	knobRect = [self knobRectForBounds:bounds],
	trackRect = [self trackRectForBounds:bounds];

	var knobHeight = CGRectGetHeight(knobRect);

	trackRect.origin.y += knobHeight / 2;
	trackRect.size.height -= knobHeight;

	var minValue = [self minValue];
	var ratio = MAX(0.0, MIN(1.0, (aPoint.y - CGRectGetMinY(trackRect)) / CGRectGetHeight(trackRect)));	
	var returnValue = [self maxValue] - (ratio) * ([self maxValue] - minValue);

	return returnValue;

}

- (CGRect)knobRectForBounds:(CGRect)bounds {

	if (![self isVertical]) return [super knobRectForBounds:bounds];

	var knobSize = [self currentValueForThemeAttribute:@"knob-size"];
	if (knobSize.width <= 0 || knobSize.height <= 0) return CGRectMakeZero();

	var	knobRect = CGRectMake(0.0, 0.0, knobSize.width, knobSize.height),
		trackRect = [self trackRectForBounds:bounds];
	
	if (!trackRect || CGRectIsEmpty(trackRect)) trackRect = bounds;

        knobRect.origin.x = CGRectGetMidX(trackRect) - knobSize.width / 2.0;
	knobRect.origin.y = ((_maxValue - [self doubleValue]) / (_maxValue - _minValue)) * (CGRectGetHeight(trackRect) - knobSize.height);
	
	return knobRect;
    
}





@end




