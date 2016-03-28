//
//  UserHeadView.h
//  Trade
//
//  Created by Yuyangdexue on 15/11/3.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherUserModel.h"

typedef void (^LeftBlock_t)();
typedef void (^RightBlock_t)();

@interface UserHeadView : UIView

- (instancetype)initWithFrame:(CGRect)frame userModel:(OtherUserModel *)model;

- (void)resetModel:(OtherUserModel *)model;

@property (nonatomic,copy)LeftBlock_t leftBlock;

@property (nonatomic,copy)RightBlock_t rightBlock;

@end
