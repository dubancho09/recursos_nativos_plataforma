//
//  SecurityUtils.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/7/18.
//  Copyright © 2018 Valid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtils : NSObject

/**
 * Convert a string in hexadecimal representation to NSData object
 *
 * @param string The string in hexadecimal representation to convert to NSData
 * @return The data
 */
+ (NSData *)getDataFromHexString:(NSString *)string;

/**
 * Convert a NSData object to hexadecimal string
 *
 * @param data The NSData object to convert to hex string
 * @return The string in hex representation
 */
+ (NSString *)getHexStringFromData:(NSData *)data;

@end
