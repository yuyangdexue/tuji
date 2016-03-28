//
//  FeedCell.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/2.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "FeedCell.h"
#import "Constants.h"
#import "RootViewController.h"
#import "FeedDetailViewController.h"
#import "UserViewController.h"
@interface FeedCell ()
{
    UIImageView *_coverImg;
    UIImageView *_avatarImg;
    UILabel     *_titleLab;
    UILabel     *_nameLab;
    UILabel     *_likeLab;
    FeedModel   *_feedModel;
}

@end
@implementation FeedCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self initSubView];
    return self;
}

- (void)initSubView
{
    [self.contentView addSubview:self.coverImg];
    [self.contentView addSubview:self.avatarImg];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.nameLab];
}

- (UIImageView *)coverImg
{
    if (!_coverImg) {
        _coverImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 180*kDeviceFactor)];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCover)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        _coverImg.userInteractionEnabled=YES;
        [_coverImg addGestureRecognizer:tap];
        
    }
    return _coverImg;
}

- (void)clickCover
{
    if (_feedModel) {
        
        FeedDetailViewController *fdc=[[FeedDetailViewController alloc]initAlbumId:_feedModel.album_id];
        [[RootViewController instance] pushVController:fdc];
    }
}


- (void)clickAvatar
{
    if (_feedModel) {
        UserViewController *uvc=[[UserViewController alloc]initWithUserId:_feedModel.user_id];
        [[RootViewController instance] pushVController:uvc];
    }
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 180*kDeviceFactor+15, 30, 30)];
        _avatarImg.layer.masksToBounds=YES;
        _avatarImg.layer.cornerRadius=15;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAvatar)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        _avatarImg.userInteractionEnabled=YES;
        [_avatarImg addGestureRecognizer:tap];
        
    }
    return _avatarImg;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(60, 15+180*kDeviceFactor, 100, 15)];
        _titleLab.textColor=[UIColor blackColor];
        _titleLab.font=[UIFont systemFontOfSize:14];
        
    }
    return _titleLab;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]initWithFrame:CGRectMake(60, 30+180*kDeviceFactor, 100, 15)];
        _nameLab.textColor=[UIColor lightGrayColor];
        _nameLab.font=[UIFont systemFontOfSize:12];
    }
    return _nameLab;
}

- (void)resetModel:(FeedModel *)model
{
    _feedModel=model;
    _coverImg.image=nil;
    [_coverImg setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@""]];
   // _coverImg.contentMode = UIViewContentModeScaleAspectFill;
    [_avatarImg setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    _titleLab.text=model.title;
    _nameLab.text=model.username;
    
}

@end
