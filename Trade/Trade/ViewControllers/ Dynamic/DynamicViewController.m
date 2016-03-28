//
//  DynamicViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/4.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "DynamicViewController.h"
#import "DynamicUserView.h"
#import "DynamicContentView.h"
#import "DynamicModel.h"
@interface DynamicViewController ()
{
    UIScrollView  *_scrollView;
    
    UIImageView *_tilteImageView;
}
@property (nonatomic,strong)DynamicContentView *userContent;
@property (nonatomic,strong)DynamicContentView *userNewContent;
@property (nonatomic,strong)  DynamicUserView *userView;
@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showNav:NavType_WhiteForground];
    [self changeLeftImage:nil title:@"动态" rightImage:nil];
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.tilteImageView];
    
    _userView=[[DynamicUserView alloc]initWithFrame:CGRectMake(0, 230, kDeviceWidth, 120)];
    [_scrollView addSubview:_userView];
   _userContent=[[DynamicContentView alloc]initWithFrame:CGRectMake(0, 120+230, kDeviceWidth, 125) title:@"刚刚发布"];
    [_scrollView addSubview:_userContent];
    
    _userNewContent=[[DynamicContentView alloc]initWithFrame:CGRectMake(0, 120+230+125, kDeviceWidth, 125) title:@"最新"];
    [_scrollView addSubview:_userNewContent];
    
    _scrollView.contentSize=CGSizeMake(kDeviceWidth, _userNewContent.frame.origin.y+_userNewContent.frame.size.height);
    
    
    
    __weak DynamicViewController *wealSelf=self;
    DynamicModel *model=[[DynamicModel alloc]init];
    [model requsetCallBackModel:^(DynamicModel *model) {
        [wealSelf.userContent resetModel:model.hotTuji];
        [wealSelf.userNewContent resetModel:model.justPublishTuji];
        [wealSelf.userView resetArray:model.recommentUser];
    }];
    
    [self getRequestParam:nil AppURL:AppURL_Operation_Getoperation isHead:YES CompleteBlock:^(NSDictionary *dic) {
        if ([dic integerForKey:@"code"]==1) {
            if ([dic dictionaryForKey:@"data"]) {
                NSDictionary *data=[dic dictionaryForKey:@"data"];
                [wealSelf.tilteImageView setImageWithURL:[NSURL URLWithString:[data stringForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@""]];
            }
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

- (UIImageView *)tilteImageView
{
    if (!_tilteImageView) {
        _tilteImageView=[[UIImageView alloc]init];
        _tilteImageView.frame=CGRectMake(0, 0, kDeviceWidth, 180);
        _tilteImageView.backgroundColor=[UIColor blueColor];
    }
    return _tilteImageView;
}




- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, kDeviceHeight-50)];
        _scrollView.backgroundColor=[UIColor whiteColor];
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
