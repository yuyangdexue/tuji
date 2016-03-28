//
//  DynamicUserCell.m
//  Trade
//
//  Created by 于洋 on 15/11/10.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "DynamicUserCell.h"
#import "Constants.h"
@interface DynamicUserCell ()
{
    UIImageView *avatarImg;
}

@end
@implementation DynamicUserCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)resetModel: (DynamicUserModel *)model
{
    [avatarImg setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)setup
{
    avatarImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    avatarImg.backgroundColor=[UIColor redColor];
    avatarImg.layer.masksToBounds=YES;
    avatarImg.layer.cornerRadius=30;
    [self addSubview:avatarImg];
}

@end
