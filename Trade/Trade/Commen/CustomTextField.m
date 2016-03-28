//
//  CustomTextField.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/27.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "CustomTextField.h"
@interface CustomTextField()
{
    CGRect    _frame;
    NSString *_placeholder;
    UIColor  *_backgroundColor;
    UIColor  *_textColor;
    
}
@end
@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame  Placeholder:(NSString *)placeholder BackgroundColor:(UIColor *)backgroundColor TextColor:(UIColor *)textColor
{
    self =[super initWithFrame:frame];
    if (!self) return nil;
    _frame=frame;
    _placeholder=placeholder;
    _backgroundColor=backgroundColor;
    _textColor=textColor;
    [self initSubView];
    return self;
}

- (void)initSubView
{
    self.backgroundColor=[UIColor whiteColor];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=2;
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.layer.borderWidth=1;
    
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(10,0, _frame.size.width-20, _frame.size.height)];
    _textField.textColor=_textColor;
    _textField.placeholder=_placeholder;
    _textField.font=[UIFont systemFontOfSize:12];
    
    [self addSubview:_textField];

}



@end
