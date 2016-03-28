//
//  FeedDetailModel.h
//  Trade
//
//  Created by Yuyangdexue on 15/11/2.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DetailModel

@end
@interface DetailModel : JSONModel

@property (nonatomic,strong) NSString <Optional> *content;
@property (nonatomic,strong) NSString <Optional> *imgUrl;
@property (nonatomic,strong) NSString <Optional> *picture_id;
@property (nonatomic,strong) NSString <Optional> *height;
@property (nonatomic,strong) NSString <Optional> *width;
@end
@protocol FeedDetailModel

@end

@interface FeedDetailModel : JSONModel

@property (nonatomic,strong) NSString <Optional> *picture_id;
@property (nonatomic,strong) NSString <Optional> *avatar;
@property (nonatomic,strong) NSString <Optional> *cover;
@property (nonatomic,strong) NSString <Optional> *like_num;
@property (nonatomic,strong) NSString <Optional> *status;
@property (nonatomic,strong) NSString <Optional> *title;
@property (nonatomic,strong) NSString <Optional> *update_time;
@property (nonatomic,strong) NSString <Optional> *user_id;
@property (nonatomic,strong) NSString <Optional> *username;
@property (nonatomic,strong) NSString <Optional> *view_num;
@property (nonatomic,strong) NSArray  <Optional,DetailModel> *detail;

@end

@interface SuperFeedDetailModel : JSONModel
@property (nonatomic,strong) NSString <Optional> *code;
@property (nonatomic,strong) NSDictionary <Optional> *data;
@property (nonatomic,strong) NSString <Optional> *msg;
@end
