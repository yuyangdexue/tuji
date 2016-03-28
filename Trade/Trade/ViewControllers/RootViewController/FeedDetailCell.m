//
//  FeedDetailCell.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/2.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "FeedDetailCell.h"
#import "Constants.h"
@interface FeedDetailCell ()
{
    UIImageView *_imageView;
    UILabel *_lable;
}

@end
@implementation FeedDetailCell

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




- (void)resetModel:(DetailModel *)model
{
    _imageView.image=nil;
    _lable.text=@"";
     __block CGFloat height=0;
    if ([model.imgUrl length]==0&&[model.content length]!=0) {
        //文字
         height =[self getWidth:kDeviceWidth-50 andNSString:model.content].height;
        [self resetString:model.content height:height];
        
    }
    if ([model.imgUrl length]!=0&&[model.content length]==0) {
        
        //图片
        height=kDeviceWidth*[model.height floatValue]/[model.width floatValue];
        _imageView.frame=CGRectMake(0, 0, kDeviceWidth, height);
        [_imageView setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        _imageView.hidden=NO;
        _lable.hidden=YES;
        
        
    }
}

- (CGSize)getWidth:(float)width andNSString:(NSString *)string {
    CGSize labelSize =
    [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                         options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{
                                   NSFontAttributeName : [UIFont systemFontOfSize:16.0]
                                   } context:nil].size;
    return labelSize;
}


@end
