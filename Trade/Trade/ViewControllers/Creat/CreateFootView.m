//
//  CreateFootView.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/30.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "CreateFootView.h"
#import "Constants.h"
@interface CreateFootView ()
{
    UIButton *_pictureBtn;
    UIButton *_textBtn;
    CGRect   _frame;
}

@end
@implementation CreateFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    _frame=frame;
    [self initView];
    return self;
}

- (void)initView
{
    self.backgroundColor=kColor_f0f0f0_Color;
    [self addSubview:self.pictureBtn];
    [self addSubview:self.textBtn];
}

- (UIButton *)pictureBtn
{
    if (!_pictureBtn) {
        _pictureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _pictureBtn.frame=CGRectMake(_frame.size.width/2-50-2,_frame.size.height/2-20, 50, 40);
        _pictureBtn.backgroundColor=[UIColor whiteColor];
        [_pictureBtn setImage:[UIImage imageNamed:@"photo_dark@2x.png"] forState:UIControlStateNormal];
        [_pictureBtn addTarget: self action:@selector(clickPicture) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pictureBtn;
}

- (void)clickPicture
{
    if (self.clickPicturesBlock) {
        self.clickPicturesBlock();
    }
}

- (UIButton *)textBtn
{
    if (!_textBtn) {
        _textBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _textBtn.frame=CGRectMake(_frame.size.width/2+2,_frame.size.height/2-20, 50, 40);
        _textBtn.backgroundColor=[UIColor whiteColor];
        [_textBtn setImage:[UIImage imageNamed:@"text_dark@2x.png"] forState:UIControlStateNormal];
        [_textBtn addTarget: self action:@selector(clickText) forControlEvents:UIControlEventTouchUpInside];
    }
    return _textBtn;
}

- (void)clickText
{
    if (self.clickTextBlock) {
        self.clickTextBlock();
    }
}



@end
