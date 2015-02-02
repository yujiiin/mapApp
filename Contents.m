
#import <Foundation/Foundation.h>
#import "Contents.h"

#import "CurrentLocationViewController.h"
#import "SearchLocationViewController.h"


@implementation Contents

+ (NSArray *)loadContents{
    NSArray *contents = @[[self newContent:[CurrentLocationViewController class] withTitle:@"Current Location" andDescription:nil]
                          ,[self newContent:[SearchLocationViewController class] withTitle:@"Search Location" andDescription:nil]
                          ];
    
    return contents;
}

+ (NSDictionary *)newContent:(Class) class
                withTitle:(NSString *)title
           andDescription:(NSString *)description {
    return [[NSDictionary alloc] initWithObjectsAndKeys:class, @"controller",
            title, @"title", description, @"description", nil];
}
@end
