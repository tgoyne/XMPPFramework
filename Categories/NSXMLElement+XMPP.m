#import "NSXMLElement+XMPP.h"
#import "NSNumber+XMPP.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation NSXMLElement (XMPP)

/**
 * Quick method to create an element
**/
- (id)initWithName:(NSString *)name xmlns:(NSString *)ns
{
	if ((self = [self initWithName:name]))
	{
		[self setXmlns:ns];
	}
	return self;
}

- (NSArray *)elementsForXmlns:(NSString *)ns
{
	NSMutableArray *elements = [NSMutableArray array];
	
	for (NSXMLNode *node in [self children])
	{
		if ([node isKindOfClass:[NSXMLElement class]])
		{
			NSXMLElement *element = (NSXMLElement *)node;
			
			if ([[element xmlns] isEqual:ns])
			{
				[elements addObject:element];
			}
		}
	}
	
	return elements;
}

- (NSArray *)elementsForXmlnsPrefix:(NSString *)nsPrefix
{
    NSMutableArray *elements = [NSMutableArray array];
	
	for (NSXMLNode *node in [self children])
	{
		if ([node isKindOfClass:[NSXMLElement class]])
		{
			NSXMLElement *element = (NSXMLElement *)node;
			
			if ([[element xmlns] hasPrefix:nsPrefix])
			{
				[elements addObject:element];
			}
		}
	}
	
	return elements;
}

- (NSXMLElement *)elementForName:(NSString *)name xmlnsPrefix:(NSString *)xmlnsPrefix{
    
    NSXMLElement *result = nil;
	
	for (NSXMLNode *node in [self children])
	{
		if ([node isKindOfClass:[NSXMLElement class]])
		{
			NSXMLElement *element = (NSXMLElement *)node;
			
			if ([[element name] isEqualToString:name] && [[element xmlns] hasPrefix:xmlnsPrefix])
			{
				result = element;
                break;
			}
		}
	}
	
	return result;
}

/**
 * The following methods return the corresponding value of the attribute with the given name.
**/

- (int)attributeIntValueForName:(NSString *)name
{
	return [[self attributeStringValueForName:name] intValue];
}
- (BOOL)attributeBoolValueForName:(NSString *)name
{
	return [[self attributeStringValueForName:name] boolValue];
}
- (float)attributeFloatValueForName:(NSString *)name
{
	return [[self attributeStringValueForName:name] floatValue];
}
- (double)attributeDoubleValueForName:(NSString *)name
{
	return [[self attributeStringValueForName:name] doubleValue];
}
- (int32_t)attributeInt32ValueForName:(NSString *)name
{
	int32_t result = 0;
	[NSNumber xmpp_parseString:[self attributeStringValueForName:name] intoInt32:&result];
	return result;
}
- (uint32_t)attributeUInt32ValueForName:(NSString *)name
{
	uint32_t result = 0;
	[NSNumber xmpp_parseString:[self attributeStringValueForName:name] intoUInt32:&result];
	return result;
}
- (int64_t)attributeInt64ValueForName:(NSString *)name
{
	int64_t result;
	[NSNumber xmpp_parseString:[self attributeStringValueForName:name] intoInt64:&result];
	return result;
}
- (uint64_t)attributeUInt64ValueForName:(NSString *)name
{
	uint64_t result;
	[NSNumber xmpp_parseString:[self attributeStringValueForName:name] intoUInt64:&result];
	return result;
}
- (NSInteger)attributeIntegerValueForName:(NSString *)name
{
	NSInteger result;
	[NSNumber xmpp_parseString:[self attributeStringValueForName:name] intoNSInteger:&result];
	return result;
}
- (NSUInteger)attributeUnsignedIntegerValueForName:(NSString *)name
{
	NSUInteger result = 0;
	[NSNumber xmpp_parseString:[self attributeStringValueForName:name] intoNSUInteger:&result];
	return result;
}
- (NSString *)attributeStringValueForName:(NSString *)name
{
	return [[self attributeForName:name] stringValue];
}
- (NSNumber *)attributeNumberIntValueForName:(NSString *)name
{
	return [NSNumber numberWithInt:[self attributeIntValueForName:name]];
}
- (NSNumber *)attributeNumberBoolValueForName:(NSString *)name
{
	return [NSNumber numberWithBool:[self attributeBoolValueForName:name]];
}
- (NSNumber *)attributeNumberFloatValueForName:(NSString *)name
{
	return [NSNumber numberWithFloat:[self attributeFloatValueForName:name]];
}
- (NSNumber *)attributeNumberDoubleValueForName:(NSString *)name
{
	return [NSNumber numberWithDouble:[self attributeDoubleValueForName:name]];
}
- (NSNumber *)attributeNumberInt32ValueForName:(NSString *)name
{
	return [NSNumber numberWithInt:[self attributeInt32ValueForName:name]];
}
- (NSNumber *)attributeNumberUInt32ValueForName:(NSString *)name
{
	return [NSNumber numberWithUnsignedInt:[self attributeUInt32ValueForName:name]];
}
- (NSNumber *)attributeNumberInt64ValueForName:(NSString *)name
{
	return [NSNumber numberWithLongLong:[self attributeInt64ValueForName:name]];
}
- (NSNumber *)attributeNumberUInt64ValueForName:(NSString *)name
{
	return [NSNumber numberWithUnsignedLongLong:[self attributeUInt64ValueForName:name]];
}
- (NSNumber *)attributeNumberIntegerValueForName:(NSString *)name
{
	return [NSNumber numberWithInteger:[self attributeIntegerValueForName:name]];
}
- (NSNumber *)attributeNumberUnsignedIntegerValueForName:(NSString *)name
{
	return [NSNumber numberWithUnsignedInteger:[self attributeUnsignedIntegerValueForName:name]];
}

/**
 * The following methods return the corresponding value of the attribute with the given name.
 * If the attribute does not exist, the given defaultValue is returned.
**/

- (int)attributeIntValueForName:(NSString *)name withDefaultValue:(int)defaultValue
{
	NSXMLNode *attr = [self attributeForName:name];
	return (attr) ? [[attr stringValue] intValue] : defaultValue;
}
- (BOOL)attributeBoolValueForName:(NSString *)name withDefaultValue:(BOOL)defaultValue
{
	NSXMLNode *attr = [self attributeForName:name];
	return (attr) ? [[attr stringValue] boolValue] : defaultValue;
}
- (float)attributeFloatValueForName:(NSString *)name withDefaultValue:(float)defaultValue
{
	NSXMLNode *attr = [self attributeForName:name];
	return (attr) ? [[attr stringValue] floatValue] : defaultValue;
}
- (double)attributeDoubleValueForName:(NSString *)name withDefaultValue:(double)defaultValue
{
	NSXMLNode *attr = [self attributeForName:name];
	return (attr) ? [[attr stringValue] doubleValue] : defaultValue;
}
- (NSString *)attributeStringValueForName:(NSString *)name withDefaultValue:(NSString *)defaultValue
{
    NSXMLNode *attr = [self attributeForName:name];
    return (attr) ? [attr stringValue] : defaultValue;
}
- (NSNumber *)attributeNumberIntValueForName:(NSString *)name withDefaultValue:(int)defaultValue
{
	return [NSNumber numberWithInt:[self attributeIntValueForName:name withDefaultValue:defaultValue]];
}
- (NSNumber *)attributeNumberBoolValueForName:(NSString *)name withDefaultValue:(BOOL)defaultValue
{
	return [NSNumber numberWithBool:[self attributeBoolValueForName:name withDefaultValue:defaultValue]];
}

/**
 * The following methods return the corresponding value of the node.
**/

- (int)stringValueAsInt
{
	return [[self stringValue] intValue];
}
- (BOOL)stringValueAsBool
{
	return [[self stringValue] boolValue];
}
- (float)stringValueAsFloat
{
	return [[self stringValue] floatValue];
}
- (double)stringValueAsDouble
{
	return [[self stringValue] doubleValue];
}
- (int32_t)stringValueAsInt32
{
	int32_t result;
	if ([NSNumber xmpp_parseString:[self stringValue] intoInt32:&result])
		return result;
	else
		return 0;
}
- (uint32_t)stringValueAsUInt32
{
	uint32_t result;
	if ([NSNumber xmpp_parseString:[self stringValue] intoUInt32:&result])
		return result;
	else
		return 0;
}
- (int64_t)stringValueAsInt64
{
	int64_t result = 0;
	if ([NSNumber xmpp_parseString:[self stringValue] intoInt64:&result])
		return result;
	else
		return 0;
}
- (uint64_t)stringValueAsUInt64
{
	uint64_t result = 0;
	if ([NSNumber xmpp_parseString:[self stringValue] intoUInt64:&result])
		return result;
	else
		return 0;
}
- (NSInteger)stringValueAsNSInteger
{
	NSInteger result = 0;
	if ([NSNumber xmpp_parseString:[self stringValue] intoNSInteger:&result])
		return result;
	else
		return 0;
}
- (NSUInteger)stringValueAsNSUInteger
{
	NSUInteger result = 0;
	if ([NSNumber xmpp_parseString:[self stringValue] intoNSUInteger:&result])
		return result;
	else
		return 0;
}

/**
 *	Shortcut to avoid having to use NSXMLNode everytime
**/
- (void)addNamespaceWithPrefix:(NSString *)prefix stringValue:(NSString *)string
{
	[self addNamespace:[NSXMLNode namespaceWithName:prefix stringValue:string]];
}

/**
 * Just to make your code look a little bit cleaner.
**/

- (NSString *)namespaceStringValueForPrefix:(NSString *)prefix
{
	return [[self namespaceForPrefix:prefix] stringValue];
}

- (NSString *)namespaceStringValueForPrefix:(NSString *)prefix withDefaultValue:(NSString *)defaultValue
{
	NSXMLNode *namespace = [self namespaceForPrefix:prefix];
	return (namespace) ? [namespace stringValue] : defaultValue;
}

@end
