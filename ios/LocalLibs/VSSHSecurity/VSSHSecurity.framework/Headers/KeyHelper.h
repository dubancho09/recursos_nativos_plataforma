//
//  KeyHelper.h
//  vssh-ios-security
//
//  Created by Jhon Fredy Pardo Patiño on 12/5/18.
//  Copyright © 2018 Valid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VsshKey.h"
#import "VsshKeyPair.h"
#import "VsshAesEnums.h"
#import "VsshDesEnums.h"
#import "VsshRsaEnums.h"

@interface KeyHelper : NSObject

/**
 * Generates a random key for DES or 3DES
 *
 * @param mode The mode of the key.
 * @return The random key or null on error.
 */
+ (id<VsshKey> _Nullable) generateRandom3DesKey:(VsshDesMode)mode;

/**
 * Generates a random key for AES
 *
 * @param mode The mode of the key. It can be CBC or GCM
 * @param size The size of the key.
 * @return The random key or null on error.
 */
+ (id<VsshKey> _Nullable) generateRandomAesKey:(VsshAesMode)mode withSize:(VsshAesKeySize)size;

/**
 * Generates a key for AES with the given key data
 *
 * @param mode  The mode of the key. It can be CBC or GCM
 * @param key   The given key data.
 * @param error The error if any ocurred
 * @return The key or null on error.
 * @warning The key data lenght should be 128, 192 or 256.
 */
+ (id<VsshKey> _Nullable) generateAesKey:(VsshAesMode)mode withKey:(NSData* _Nonnull)key error:(NSError*_Nullable*_Nullable)error;

/**
 * Generates RSA private / public key pair
 *
 * @param size of the key.
 * @return The key pair
 */
+ (VsshKeyPair* _Nullable) generateRsaKeyPair:(VsshRsaKeySize)size;

/**
 * Get string from private key
 *
 * @param privKey The private key
 * @return The string representation of private key in PEM format
 */
+ (NSString* _Nonnull) getStringFromPrivateKey:(id<VsshPrivateKey> _Nonnull)privKey;

/**
 * Get string from public key
 *
 * @param pubKey The public key
 * @return The string representation of public key in PEM format
 */
+ (NSString* _Nonnull) getStringFromPublicKey:(id<VsshPublicKey> _Nonnull)pubKey;

/**
 * Verify signature of data using RSA with SHA-256
 *
 * @param data      Data to verify signature
 * @param pubKey    The public key of the signature
 * @param signature The signature
 * @return True if signature is correct
 */
+ (BOOL) verifySignature:(NSData* _Nonnull)data publicKey:(id<VsshPublicKey> _Nonnull)pubKey signature:(NSData* _Nonnull)signature;

/**
 * Sign data with the private key using RSA with SHA-256
 *
 * @param data    The data to sign
 * @param privKey The private key to use for signing
 * @param error   Will be set if an error occurs.
 * @return The signed byte array. Empty array on error
 */
+ (NSData* _Nullable) signData:(NSData* _Nonnull)data withPrivateKey:(id<VsshPrivateKey> _Nonnull)privKey error:(NSError *_Nullable*_Nullable)error;

/**
 * Get public key from string
 *
 * @param keyString The string containing the public key or certificate using \n for new line separator.
 * @return The public key or null on error
 */
+ (id<VsshPublicKey> _Nullable) getPublicKeyFromString:(NSString* _Nonnull)keyString;

/**
 * Get fingerprint of app
 *
 * @return The unique id per installation
 */
+ (NSString* _Nullable) getFingerPrint;

/**
 * Generate a derivated aes key data from the pin
 *
 * @param pin The base to generate the derivated aes key. Its length has to be greater than 3
 * @return The key data of the derivated key
 */
+ (NSData* _Nullable)generateDerivatedAesKey:(NSString * _Nonnull)pin;
/**
 * Encripted data string by publickey string
 *
 * @param data The base to generate the derivated aes key.
 * @param publicKey The base to generate the derivated aes key.
 * @return The key data of the derivated key
 */
+ (NSString* _Nullable)encryptRSA:(NSString * _Nonnull)data publicKey:(NSString * _Nonnull)publicKey;

/**
* Get Sha256  string from string
*
* @param string
* @return The string hex of string
*/
+ (NSString* _Nullable)getHexSha256From:(NSString * _Nullable)string;

@end
