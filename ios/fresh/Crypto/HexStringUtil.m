#import "HexStringUtil.h"


@implementation HexStringUtil

//hexString to ByteArray
+ (NSMutableData *) hexStringToByteArray: (NSString*) hexString  
{
	char byte_chars[3] = {'\0','\0','\0'};
	unsigned char whole_byte;
	NSUInteger strLen;
	
	if(hexString == nil )
	{
		//DLog(@"hex string is null. please check it");
		return nil;
	}
	
	strLen = [hexString length];
	
	__autoreleasing NSMutableData *byteArray =  [[NSMutableData alloc] init];
	
	for (int i=0; i < strLen/2 ; i++) {
		byte_chars[0] = [hexString characterAtIndex:i*2];
		byte_chars[1] = [hexString characterAtIndex:i*2+1];
		whole_byte = strtol(byte_chars, NULL, 16);
		
		
		[byteArray appendBytes:&whole_byte length:1]; 
	}
	
	return byteArray;
}


//byteArray To HexString
+ (NSMutableString *) byteArrayToHexString: (NSData*) aData  {
	NSUInteger dataLen;
	unsigned char * ptr;
	
	NSString * subString;
	
	dataLen = [aData length] ;
	__autoreleasing NSMutableString * hexString = [[NSMutableString alloc] initWithString:@""];
	
	ptr = (unsigned char *) [aData bytes];
	
	for (int i=0; i < dataLen ; i++) {
		subString = [NSString stringWithFormat:@"%02x", ptr[i]]; 
		[hexString appendString:subString];
	}
	
	return hexString;
}


@end
