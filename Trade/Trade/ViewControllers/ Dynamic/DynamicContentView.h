//
//  DynamicContentView.h
//  Trade
//
//  Created by 于洋 on 15/11/10.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface DynamicContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

- (void)resetModel:(NSArray *)array;

@end
