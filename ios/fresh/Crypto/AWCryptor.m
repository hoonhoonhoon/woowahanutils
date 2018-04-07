#import <CommonCrypto/CommonCryptor.h>
#import "SHA1.h"
#import "AWCryptor.h"
#import "HexStringUtil.h"

@interface AWCryptor ()

// 암복호화
+ (NSString*) encrypt:(NSString*)srcStr key:(NSString *)key;
+ (NSData*) decrypt:(NSData*)cipherData key:(NSString *)key;

@end

@implementation AWCryptor

#pragma mark -
#pragma mark Cryptor

NSString* key = @"1234567890~!";


- (NSString*) digest:(NSString*)input {
	return [SHA1 digest:input];
}

// 암복호화
+ (NSString *) encrypt:(NSString*)srcStr key:(NSString *)key {
	uint8_t iv[kCCBlockSizeAES128];
	memset((void *) iv, 0x0, (size_t) sizeof(iv));
	NSString *token = srcStr;
	//DDLog(@"token %@", token);
	NSData *keyData   = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSData *plainData = [token dataUsingEncoding:NSUTF8StringEncoding];
	//	NSData *plainData = srcStr;
	NSMutableData *encData = [NSMutableData dataWithLength: plainData.length + kCCBlockSizeAES128];
	size_t bytesWritten = 0;
	CCCryptorStatus ccStatus;
	ccStatus = CCCrypt(kCCEncrypt,
					   kCCAlgorithmAES128,
					   kCCOptionPKCS7Padding, /*kCCOptionPKCS7Padding|kCCOptionPKCS7Padding, */
					   [keyData bytes],   //[IN]key
					   kCCKeySizeAES128,     //[IN]key length
					   iv,              //[IN]iv,
					   [plainData bytes], //[IN]plainText
					   [plainData length],//[IN]plainText length
					   encData.mutableBytes, //[OUT]encryptText
					   encData.length,       //[OUT]encryptText
					   &bytesWritten);       //
	
	if (ccStatus){;}
    
	encData.length = bytesWritten;
	return [HexStringUtil byteArrayToHexString:encData];
}


+ (NSData *) decrypt:(NSData*)cipherData key:(NSString *)key {
	uint8_t iv[kCCBlockSizeAES128];
	memset((void *) iv, 0x0, (size_t) sizeof(iv));
	NSData *keyData   = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *decData = [NSMutableData dataWithLength: cipherData.length + kCCBlockSizeAES128];
	size_t bytesWritten = 0;
	CCCryptorStatus ccStatus;
	ccStatus = CCCrypt(kCCDecrypt,
					   kCCAlgorithmAES128,
					   /*kCCOptionPKCS7Padding|*/kCCOptionPKCS7Padding,
					   [keyData bytes],   //[IN]key
					   kCCKeySizeAES128,     //[IN]key length
					   iv,              //[IN]iv,
					   [cipherData bytes], //[IN]plainText
					   [cipherData length],//[IN]plainText length
					   decData.mutableBytes, //[OUT]encryptText
					   decData.length,       //[OUT]encryptText
					   &bytesWritten);       //

	if (ccStatus){;}
	decData.length = bytesWritten;	
	return decData;
}

+ (NSString *) encrypt:(NSString *)dataString {
	NSString * privateKey = key;
	if (privateKey) {
		return [AWCryptor encrypt:dataString key:privateKey];
	}
	return nil;
}

+ (NSString *) decrypt:(NSString *)dataString {
	return [self decrypt:dataString keyString: key];
}

+ (NSString *) decrypt:(NSString *)dataString keyString:(NSString *)keyString {
	if (keyString) {
		NSMutableData * cipherData = [HexStringUtil hexStringToByteArray:dataString];
		NSData *originalData = [self decrypt:cipherData key:keyString];

		NSString *originalText = [[NSString alloc] initWithData:originalData encoding:NSUTF8StringEncoding];
		return originalText;
	}
	return nil;
}

+ (NSString *)cipherStringToPlainString:(NSString *)cipherString{
	if (cipherString == nil) {
		return nil;
	}
	NSMutableData * cipherData= [HexStringUtil hexStringToByteArray:cipherString];
	
	NSString * privateKey = key;
	if (privateKey != nil) {
	
		NSData *originalData = [self decrypt:cipherData key:privateKey];
		
		NSString *originalText = [[NSString alloc] initWithData:originalData encoding:NSUTF8StringEncoding];
		return originalText;
	}
	return nil;
}

@end
