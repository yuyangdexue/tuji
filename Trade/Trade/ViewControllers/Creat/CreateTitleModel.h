//
//  CreateTitleModel.h
//  Trade
//
//  Created by Yuyangdexue on 15/10/30.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CreateTitleModel : JSONModel
@property (nonatomic,strong) NSString <Optional> *upToken;
@property (nonatomic,strong) NSString <Optional> *albumId;
@end
