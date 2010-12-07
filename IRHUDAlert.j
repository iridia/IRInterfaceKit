//	IRHUDAlert.j
//	Evande Wu at Iridia, 2010
	
	
	
	
@implementation IRHUDAlert : CPAlert

- (void) _createWindowWithStyle:(int)forceStyle {
	
    var frame = CGRectMakeZero();
    frame.size = [self currentValueForThemeAttribute:@"size"];

    _window = [[CPWindow alloc] initWithContentRect:frame styleMask:((forceStyle || CPTitledWindowMask) && CPHUDBackgroundWindowMask)];

    if (_title)
        [_window setTitle:_title];

    var contentView = [_window contentView],
        count = [_buttons count];

    if (count)
        while (count--)
            [contentView addSubview:_buttons[count]];
    else
        [self addButtonWithTitle:@"OK"];

    [contentView addSubview:_messageLabel];
    [contentView addSubview:_alertImageView];
    [contentView addSubview:_informativeLabel];

    if (_showHelp)
        [contentView addSubview:_alertHelpButton];

}

@end