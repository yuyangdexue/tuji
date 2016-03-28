//
//  DynamicModel.h
//  Trade
//
//  Created by 于洋 on 15/11/10.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class DynamicModel;
typedef void(^ModelBlock_t) (DynamicModel *model);

@protocol DynamicUserModel

@end
@interface DynamicUserModel : JSONModel
@property (nonatomic,strong) NSString <Optional>*username;
@property (nonatomic,strong) NSString <Optional>*uid;
@property (nonatomic,strong) NSString <Optional>*avatar;

@end


@protocol DynamicContentModel

@end
@interface DynamicContentModel : JSONModel
@property (nonatomic,strong)NSString <Optional>*album_id;
@property (nonatomic,strong)NSString <Optional>*cover;

@end

@interface DynamicModel : JSONModel
@property (nonatomic,strong)NSArray <DynamicUserModel ,Optional> *recommentUser;
//@property (nonatomic,strong)NSArray <DynamicContentModel ,Optional> *newPublishTuji;
@property (nonatomic,strong)NSArray <DynamicContentModel ,Optional> *hotTuji;
@property (nonatomic,strong)NSArray <DynamicContentModel ,Optional> *justPublishTuji;

- (void)requsetCallBackModel:(ModelBlock_t )blockModel;

@end


