//
//  HttpRequestClass.m
//  huaqiao
//
//  Created by yiliao6 on 13/4/15.
//  Copyright (c) 2015 yiliao6. All rights reserved.
//

#import "HttpRequestClass.h"
#import "App.h"

@implementation HttpRequestClass

#pragma mark - 监测网络的可链接性
+ (BOOL)httpReachability:(NSInteger)kUrl {
    
    __block BOOL netState = NO;
    NSString *strUrl = [HttpRequestClass stringHttpUrl:kUrl];
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    AFHTTPRequestOperationManager *manager =
    [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         switch (status) {
             case AFNetworkReachabilityStatusReachableViaWWAN:
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 [operationQueue setSuspended:NO];
                 netState = YES;
                 break;
             case AFNetworkReachabilityStatusNotReachable:
                 netState = NO;
             default:
                 [operationQueue setSuspended:YES];
                 break;
         }
     }];
    
    [manager.reachabilityManager startMonitoring];
    return netState;
}

+ (NSString *)stringHttpUrl:(NSInteger)kUrl {
    NSString *strSuffix = @"";
    switch (kUrl) {
            
        case AppURL_Register:
            strSuffix = @"site/signup";
            break;
        case AppURL_Login:
            strSuffix = @"site/login";
            break;
        case AppURL_Album_Uploadtoken:
            strSuffix = @"album/uploadtoken";
            break;
        case AppURL_Picture_Addtext:
            strSuffix = @"picture/addtext";
            break;
        case AppURL_Picture_Uploadtoken:
            strSuffix = @"picture/uploadtoken";
            break;
        case AppURL_Album_Submit:
            strSuffix = @"album/submit";
            break;
        case AppURL_Feed_Getfeed:
            strSuffix = @"feed/getfeed";
            break;
        case AppURL_Feed_Getdetail:
            strSuffix = @"feed/getdetail";
            break;
        case AppURL_User_Usercenter:
            strSuffix = @"user/usercenter";
            break;
        case AppURL_Feed_Getothersalbum:
            strSuffix = @"feed/getothersalbum";
            break;
        case AppURL_Feed_Collect:
            strSuffix = @"feed/collect";
            break;
        case AppURL_Discover_Getdiscover:
            strSuffix = @"discover/getdiscover";
            break;
        case AppURL_Operation_Getoperation:
            strSuffix = @"operation/getoperation";
            break;
            
        default:
            break;
    }
    if (strSuffix.length > 0) {
        return [NSString stringWithFormat:@"%@%@", PREFIX_URL, strSuffix];
    }
    return strSuffix;
}

+ (void)httpRequest:(NSInteger)appUrl
       isPostMethod:(BOOL)isPostMethod
            headers:(NSDictionary *)headers
             params:(NSDictionary *)params
WithCompletionBlock:(void (^)(id retData))completionBlock
   WithFailureBlock:(void (^)(NSError *err))failureBlock {
    
    AFHTTPRequestOperationManager *manager =
    [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [headers enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *val,
                                                 BOOL *stop) {
        [manager.requestSerializer setValue:val forHTTPHeaderField:key];
    }];
    
    NSLog(@"HTTPRequestHeaders=====> %@",
          manager.requestSerializer.HTTPRequestHeaders);
    
    void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) =
    ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseString========%@", operation.responseString);
        //        NSDictionary *dict = (NSDictionary *)responseObject;
        //        NSLog(@"responseDict========> %@", dict);
        completionBlock(responseObject);
    };
    
    void (^errBlock)(AFHTTPRequestOperation *operation, NSError *error) =
    ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" errBlock - responseString========> %@ \n %@",
              operation.responseString, [error description]);
        failureBlock(error);
    };
    
    NSString *strUrl = [HttpRequestClass stringHttpUrl:appUrl];
    NSLog(@"managerReq======>%@", strUrl);
    if (isPostMethod) {
        [manager POST:strUrl
           parameters:params
              success:successBlock
              failure:errBlock];
    } else {
        [manager GET:strUrl
          parameters:params
             success:successBlock
             failure:errBlock];
    }
}

@end
