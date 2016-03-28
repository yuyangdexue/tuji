//
//  CreateContentCell.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/30.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "CreateContentCell.h"
#import "Constants.h"
@interface CreateContentCell ()
{
    UIImageView *_imageView;
    UILabel *_lable;
}
@end
@implementation CreateContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initView];
    return self;
}

- (void)initView
{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _lable=[[UILabel alloc]init];
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_lable];
}

- (void)resetImage:(UIImage *)image height:(CGFloat)height
{
    _imageView.frame=CGRectMake(0, 0, kDeviceWidth, height);
    _imageView.image=image;
    _imageView.hidden=NO;
    _lable.hidden=YES;
}

- (void)resetString:(NSString *)string height:(CGFloat)height
{
    _lable.frame=CGRectMake(25, 25, kDeviceWidth-50, height);
    _lable.textColor=[UIColor  blackColor];
    _lable.font=[UIFont systemFontOfSize:14];
    _lable.text=string;
    _lable.numberOfLines=0;
    _lable.hidden=NO;
    _imageView.hidden=YES;
}

@end
