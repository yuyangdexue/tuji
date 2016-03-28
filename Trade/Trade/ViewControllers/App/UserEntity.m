//
//  UserEntity.m
//  Trade
//
//  Created by admin on 15/9/2.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import "UserEntity.h"
#import "App.h"
@implementation UserEntity



//创建用户单利
+(UserEntity *)instance;
{
    static dispatch_once_t pred;
    static UserEntity * currentUser;
    dispatch_once(&pred, ^{
        currentUser = [[UserEntity alloc]init];
    });
    return currentUser;
}

- (void)setUserId:(NSString *)userId
{
    [[App instance] setString:UserKey_Id str:userId];
}

- (void)setUName:(NSString *)uName
{
    [[App instance] setString:UserKey_Uname str:uName];
}


- (void)setUserToken:(NSString *)userToken
{
    [[App instance] setString:UserKey_Token str:userToken];

}

- (void)setAccessToken:(NSString *)accessToken
{
    [[App instance] setString:UserKey_AccessToken str:accessToken];
}

- (void)setUserPhone:(NSString *)userPhone
{
    [[App instance] setString:UserKey_Iphone str:userPhone];
}

- (void)setUserPass:(NSString *)userPassword
{
    [[App instance] setString:UserKey_Password str:userPassword];
}
- (void)setIsLogin:(BOOL)isLogin
{
    [[App instance] setBool:UserKey_LoginStatus val:isLogin];
}


- (BOOL)isLogin
{
    return  [[App instance] getBool:UserKey_LoginStatus];
}
- (NSString *)userIphone
{
    return [[App instance]getString:UserKey_Iphone];
    
}
- (NSString *)userPassword
{
    return [[App instance]getString:UserKey_Password];
}

- (NSString *)userToken
{
    return [[App instance]getString:UserKey_Token];

}

- (NSString*)accessToken
{
    return [[App instance]getString:UserKey_AccessToken];
}

- (NSString *)userId
{
    return [[App instance]getString:UserKey_Id];
}







@end
