//
//  FeedModel.h
//  Trade
//
//  Created by Yuyangdexue on 15/11/2.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "App.h"
@class FeedModel;
typedef void(^successBlock_t)(NSArray *arr, AppURL appUrl);
@interface FeedModel : JSONModel

@property (nonatomic,strong) NSString <Optional>*album_id;
@property (nonatomic,strong) NSString <Optional>*user_id;
@property (nonatomic,strong) NSString <Optional>*title;
@property (nonatomic,strong) NSString <Optional>*update_time;
@property (nonatomic,strong) NSString <Optional>*view_num;
@property (nonatomic,strong) NSString <Optional>*cover;
@property (nonatomic,strong) NSString <Optional>*like_num;
@property (nonatomic,strong) NSString <Optional>*username;
@property (nonatomic,strong) NSString <Optional>*status;
@property (nonatomic,strong) NSString <Optional>*avatar;

- (void)appUrl:(AppURL )appUrl paramers:(NSDictionary *)dic successBlock:(successBlock_t)block;

@end
