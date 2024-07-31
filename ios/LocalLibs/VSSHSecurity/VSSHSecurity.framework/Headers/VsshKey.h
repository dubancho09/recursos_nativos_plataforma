//
//  VsshKey.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/5/18.
//  Copyright © 2018 Valid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VsshKey <NSObject>

- (NSString*) getAlgorithm;

- (NSData*) getDataValue;

@end
