//
//  VsshCryptoManager.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/6/18.
//  Copyright © 2018 Valid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VsshKey.h"
#import "EncryptionType.h"

@protocol VsshCryptoManager <NSObject>

- (NSData*) decrypt:(EncryptionType)type data:(NSString*)data withKey:(id<VsshKey>)key;
- (NSData*) encrypt:(EncryptionType)type data:(NSString*)data withKey:(id<VsshKey>)key;
#pragma mark - Tuya Method
- (NSArray*)encryptStringForHSMString:(NSString *)str withKeyString:(NSString *)hsmKey;

@end
