#import <Foundation/Foundation.h>

@interface Contents : NSObject
+ (NSArray *)loadContents;
+ (NSDictionary *)newContent:(Class) class withTitle:(NSString *)title andDescription:(NSString *)description;
@end