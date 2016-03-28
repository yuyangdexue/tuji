//
//  RootViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/27.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "RootViewController.h"
#import "CreateAddViewController.h"
#import "FeedModel.h"
#import "FeedCell.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "PersonViewController.h"
#import "DynamicViewController.h"
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tbView;
    
    NSInteger  page;
    
    UIButton   *_releaseBtn;
    
}
@property (nonatomic,strong)NSMutableArray *dataArr;
@end


@implementation RootViewController


+ (instancetype)instance
{
    static RootViewController *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [RootViewController new];
    });
    return _instance;
}


- (UIButton *)releaseBtn
{
    if (!_releaseBtn) {
        _releaseBtn=[UIButton ButtonWithRect:CGRectMake(kDeviceWidth/2-30, kDeviceHeight-25-30-25, 60, 60) defaultImage:nil selectedImage:nil highlightedImage:nil clickAction:@selector(releaseClick) viewController:self];
        _releaseBtn.layer.masksToBounds=YES;
        _releaseBtn.layer.cornerRadius=30;
        [_releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
        _releaseBtn.backgroundColor=kColor_RegBack_Color;
    }
    return _releaseBtn;
}

- (void)releaseClick
{
    CreateAddViewController *createVc=[[CreateAddViewController alloc]init];
    [self pushVController:createVc];
}



- (void)goBackAction
{
    NSLog(@"you ce ");
    DynamicViewController *vc=[[DynamicViewController alloc]init];
    [self pushVController:vc];
    
}

- (void)rightClick
{
    PersonViewController *pvc=[[PersonViewController alloc]init];
    [self pushVController:pvc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLeftImage:@"动态" title:@"图记" rightString:@"个人"];
    _dataArr=[[NSMutableArray alloc]init];
    page=0;
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.releaseBtn];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [UIView transitionWithView:self.view duration:0.5 options:0 animations:^{
      _releaseBtn.frame=CGRectMake(kDeviceWidth/2-30, kDeviceHeight+100, 60, 60);
    } completion:^(BOOL finished) {
        _releaseBtn.frame=CGRectMake(kDeviceWidth/2-30, kDeviceHeight-25-30-25, 60, 60);
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView transitionWithView:self.view duration:0.5 options:0 animations:^{
        _releaseBtn.frame=CGRectMake(kDeviceWidth/2-30, kDeviceHeight-25-30-25, 60, 60);
    } completion:^(BOOL finished) {
        _releaseBtn.frame=CGRectMake(kDeviceWidth/2-30, kDeviceHeight+100, 60, 60);
    }];
}





- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadData];
}


- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, kDeviceHeight-50) style:UITableViewStylePlain];
        _tbView.delegate=self;
        _tbView.dataSource=self;
        _tbView.tableFooterView=[UIView new];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak RootViewController *weakSelf=self;
         //1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
       
        _tbView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
                        [weakSelf.dataArr removeAllObjects];
                        [weakSelf.tbView.footer resetNoMoreData];
                        page=0;
                        [weakSelf.tbView reloadData];
                        [weakSelf httpList];
        }];
        
        _tbView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            
             [weakSelf httpList];
             
        }];
        


    }
    return _tbView;
}

- (void)httpList
{
    [self loadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180*kDeviceFactor+60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *id=@"ID";
    FeedCell *cell=[tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell=[[FeedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell resetModel:[_dataArr objectAtIndex:indexPath.row]];
    return cell;
}


- (void)loadData
{
    [self getRequestParam:@{@"page":[NSString stringWithFormat:@"%ld",page]} AppURL:AppURL_Feed_Getfeed isHead:YES CompleteBlock:^(NSDictionary *dic) {
        
        if ([dic intForKey:@"code"]==1) {
            NSArray *data=[dic arrayForKey:@"data"];
            
            if (data.count==10) {
                page=page+1;
                [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    FeedModel *model =[[FeedModel alloc]initWithDictionary:obj error:nil];
                    [_dataArr addObject:model];
                    
                }];
            }
            else if (data.count==0)
            {
                [_tbView.footer endRefreshingWithNoMoreData];
            }
             else
             {
                 page=page+1;
                 [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                     FeedModel *model =[[FeedModel alloc]initWithDictionary:obj error:nil];
                     [_dataArr addObject:model];
                     
                 }];

             }
            
            [_tbView reloadData];
            
            [_tbView.header endRefreshing];
            [_tbView.footer endRefreshing];
        }
    } errorBlock:^(NSError *error) {
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
