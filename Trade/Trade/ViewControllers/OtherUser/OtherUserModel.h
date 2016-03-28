//
//  OtherUserModel.h
//  Trade
//
//  Created by Yuyangdexue on 15/11/3.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class OtherUserModel;
typedef void (^UserModel)(OtherUserModel *model);
@interface OtherUserModel : JSONModel

@property (nonatomic,strong)NSString <Optional>*avatar;
@property (nonatomic,strong)NSString <Optional>*username;
@property (nonatomic,strong)NSString <Optional>*tujiCount;
@property (nonatomic,strong)NSString <Optional>*likeCount;

- (void)requsetUrl:(NSString *)uid userModel:(UserModel) userModel;
@end
