//
//  NavgationView.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/29.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "NavgationView.h"
#import "Constants.h"
@interface NavgationView ()
{
    NavType _type;
    
    
}

@end
@implementation NavgationView

- (instancetype)initWithFrame:(CGRect)frame  NavType:(NavType )type
{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    _type=type;
    [self initView];
    return self;
}

- (void)initView
{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame=CGRectMake(10, 7, 35, 35);
    if (_type == NavType_WhiteForground) {
        [_backBtn setImage:[UIImage imageNamed:@"back_dark@2x.png"] forState:UIControlStateNormal];
        _backBtn.backgroundColor=[UIColor whiteColor];
    }
    else  if (_type == NavType_BlackForground)
    {
        [_backBtn setImage:[UIImage imageNamed:@"back_white@2x.png"] forState:UIControlStateNormal];
         _backBtn.backgroundColor=[UIColor blackColor];
    }
    
    [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
    
    _rightBtn=[UIButton ButtonWithRect:CGRectMake(kDeviceWidth-45, 7, 35, 35) defaultImage:nil selectedImage:nil highlightedImage:nil clickAction:@selector(rightCick) viewController:self];
    
    [self addSubview:_rightBtn];
    
    _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(60, 5, kDeviceWidth-120, 35)];
    _titleLable.font=[UIFont boldSystemFontOfSize:18];
    _titleLable.textAlignment=NSTextAlignmentCenter;
    _titleLable.textColor=[UIColor blackColor];
    [self addSubview:_titleLable];
    
}

- (void)rightCick
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)goBack
{
    if (self.goBackBlock) {
        self.goBackBlock();
    }
}

- (void)changeType:(NavType )type
{
     _type=type;
    if (_type == NavType_WhiteForground) {
        [_backBtn setImage:[UIImage imageNamed:@"back_dark@2x.png"] forState:UIControlStateNormal];
        _backBtn.backgroundColor=[UIColor whiteColor];
    }
    else  if (_type == NavType_BlackForground)
    {
        [_backBtn setImage:[UIImage imageNamed:@"back_white@2x.png"] forState:UIControlStateNormal];
        _backBtn.backgroundColor=[UIColor blackColor];
    }
    
}

- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage
{
    if (leftImage) {
          [_backBtn setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
    }
    if (rightImage) {
         [_rightBtn setImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
       
        //rightBtn.frame=
    }
    if (title) {
          _titleLable.text=title;
    }
  
   
 
}

- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightString:(NSString *)rightString
{
    if (leftImage) {
        [_backBtn setImage:nil forState:UIControlStateNormal];
        [_backBtn setTitle:leftImage forState:UIControlStateNormal];
        _backBtn.backgroundColor=kColor_RegBack_Color;
        _backBtn.frame=CGRectMake(10, 7, leftImage.length*20, 35);
        _backBtn.titleLabel.font=[UIFont systemFontOfSize:14];

    }
    if (rightString) {
        [_rightBtn setTitle:rightString forState:UIControlStateNormal];
         _rightBtn.backgroundColor=kColor_RegBack_Color;
        _rightBtn.frame=CGRectMake(kDeviceWidth-10-rightString.length*20, 7, rightString.length*20, 35);
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    if (title) {
        _titleLable.text=title;
    }
}



@end
