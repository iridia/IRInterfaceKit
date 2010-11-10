//	IRCalendarAndTimeListView.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRCalendarAndTimeListView : CPView {
	
	IRCalendarView calendarView;
	
	IRSkinnyScrollView timeListWrapper;
	IRDarkerBeigeBox timeListWrapperBackdrop;
	
	CPTableView timeList;
	CPArray timeRepresentationsArray @accessors;
	
	BOOL enabled @accessors;
	
	CPDate selectedDate @accessors;
	int selectedDateTimeOffset @accessors;
	
	CPDate representedDate @accessors;
	
}

- (id) initWithFrame:(CGRect)inFrame {
	
	self = [super initWithFrame:inFrame];
	if (!self) return nil; 
	
	enabled = YES;
	selectedDate = nil;
	selectedDateTimeOffset = 0;
	representedDate = nil;
	
	calendarView = [IRCalendarView calendarView];
	[calendarView setFrameOrigin:CGPointMake(0, 0)];
	[calendarView setMonth:[CPDate date]];
	[calendarView setDelegate:self];
	[calendarView setAllowsMultipleSelection:NO];
	[self addSubview:calendarView];
	
	timeListWrapper = [[IRSkinnyScrollView alloc] initWithFrame:CGRectInset(CGRectMake(184, 0, 72, 168), 0, 4)];
	[timeListWrapper setBackgroundColor:[CPColor clearColor]];
	[self addSubview:timeListWrapper];
	
	var timeListWrapperBackdrop = [[IRDarkerBeigeBox alloc] initWithFrame:CGRectInset([timeListWrapper frame], 0, -4)];
	[timeListWrapperBackdrop setHitTests:NO];
	[self addSubview:timeListWrapperBackdrop positioned:CPWindowBelow relativeTo:timeListWrapper];
	
	[self calculateTimeRepresentationsArray];
	
	timeList = [[CPTableView alloc] initWithFrame:[timeListWrapper bounds]];
	[timeListWrapper addSubview:timeList];
	
		[timeList setDataSource:self];
		[timeList setDelegate:self];
		[timeList setHeaderView:nil];
		[timeList setCornerView:nil];
		
		[timeList setBackgroundColor:[CPColor clearColor]];
		
		var	column = [[CPTableColumn alloc] initWithIdentifier:@"stringRepresentation"],
			dataView = [IRTextField labelWithTitle:@"Default"];

			[dataView setValue:[CPFont systemFontOfSize:12.0] forThemeAttribute:@"font"];
			[dataView setValue:CPCenterTextAlignment forThemeAttribute:@"alignment"];

			[column setWidth:CGRectGetWidth([timeList bounds])];
			[[column headerView] setHidden:YES];
			[column setDataView:dataView];

		[timeList addTableColumn:column];
		[timeListWrapper setDocumentView:timeList];
		[timeList setColumnAutoresizingStyle:CPTableViewLastColumnOnlyAutoresizingStyle];
		[timeList sizeLastColumnToFit];
		
		[timeList reloadData];
		
		[timeList setNeedsDisplay:YES];
		[timeList setNeedsLayout];
		[timeListWrapper setPageScroll:32.0];
	
	[self setClipsToBounds:NO];
	
	[self addObserver:self forKeyPath:@"enabled" options:null context:nil];
	
	return self;
	
}

- (void) calculateTimeRepresentationsArray {
	
	timeRepresentationsArray = [CPMutableArray array];
	
	var	incrementInMilliseconds = 15 * 60 * 1000,
		initializationPoint = [[CPDate date] midnightDate],
		endPoint = [[initializationPoint nextDay] nextDay];
	
	var currentDate = initializationPoint;
	
	while (currentDate < endPoint) {

		[timeRepresentationsArray addObject:[CPDictionary dictionaryWithJSObject:{
		
			"stringRepresentation": [currentDate stringWithFormat:@"#{HOURS, 2}:#{MINUTES, 2}"],
			"offsetFromMidnight": ( (+currentDate) - (+initializationPoint) )
			
		}]];
		
		currentDate = new Date (+currentDate + incrementInMilliseconds);

	}
	
}

- (void) observeValueForKeyPath:(CPString)inKeyPath ofObject:(id)inObject change:(CPDictionary)inChange context:(id)inContext {

	var oldValue = [inChange objectForKey:CPKeyValueChangeOldKey];
	var newValue = [inChange objectForKey:CPKeyValueChangeNewKey];
		
	if ((inKeyPath == @"enabled") && (inObject == self)) {
		
		if ([self enabled]) {
			
			[self setAlphaValue:1.0];
			[self setHitTests:YES];
			
		} else {
			
			[self setAlphaValue:0.75];
			[self setHitTests:NO];
			
		}
		
		[timeList reloadData];
		
	}
		
}

- (int) numberOfRowsInTableView:(CPTableView)inTableView {
	
	return [[self timeRepresentationsArray] count] || 0;
	
}

- (id) tableView:(CPTableView)inTableView objectValueForTableColumn:(CPTableColumn)inTableColumn row:(int)inRow {
	
	return [[[self timeRepresentationsArray] objectAtIndex:inRow] objectForKey:[inTableColumn identifier]];
		
}

- (void) tableViewSelectionDidChange:(CPNotification)notification {
	
	var tableView = [notification object];
	
	if ([tableView selectedRow] == -1)
	return [self setSelectedDateTimeOffset:0];
	
	[self setSelectedDateTimeOffset:[[[self timeRepresentationsArray] objectAtIndex:[tableView selectedRow]] objectForKey:@"offsetFromMidnight"]];

	[self calculateRepresentedDate];

}

- (void) calendarView:(IRCalendarView)inCalendarView didMakeSelection:(id)inStartingObject end:(id)inEndingObject {

	if (![inStartingObject isKindOfClass:[CPDate class]]) return;
	[self setSelectedDate:inStartingObject];
	
	[self calculateRepresentedDate];
	
}

- (void) calculateRepresentedDate {
	
	if (![self selectedDate])
	return [self setRepresentedDate:nil];
	
	[self setRepresentedDate:(new Date(+([self selectedDate]) + [self selectedDateTimeOffset]))];
	
}

@end