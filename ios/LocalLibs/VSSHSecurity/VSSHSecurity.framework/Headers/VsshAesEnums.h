//
//  VsshAesEnums.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/6/18.
//  Copyright © 2018 Valid. All rights reserved.
//

typedef NS_ENUM(NSUInteger, VsshAesKeySize) {
    VsshAesKey256 = 32,
    VsshAesKey192 = 24,
    VsshAesKey128 = 16
};

typedef NS_ENUM(NSInteger, VsshAesMode) {
    VsshAesModeCBC = 1,
    VsshAesModeGCM = 2
};
