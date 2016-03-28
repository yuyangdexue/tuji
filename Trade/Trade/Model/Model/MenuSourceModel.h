//
//  MenuSourceModel.h
//  Trade
//
//  Created by Yuyangdexue on 15/6/24.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import "JSONModel.h"
#import "MenuModel.h"

@interface MenuSourceModel : JSONModel
@property (nonatomic, strong) NSNumber<Optional>* item_span;
@property (nonatomic, strong) NSNumber<Optional>* item_width;
@property (nonatomic, strong) NSNumber<Optional>* item_height;
@property (nonatomic, strong) NSArray <MenuModel,Optional>*items;

- (instancetype)initWithFileName:(NSString*)fileName
                       extension:(NSString*)extension;

@end

