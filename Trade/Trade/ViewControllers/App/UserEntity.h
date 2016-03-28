//
//  UserEntity.h
//  Trade
//
//  Created by admin on 15/9/2.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, competence){//用户权限
    little,
    more,
    all
};

@interface UserEntity : NSObject

@property (assign,nonatomic)competence limit;
@property (strong,nonatomic) NSString * userPhone;
@property (strong,nonatomic) NSString * userPass;
@property (strong,nonatomic) NSString * userToken;
@property (strong,nonatomic) NSString * accessToken;
@property (strong,nonatomic) NSString * userId;
@property (strong,nonatomic) NSString * uName;
@property (assign,nonatomic) BOOL isLogin;//是否登录



+(UserEntity *)instance;

- (void)setUName:(NSString *)uName;
- (void)setUserId:(NSString *)userId;
- (void)setUserToken:(NSString *)userToken;

- (void)setAccessToken:(NSString *)accessToken;

- (void)setUserPhone:(NSString *)userPhone;

- (void)setUserPass:(NSString *)userPassword;
- (void)setIsLogin:(BOOL)isLogin;



- (BOOL)isLogin;
- (NSString *)userIphone;
- (NSString *)userPassword;

- (NSString *)userToken;
- (NSString *)userId;
- (NSString *)accessToken;
@end
