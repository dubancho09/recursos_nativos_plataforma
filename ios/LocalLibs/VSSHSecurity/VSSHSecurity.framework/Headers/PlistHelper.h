//
//  PlistHelper.h
//  PlistComponent
//
//  Created by Pablo Andres Linares Murcia on 6/05/21.
//

#import <Foundation/Foundation.h>


@interface PlistHelper : NSObject

- (instancetype) initWithKey: (NSString*) key withIv:(NSString*) iv withFileName:(NSString*) filename;

- (instancetype) initWithKey: (NSString*) key withIv:(NSString*) iv withFileName:(NSString*) filename withBundle:(NSBundle*) bundle;

- (NSData*) decryptInfoData;

- (NSDictionary*) decryptInfoPlist;

@end
