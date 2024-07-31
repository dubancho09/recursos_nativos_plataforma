//
//  EncryptionType.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/7/18.
//  Copyright © 2018 Valid. All rights reserved.
//

typedef enum : NSInteger {
    AES_CBC          = 1,
    AES_GCM          = 2,
    DES_EDE_CBC      = 11,
    RSA_PKCS1        = 22,
    RSA_OAEP         = 24
} EncryptionType;
