//
//  VsshKeyPair.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/5/18.
//  Copyright © 2018 Valid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VsshPublicKey;
@protocol VsshPrivateKey;

@interface VsshKeyPair : NSObject

@property(strong) id <VsshPrivateKey> privateKey;
@property(strong) id <VsshPublicKey> publicKey;

@end
