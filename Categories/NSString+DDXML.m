#import "NSString+DDXML.h"


@implementation NSString (DDXML)

- (const xmlChar *)xmlChar
{
	return (const xmlChar *)[self UTF8String];
}

#ifdef GNUSTEP
- (NSString *)stringByTrimming
{
	return [self stringByTrimmingSpaces];
}
#else
- (NSString *)stringByTrimming
{
	NSMutableString *mStr = [self mutableCopy];
	CFStringTrimWhitespace((__bridge CFMutableStringRef)mStr);
	
	NSString *result = [mStr copy];

	return result;
}
#endif

@end
