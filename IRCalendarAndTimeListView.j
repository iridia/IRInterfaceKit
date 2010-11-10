//	IRCalendarAndTimeListView.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRCalendarAndTimeListView : CPView {
	
	IRCalendarView calendarView;
	
	IRSkinnyScrollView timeListWrapper;
	IRDarkerBeigeBox timeListWrapperBackdrop;
	
	CPTableView timeList;
	
	BOOL enabled @accessors;
	
}

- (id) initWithFrame:(CGRect)inFrame {
	
	self = [super initWithFrame:inFrame];
	if (!self) return nil; 
	
	enabled = YES;
	
	calendarView = [IRCalendarView calendarView];
	[calendarView setFrameOrigin:CGPointMake(0, 0)];
	[calendarView setMonth:[CPDate date]];
	[calendarView setDelegate:self];
	[calendarView setAllowsMultipleSelection:NO];
	[self addSubview:calendarView];
	
	timeListWrapper = [[IRSkinnyScrollView alloc] initWithFrame:CGRectMake(184, 0, 96, 168)];
	[timeListWrapper setBackgroundColor:[CPColor clearColor]];
	[self addSubview:timeListWrapper];
	
	var timeListWrapperBackdrop = [[IRDarkerBeigeBox alloc] initWithFrame:[timeListWrapper frame]];
	[timeListWrapperBackdrop setHitTests:NO];
	[self addSubview:timeListWrapperBackdrop positioned:CPWindowBelow relativeTo:timeListWrapper];
	
	[self setClipsToBounds:NO];
	
	return self;
	
}	

@end