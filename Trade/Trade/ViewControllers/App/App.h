//
//  App.h
//  Trade
//
//  Created by Yuyangdexue on 15/10/27.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

typedef void (^completeBlock_t)(NSDictionary *dic);
typedef void (^errorBlock_t)(NSError *error);
typedef NS_ENUM( NSInteger , AppURL)
{
    AppURL_Start=1000,
    AppURL_Register,
    AppURL_Login,
    AppURL_Album_Uploadtoken,//封面
    AppURL_Picture_Addtext, // 添加文字
    AppURL_Picture_Uploadtoken,// 添加图片获取token
    AppURL_Album_Submit,// 发布
    AppURL_Feed_Getfeed,// feed 首页
    AppURL_Feed_Getdetail,// feed 详情
    AppURL_User_Usercenter,// 获取其他用户信息
    AppURL_Feed_Getothersalbum,// 获取其他用户图记
    AppURL_Feed_Collect,// 获取其他用户收藏图记
    AppURL_Discover_Getdiscover,//  dycontent
    AppURL_Operation_Getoperation,//  yunxing tu
    AppURL_Zero
};


typedef NS_ENUM(NSInteger, UserKey)
{
    UserKey_End=1000,
    UserKey_Iphone,
    UserKey_Token,
    UserKey_AccessToken,
    UserKey_Id,
    UserKey_Uname,
    UserKey_Password,
    UserKey_LoginStatus,
    
    UserKey_Zero
};



@interface App : NSObject

+(instancetype)instance;



//==============
- (void)removeKey:(int)ikey;

- (void)setArray:(int)ikey arr:(NSArray *)arr;
- (NSArray *)getArray:(int)ikey;

- (NSDictionary *)getDictionary:(int)ikey;
- (void)setDictionary:(int)ikey dict:(NSDictionary *)dict;

- (NSString *)getString:(int)ikey;
- (void)setString:(int)ikey str:(NSString *)str;

- (BOOL)getBool:(int)ikey;
- (void)setBool:(int)ikey val:(BOOL)val;

- (int)getInteger:(int)ikey;
- (void)setInteger:(int)ikey val:(int)val;
//===========


+ (void)httpGET:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock;

+ (void)httpPOST:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
      parameters:(NSDictionary *)parameters
    successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
    failureBlock:(void (^)(NSError *error))failureBlock;

+ (void)cacheHttpResult:(NSString *)strKey content:(NSDictionary *)content;

- (void)cancelHttpMethods;

+ (void)uploadImage:(NSString *)token  key:(NSString *)key data:(NSData *)data completeBlock:(completeBlock_t)completeBlock  errorBlock:(errorBlock_t)errorBlock;

+ (NSString *)getUpPhotoName:(NSString *)fileName;
- (NSString *)getTimeStamp;
@end
