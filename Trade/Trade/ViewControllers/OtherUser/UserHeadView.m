//
//  UserHeadView.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/3.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "UserHeadView.h"
#import "Constants.h"
#import "FlatTabBar.h"
@interface UserHeadView ()
{
    UIImageView *_avatatImg;
    UILabel     *_nameLab;
    
    UIButton    *_picBtn;
    UIButton    *_likeBtn;
    
    FlatTabBar  *tabBar;
    OtherUserModel *_userModel;
}

@end

@implementation UserHeadView

- (instancetype)initWithFrame:(CGRect)frame userModel:(OtherUserModel *)model
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor=[UIColor whiteColor];
    _userModel=model;
    [self initView];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    [self initView];
    return self;
}


- (void)resetModel:(OtherUserModel *)model
{
    _userModel=model;
    
    [_avatatImg setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    _nameLab.text=model.username;
    
    __weak UserHeadView *weakSelf=self;
    tabBar =
    [[FlatTabBar alloc] initWithFrame:CGRectMake(0, 200-40, kDeviceWidth, 40)
                                items:@[
                                        @{
                                            @"title" : [NSString stringWithFormat:@"图集 %@",_userModel.tujiCount],
                                            @"badge" : @""
                                            },
                                        @{
                                            @"title" : [NSString stringWithFormat:@"收藏 %@",_userModel.likeCount],
                                            @"badge" : @""
                                            }
                                        ]];
    
    tabBar.selectedIndex = 0;
    [self addSubview:tabBar];
    
    [tabBar setOnClickTab:^(int index) {
        
        switch (index) {
                
            case 0: {
                
                if (weakSelf.leftBlock) {
                    weakSelf.leftBlock();
                }
            } break;
            case 1: {
                if (weakSelf.rightBlock) {
                    weakSelf.rightBlock();
                }
                
            } break;
            default: { } break; }
    }];

}

- (void)initView
{
    [self addSubview:self.avatatImg];
    [self addSubview:self.nameLab];
    
}


- (UIImageView *)avatatImg
{
    if (!_avatatImg) {
        _avatatImg=[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-30, 100-30-30, 60, 60)];
        _avatatImg.layer.masksToBounds=YES;
        _avatatImg.layer.cornerRadius=30;
    }
    return _avatatImg;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 150-30, kDeviceWidth, 20)];
        _nameLab.font=[UIFont systemFontOfSize:16];
        _nameLab.textColor=[UIColor blackColor];
        _nameLab.textAlignment=NSTextAlignmentCenter;
    }
    return _nameLab;
}





@end
