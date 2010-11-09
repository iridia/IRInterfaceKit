//	IRValueTransformers.j
//	Evadne Wu at Iridia, 2010
	
	
	
	
	
@implementation IRBooleanTransformer : CPValueTransformer

+ (BOOL) allowsReverseTransformation {
	
	return YES;
	
}

+ (Class) transformedValueClass {
	
	return [CPNumber class];

}

- (id) reverseTransformedValue:(id)aValue {

	CPLog(@"IRBooleanTransformer reverse value for %@ is %@", aValue, [aValue boolValue]);

	return [aValue boolValue];

}

- (id) transformedValue:(id)aValue {

	CPLog(@"IRBooleanTransformer value for %@ is %@", aValue, [aValue boolValue]);

	return [aValue boolValue];

}

@end





@implementation IRBooleanFromStateTransformer : CPValueTransformer

+ (BOOL) allowsReverseTransformation {
	
	return NO;
	
}

+ (Class) transformedValueClass {
	
	return [CPNumber class];

}

- (id) transformedValue:(id)aValue {

	CPLog(@"IRBooleanFromStateTransformer value for %@ is %@", aValue, (aValue == CPOnState));

	return (aValue == CPOnState);

}

@end