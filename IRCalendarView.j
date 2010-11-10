//	IRCalendarView.j
//	Evadne Wu at Iridia, 2010
	
@import <LPKit/LPCalendarView.j>
	
	
	
	
	
@implementation IRCalendarView : LPCalendarView

+ (id) calendarView {
	
	calendarView = [[IRCalendarView alloc] initWithFrame:CGRectMake(0, 0, 7 * 24, 7 * 24)];
	[calendarView setValue:CGSizeMake(24, 24) forThemeAttribute:@"tile-size" inState:CPThemeStateNormal];
	[calendarView setValue:24 forThemeAttribute:@"header-height" inState:CPThemeStateNormal];
	
	if (!calendarView) return nil;
	
	var bezelColor = [CPColor colorWithPatternImage:[CPNinePartImage imageWithBaseName:@"IRDarkerBeigeBox.backdrop" inBundle:[CPBundle bundleForClass:[IRBeigeBox class]] withInset:CGInsetMake(24, 24, 24, 24)]];
	
	[calendarView setValue:[CPColor colorWithWhite:1.0 alpha:0.45] forThemeAttribute:@"grid-color"];
	[calendarView setValue:[CPColor colorWithWhite:0.0 alpha:0.25] forThemeAttribute:@"grid-shadow-color"];

	[calendarView setValue:bezelColor forThemeAttribute:@"bezel-color"];
	[calendarView setValue:CGInsetMake(-16, -16, -16, -16) forThemeAttribute:@"bezel-inset"];

	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"header-background-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPFont boldSystemFontOfSize:11.0] forThemeAttribute:@"header-font" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor colorWithHexString:@"333"] forThemeAttribute:@"header-text-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor whiteColor] forThemeAttribute:@"header-text-shadow-color" inState:CPThemeStateNormal];
	[calendarView setValue:CGSizeMake(1.0, 1.0) forThemeAttribute:@"header-text-shadow-offset" inState:CPThemeStateNormal];
	[calendarView setValue:CPCenterTextAlignment forThemeAttribute:@"header-alignment" inState:CPThemeStateNormal];

	[calendarView setValue:CGSizeMake(0.0, 0.0) forThemeAttribute:@"header-button-offset" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor redColor] forThemeAttribute:@"header-prev-button-image" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor blueColor] forThemeAttribute:@"header-next-button-image" inState:CPThemeStateNormal];

	[calendarView setValue:0 forThemeAttribute:@"header-weekday-offset" inState:CPThemeStateNormal];
	[calendarView setValue:[CPFont systemFontOfSize:9.0] forThemeAttribute:@"header-weekday-label-font" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"header-weekday-label-color" inState:CPThemeStateNormal];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"header-weekday-label-shadow-color" inState:CPThemeStateNormal];
	[calendarView setValue:CGSizeMakeZero() forThemeAttribute:@"header-weekday-label-shadow-offset" inState:CPThemeStateNormal];

	[calendarView setValue:[CPFont boldSystemFontOfSize:11.0] forThemeAttribute:@"tile-font"];
	[calendarView setValue:[CPColor colorWithHexString:@"444"] forThemeAttribute:@"tile-text-color"];
	[calendarView setValue:[CPColor colorWithWhite:1 alpha:0.65] forThemeAttribute:@"tile-text-shadow-color"];
	
	[calendarView setValue:CGSizeMake(0.0, 1.0) forThemeAttribute:@"tile-text-shadow-offset" inState:CPThemeStateNormal];

	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateHighlighted];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"tile-text-shadow-color" inState:CPThemeStateHighlighted];

	[calendarView setValue:[CPColor colorWithWebRed:124 green:137 blue:166 alpha:1] forThemeAttribute:@"tile-bezel-color" inState:CPThemeStateSelected];
	[calendarView setValue:[CPColor whiteColor] forThemeAttribute:@"tile-text-color" inState:CPThemeStateSelected];
	[calendarView setValue:[CPColor clearColor] forThemeAttribute:@"tile-text-shadow-color" inState:CPThemeStateSelected];	

	[calendarView setValue:[CPColor colorWithWhite:0 alpha:0.3] forThemeAttribute:@"tile-text-color" inState:CPThemeStateDisabled];

	return calendarView;	
	
}

- (id)initWithFrame:(CGRect)aFrame {

	self = [super initWithFrame:aFrame]; if (!self) return nil;

        fullSelection = [nil, nil];

        var bounds = [self bounds];
	[self setClipsToBounds:NO];

	[headerView removeFromSuperview];
        headerView = [[IRCalendarHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds), 31)];

        [[headerView prevButton] setTarget:self];
        [[headerView prevButton] setAction:@selector(didClickPrevButton:)];
        [[headerView nextButton] setTarget:self];
        [[headerView nextButton] setAction:@selector(didClickNextButton:)];

        [self addSubview:headerView];

	[slideView removeFromSuperview];
        slideView = [[LPSlideView alloc] initWithFrame:CGRectMake(0, 32, CGRectGetWidth(bounds), CGRectGetHeight(bounds) - 40)];
        [slideView setSlideDirection:LPSlideViewVerticalDirection];
        //[slideView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable | CPViewMinYMargin];
        [slideView setDelegate:self];
        [slideView setAnimationCurve:CPAnimationEaseOut];
        [slideView setAnimationDuration:0.2];
        [self addSubview:slideView];

	[bezelView removeFromSuperview];
	bezelView = [[CPView alloc] initWithFrame:[slideView frame]];
	[bezelView setHitTests:NO];
	[self addSubview:bezelView positioned:CPWindowBelow relativeTo:nil];

	[firstMonthView removeFromSuperview];
        firstMonthView = [[LPCalendarMonthView alloc] initWithFrame:[slideView bounds] calendarView:self];
        [firstMonthView setDelegate:self];
        [slideView addSubview:firstMonthView];

	[secondMonthView removeFromSuperview];
        secondMonthView = [[LPCalendarMonthView alloc] initWithFrame:[slideView bounds] calendarView:self];
        [secondMonthView setDelegate:self];
        [slideView addSubview:secondMonthView];

        currentMonthView = firstMonthView;

        // Default to today's date.
        [self setMonth:[CPDate date]];

        [self setNeedsLayout];

	return self;

}                 

- (IBAction) didClickPrevButton:(id)sender {
	
	[super didClickPrevButton:sender];
	[headerView setNeedsLayout];
	
}

- (IBAction) didClickNextButton:(id)sender {
	
	[super didClickNextButton:sender];
	[headerView setNeedsLayout];
	
}

@end





@implementation IRCalendarHeaderView : LPCalendarHeaderView

- (void) drawRect:(CGRect)inRect {
	
	var	context = [[CPGraphicsContext currentContext] graphicsPort],
		bounds = [self bounds],
		width = CGRectGetWidth(bounds),
		height = CGRectGetHeight(bounds);
		
	var gradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), 
	
		[	1, 1, 1, 0.25,
			0.6, 0.6, 0.6, 0.25	],
			
	[0, 1], 2);
	
	CGContextAddRect(context, [self bounds]);
	CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, height));
	
	var	hLine = function (inMarginTop) {
		
			CGContextFillRect(context, CGRectMake(0, inMarginTop, width, 1));
		
		}, 
		
		vLine = function (inMarginLeft) {
			
			CGContextFillRect(context, CGRectMake(inMarginLeft, 0, 1, height));
			
		};

	CGContextSetFillColor(context, [CPColor colorWithWhite:0 alpha:0.25]);
	hLine(height - 1);

	CGContextSetFillColor(context, [CPColor colorWithWhite:1 alpha:0.125]);
	hLine(height - 2);
	
}

- (void) layoutSubviews {
	
	[super layoutSubviews];
	
	[monthLabel centerInSuperview];
	[monthLabel setValue:CPCenterVerticalTextAlignment forThemeAttribute:@"vertical-alignment"];	
	
	var	selfHeight = CGRectGetHeight([self frame]),
		selfWidth = CGRectGetWidth([self frame]),
		leftImage = [CPImage imageNamed:@"IRCalendarView.left.png" inBundleOf:IRCalendarView],
		rightImage = [CPImage imageNamed:@"IRCalendarView.right.png" inBundleOf:IRCalendarView],
		leftColor = [CPColor colorWithPatternImage:leftImage],
		rightColor = [CPColor colorWithPatternImage:rightImage],
		insets = CGInsetMake(4, 4, 4, 4);

	[prevButton setFrame:CGRectMake(0, 0, selfHeight, selfHeight)];
	[prevButton setValue:leftColor forThemeAttribute:@"bezel-color"];
	[prevButton setValue:insets forThemeAttribute:@"bezel-inset"];
	
	[nextButton setFrame:CGRectMake(selfWidth - selfHeight, 0, selfHeight, selfHeight)];    
	[nextButton setValue:rightColor forThemeAttribute:@"bezel-color"];
	[nextButton setValue:insets forThemeAttribute:@"bezel-inset"];
		
	[dayLabels enumerate: function (inLabel) { [inLabel setHidden:YES]; }];

}

- (void) mouseDown:(CPEvent)inEvent {
	
	CPLog(@"mouseDown %@", inEvent);
	
}

@end
