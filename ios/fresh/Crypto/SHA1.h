#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface SHA1 : NSObject {

}

+(NSString*) digest:(NSString*)input;

@end
