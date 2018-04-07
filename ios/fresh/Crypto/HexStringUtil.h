#import <Foundation/Foundation.h>

@interface HexStringUtil : NSObject {

}

+ (NSMutableData *) hexStringToByteArray: (NSString*) hexString;
+ (NSMutableString *) byteArrayToHexString: (NSData*) aData;
@end
