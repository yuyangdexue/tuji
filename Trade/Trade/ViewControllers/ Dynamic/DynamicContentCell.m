//
//  DynamicContentCell.m
//  Trade
//
//  Created by 于洋 on 15/11/10.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "DynamicContentCell.h"
#import "Constants.h"
@interface DynamicContentCell ()
{
    UIImageView *avatarImg;
}
@end
@implementation DynamicContentCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    avatarImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 80)];
    avatarImg.backgroundColor=[UIColor greenColor];
    [self addSubview:avatarImg];
}

- (void)resetModel:(DynamicContentModel *)model
{
    [avatarImg setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@""]];
}


@end
