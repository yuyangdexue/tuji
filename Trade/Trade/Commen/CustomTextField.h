//
//  CustomTextField.h
//  Trade
//
//  Created by Yuyangdexue on 15/10/27.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UIView


- (instancetype)initWithFrame:(CGRect)frame  Placeholder:(NSString *)placeholder BackgroundColor:(UIColor *)backgroundColor TextColor:(UIColor *)textColor;


@property (nonatomic,strong)UITextField *textField;

@end
