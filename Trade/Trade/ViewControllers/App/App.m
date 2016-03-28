//
//  App.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/27.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "App.h"
#import "Constants.h"
@implementation App


+ (instancetype)instance {
    static App *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [App new];
    });
    return _instance;
}

#pragma mark NSUserDefaults
- (void)removeKey:(int)ikey {
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)getArray:(int)ikey {
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    NSArray *temp = [[NSUserDefaults standardUserDefaults] arrayForKey:strKey];
    
    return temp;
}

- (void)setArray:(int)ikey arr:(NSArray *)arr {
    if (arr == nil) {
        [self removeKey:ikey];
        return;
    }
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    [[NSUserDefaults standardUserDefaults] setObject:[arr copy] forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)getDictionary:(int)ikey {
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    NSDictionary *temp =
    [[NSUserDefaults standardUserDefaults] dictionaryForKey:strKey];
    return temp;
}

- (void)setDictionary:(int)ikey dict:(NSDictionary *)dict {
    if (dict == nil) {
        [self removeKey:ikey];
        return;
    }
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    [[NSUserDefaults standardUserDefaults] setObject:[dict copy] forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getString:(int)ikey {
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    NSString *temp = [[NSUserDefaults standardUserDefaults] stringForKey:strKey];
    return temp ? temp : @"";
}

- (void)setString:(int)ikey str:(NSString *)str {
    if (str == nil) {
        [self removeKey:ikey];
        return;
    }
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    [[NSUserDefaults standardUserDefaults] setObject:[str copy] forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)getBool:(int)ikey {
    
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    return [[NSUserDefaults standardUserDefaults] boolForKey:strKey];
}

- (void)setBool:(int)ikey val:(BOOL)val {
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)getInteger:(int)ikey {
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:strKey];
}

- (void)setInteger:(int)ikey val:(int)val {
    NSString *strKey = [NSString stringWithFormat:@"%d", ikey];
    [[NSUserDefaults standardUserDefaults] setInteger:val forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)uploadImage:(NSString *)token  key:(NSString *)key data:(NSData *)data completeBlock:(completeBlock_t)completeBlock  errorBlock:(errorBlock_t)errorBlock;
{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putData:data key:key token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", info);
                  NSLog(@"%@", resp);
                  if ([resp  isKindOfClass:[NSDictionary class]]) {
                      
                      if ([[resp stringForKey:@"ret"] isEqualToString:@"success"]) {
                          completeBlock(resp);
                      }
                      else
                      {
//                          NSError *error;
//                          errorBlock_t(error);
                      }
                      
                  }
              } option:nil];
}
+ (NSString *)getUpPhotoName:(NSString *)fileName
{
    NSLog(@"upload fileName ===  %@",[NSString stringWithFormat:@"%@_%@_%@",[[UserEntity instance]accessToken],[[App instance] getTimeStamp],fileName]);
    return [NSString stringWithFormat:@"%@_%@_%@",[[UserEntity instance]accessToken],[[App instance] getTimeStamp],fileName];
}

- (NSString *)getTimeStamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    NSLog(@"timeString=====%@",timeString);
    return timeString;
}




#pragma mark httpMethods
+ (void)httpGET:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock {
    [[App instance] httpMethod:appUrl
                      isPostMethod:NO
                headerWithUserInfo:headerWithUserInfo
                            params:parameters
                      successBlock:successBlock
                      failureBlock:failureBlock];
}

+ (void)httpPOST:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
      parameters:(NSDictionary *)parameters
    successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
    failureBlock:(void (^)(NSError *error))failureBlock {
    [[App instance] httpMethod:appUrl
                      isPostMethod:YES
                headerWithUserInfo:headerWithUserInfo
                            params:parameters
                      successBlock:successBlock
                      failureBlock:failureBlock];
}

+ (void)cacheHttpResult:(NSString *)strKey content:(NSDictionary *)content {
    if (strKey && strKey.length > 0 && content) {
        //    [CacheFile cache_file_set:strKey contents:[content JSONString]];
    }
}
- (void)httpMethod:(AppURL)appUrl
      isPostMethod:(BOOL)isPostMethod
headerWithUserInfo:(BOOL)headerWithUserInfo
            params:(NSDictionary *)params
      successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
      failureBlock:(void (^)(NSError *error))failureBlock {
    
    
    // TODO: 使用Cache来返回http请求结果
    NSString *strCacheKey = @"";
    NSInteger iCacheSeconds = 0;
    NSString *strCache =
    [CacheFile cache_file_get:strCacheKey expiredSecond:iCacheSeconds];
    if (strCache && strCache.length > 0) {
        NSData *data = [strCache dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = (NSDictionary *)
        [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        int code = [dict intForKey:@"code"];
        if (code == 1) {
            DLog(@"use httpcache ====> %@", strCacheKey);
            successBlock(code, dict);
        }
        return;
    }
    
    AFHTTPRequestOperationManager *manager =
    [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",
     @"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    if (headerWithUserInfo) {
    //
    //        [manager.requestSerializer  setValue:kHeaderToken forHTTPHeaderField:@"TOKEN"];
    //
    //        NSString *signAtureString=[NSString stringWithFormat:@"%@%@",kHeaderToken,[self getTimeStamp]];
    //
    //        [manager.requestSerializer  setValue:[self getTimeStamp]forHTTPHeaderField:@"TIMESTAMP"];
    //        [manager.requestSerializer  setValue:[signAtureString MD5] forHTTPHeaderField:@"SIGNATURE"];
    //    }
    //    if ([UserEntity instance].userToken) {
    //        [manager.requestSerializer  setValue:@"UTOKEN" forHTTPHeaderField:[UserEntity instance].userToken];
    //    }
//    if ([UserEntity instance].userId) {
//        NSLog(@"[UserEntity instance].userId====%@",[UserEntity instance].userId);
//        [manager.requestSerializer  setValue:[UserEntity instance].userId forHTTPHeaderField:@"UID"];
//    }
    
    [manager.requestSerializer  setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    
    if ([UserEntity instance].userId) {
        [manager.requestSerializer  setValue:[UserEntity instance].userId forHTTPHeaderField:@"Tuji-SessionId"];
         NSLog(@"[UserEntity instance].userId ===%@",[UserEntity instance].userId );
        [manager.requestSerializer  setValue:[UserEntity instance].userToken forHTTPHeaderField:@"Tuji-Token"];
         NSLog(@"[UserEntity instance].userToken ===%@",[UserEntity instance].userToken );
    }
    
    NSString *strUrl = [HttpRequestClass stringHttpUrl:appUrl];
    NSLog(@"strUrl===%@",strUrl);
    NSLog(@"params=========%@",params);
    if (isPostMethod) {
        [manager POST:strUrl
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"responseObject===%@",responseObject);
                  if (![responseObject isKindOfClass:[NSDictionary class]]) {
                      NSLog(@"返回值格式不正确 ");
                      [SVProgressHUD showInfoWithStatus:@"返回值格式不正确"];
                      
                      return;
                  }
                  
                  
                  NSDictionary *dict = (NSDictionary *)responseObject;
                  
                  NSLog(@"message=%@",[dict stringForKey:@"msg"]);
                  int code = [dict intForKey:@"code"];
                  
                  // TODO: 存储Cache
                 // [[self class] cacheHttpResult:strCacheKey content:dict];
                  successBlock(code, dict);
                  
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failureBlock(error);
              }];
    } else {
        [manager GET:strUrl
          parameters:params
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 if (![responseObject isKindOfClass:[NSDictionary class]]) {
                     NSLog(@"返回值格式不正确");
                     [SVProgressHUD showInfoWithStatus:responseObject];
                     
                     return;
                 }
                 NSDictionary *dict = (NSDictionary *)responseObject;
                 int code = [dict intForKey:@"code"];
                 // TODO: 存储Cache
                // [[self class] cacheHttpResult:strCacheKey content:dict];
                 successBlock(code, dict);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 failureBlock(error);
             }];
    }
}
- (void)cancelHttpMethods
{
    
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
}

@end
