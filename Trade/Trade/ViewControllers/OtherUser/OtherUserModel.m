//
//  OtherUserModel.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/3.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "OtherUserModel.h"
#import "App.h"
@implementation OtherUserModel
- (void)requsetUrl:(NSString *)uid userModel:(UserModel) userModel
{
    if (!uid) {
        return;
    }
    [App httpGET:AppURL_User_Usercenter headerWithUserInfo:YES parameters:@{@"userId":uid} successBlock:^(int code, NSDictionary *dictResp) {
        
        if ([dictResp isKindOfClass:[NSDictionary class]]) {
            if ([dictResp intForKey:@"code"]==1) {
                NSDictionary *data=[dictResp dictionaryForKey:@"data"];
                if (data) {
                    userModel([self  initWithDictionary:data error:nil]);
                }
                
            }
        };
    } failureBlock:^(NSError *error) {
        
    }];
}

@end
