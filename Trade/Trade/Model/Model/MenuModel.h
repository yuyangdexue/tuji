//
//  MenuModel.h
//  Trade
//
//  Created by Yuyangdexue on 15/6/24.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>
@protocol MenuModel
@end

@interface MenuModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* title;
@property (nonatomic, strong) NSString<Optional>* key;
@property (nonatomic, strong) NSString<Optional>* type;
@property (nonatomic, strong) NSString<Optional>* background;
@property (nonatomic, strong) NSString<Optional>* image;
@property (nonatomic, strong) NSString<Optional>* image_hl;
@property (nonatomic, strong) NSString<Optional>* selector;
@property (nonatomic, strong) NSNumber<Optional>* width;
@property (nonatomic, strong) NSNumber<Optional>* height;
@property (nonatomic, strong) NSNumber<Optional>* authen;
@property (nonatomic, strong) NSNumber<Optional>* disabled;
@property (nonatomic, strong) NSArray<MenuModel, Optional>* subitems;

+ (UIViewController*)viewControllerWithKey:(NSString*)key;
+ (SEL)selectorWithKey:(NSString *)key;

@end
