#import <Foundation/Foundation.h>


@interface AWCryptor : NSObject

- (NSString*) digest:(NSString*)input;

// AW - using
+ (NSString*) encrypt:(NSString*)dataString;
+ (NSString*) encrypt:(NSString*)srcStr key:(NSString *)key;
+ (NSString*) decrypt:(NSString*)dataString;
+ (NSString*) decrypt:(NSString*)dataString keyString:(NSString*)keyString;

@end
