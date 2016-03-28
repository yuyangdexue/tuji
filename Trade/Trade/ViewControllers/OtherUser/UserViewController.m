//
//  UserViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/2.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "UserViewController.h"
#import "UserHeadView.h"
#import "OtherUserModel.h"
#import "FeedCell.h"
#import "FeedModel.h"
@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_userId;
    UserHeadView *_userView;
    UITableView  *_leftTbView;
    UITableView  *_rightTbView;
    UIScrollView *_scrollView;
    UIScrollView *_downScrollView;
    
    NSMutableArray *_leftArr;
    NSMutableArray *_rightArr;
    
}
@property (nonatomic,assign)NSInteger leftPage;
@property (nonatomic,assign)NSInteger rightPage;
@end

@implementation UserViewController

- (instancetype)initWithUserId:(NSString *)userId
{
    self = [super init];
    if (!self) return nil;
    _userId=userId;
    return self;
}

- (NSMutableArray *)leftArr
{
    if (!_leftArr) {
        _leftArr=[[NSMutableArray alloc]init];
    }
    return _leftArr;
}

- (NSMutableArray *)rightArr
{
    if (!_rightArr) {
        _rightArr=[[NSMutableArray alloc]init];
    }
    return _rightArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftPage=0;
    _rightPage=0;
    [self changeLeftImage:nil title:nil rightImage:nil];
    [self showNav:NavType_WhiteForground];
    
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.userView];
    [_scrollView addSubview:self.downScrollView];
    [_downScrollView addSubview:self.leftTbView];
    [_downScrollView addSubview:self.rightTbView];
    
    __weak UserViewController *weakSelf=self;
    OtherUserModel *userModel=[[OtherUserModel alloc]init];
    [userModel requsetUrl:_userId userModel:^(OtherUserModel *model) {
        
        [weakSelf.userView resetModel:model];
    }];
    
    
    
    [self leftHttp:0];
    [self rightHttp:0];
    
  

    // Do any additional setup after loading the view.
}


- (void)leftHttp:(NSInteger)page
{
     __weak UserViewController *weakSelf=self;
    FeedModel *_feedModel=[[FeedModel alloc]init];
    [_feedModel appUrl:AppURL_Feed_Getothersalbum paramers:@{@"uid":_userId,@"page":[NSString stringWithFormat:@"%ld",page]} successBlock:^(NSArray *arr,AppURL appUrl) {
      
        if (appUrl==AppURL_Feed_Getothersalbum) {
            if (arr.count==0) {
                [weakSelf.leftTbView.mj_footer endRefreshingWithNoMoreData];
            }
            else
            {
                weakSelf.leftPage=weakSelf.leftPage+1;
            }
        }
        [weakSelf.leftArr addObjectsFromArray:arr];
        [weakSelf.leftTbView reloadData];
        [weakSelf.leftTbView.mj_header endRefreshing];
        [weakSelf.leftTbView.mj_footer endRefreshing];
    }];
}

- (void)rightHttp:(NSInteger)page
{
    __weak UserViewController *weakSelf=self;
    FeedModel *_feedModel=[[FeedModel alloc]init];
    [_feedModel appUrl:AppURL_Feed_Collect paramers:@{@"uid":_userId,@"page":[NSString stringWithFormat:@"%ld",page]} successBlock:^(NSArray *arr,AppURL appUrl) {
        if (appUrl==AppURL_Feed_Collect) {
            if (arr.count==0) {
                [weakSelf.rightTbView.mj_footer endRefreshingWithNoMoreData];
            }
            else
            {
                weakSelf.rightPage=weakSelf.rightPage+1;
            }
        }
        
        [weakSelf.rightArr addObjectsFromArray:arr];
        [weakSelf.rightTbView reloadData];
        [weakSelf.rightTbView.mj_header endRefreshing];
        [weakSelf.rightTbView.mj_footer endRefreshing];
    }];
}


- (UserHeadView *)userView
{
    
    __weak UserViewController *wealSelf=self;
    if (!_userView) {
        _userView=[[UserHeadView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200) userModel:nil];
        
        _userView.leftBlock=^()
        {
            [wealSelf.downScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        };
        _userView.rightBlock=^()
        {
           [wealSelf.downScrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:YES];
        };
        
    }
    
    return _userView;
}


- (UIScrollView *)downScrollView
{
    if (!_downScrollView) {
        _downScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, kDeviceWidth, kDeviceHeight-250)];
        _downScrollView.contentSize=CGSizeMake(kDeviceWidth*2, kDeviceHeight-250);
    }
    return _downScrollView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, kDeviceHeight-50)];
        _scrollView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight-50);
    }
    return _scrollView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180*kDeviceFactor+60;
}


- (UITableView *)leftTbView
{
    if (!_leftTbView) {
        _leftTbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-250) style:UITableViewStylePlain];
        _leftTbView.dataSource=self;
        _leftTbView.delegate=self;
        _leftTbView.tableFooterView=[UIView new];
         _leftTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
         __weak UserViewController *weakSelf=self;
        _leftTbView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.leftArr removeAllObjects];
            [weakSelf.leftTbView.mj_footer resetNoMoreData];
            [weakSelf.leftTbView reloadData];
            [weakSelf leftHttp:0];
            weakSelf.leftPage=0;
        }];
        
        _leftTbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            
            [weakSelf leftHttp:weakSelf.leftPage];
      
        }];

    }
    return _leftTbView;
}

- (UITableView *)rightTbView
{
    if (!_rightTbView) {
        _rightTbView=[[UITableView alloc]initWithFrame:CGRectMake(kDeviceWidth, 0, kDeviceWidth, kDeviceHeight-250) style:UITableViewStylePlain];
        _rightTbView.dataSource=self;
        _rightTbView.delegate=self;
        _rightTbView.tableFooterView=[UIView new];
        _rightTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak UserViewController *weakSelf=self;
        _rightTbView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.rightArr removeAllObjects];
            [weakSelf.rightTbView.mj_footer resetNoMoreData];
            [weakSelf.rightTbView reloadData];
            [weakSelf rightHttp:0];
            weakSelf.rightPage=0;
        }];
        
        _rightTbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            
            [weakSelf rightHttp:weakSelf.rightPage];
          
        }];
        
    }
    return _rightTbView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.leftTbView) {
        return  self.leftArr.count;
    }
    else
    {
        return self.rightArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *id=@"id";
    FeedCell *cell=[tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell=[[FeedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    if (_leftTbView==tableView) {
        [cell resetModel:[_leftArr objectAtIndex:indexPath.row]];
    }
    else if (_rightTbView==tableView)
    {
         [cell resetModel:[_rightArr objectAtIndex:indexPath.row]];
    }
   
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
