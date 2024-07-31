//
//  AesCrypto.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/6/18.
//  Copyright © 2018 Valid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VsshCryptoManager.h"

@interface AesCrypto : NSObject <VsshCryptoManager>

//Operations create for Daviplata Project

- (NSString *)encryptString: (NSString*)text key: (NSString*)key iv: (NSString*)iv;

- (NSString *)decryptString: (NSString*)text key: (NSString*)key iv: (NSString*)iv;

@end
