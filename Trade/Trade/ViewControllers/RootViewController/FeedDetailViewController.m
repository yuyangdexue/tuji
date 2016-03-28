//
//  FeedDetailViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/2.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "FeedDetailViewController.h"
#import "FeedDetailModel.h"
#import "FeedDetailCell.h"
@interface FeedDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_albumId;
    UITableView *_tbView;
    FeedDetailModel *_feedDetailModel;
   
}
@end

@implementation FeedDetailViewController

- (instancetype)initAlbumId:(NSString *)albumId
{
    self = [super init];
    if (!self) return nil;
    _albumId=albumId;
    return self;
}


- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, kDeviceHeight-50) style:UITableViewStylePlain];
        _tbView.delegate=self;
        _tbView.dataSource=self;
        _tbView.tableFooterView=[UIView new];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tbView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLeftImage:nil title:nil rightString:nil];
   
    
    [self.view addSubview:self.tbView];
    [self loadData];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feedDetailModel.detail.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailModel *model=[_feedDetailModel.detail objectAtIndex:indexPath.row];
    __block CGFloat height=0;
    if ([model.imgUrl length]==0&&[model.content length]!=0) {
        //文字
        height =[self getWidth:kDeviceWidth-50 andNSString:model.content].height+50;
        
    }
    if ([model.imgUrl length]!=0&&[model.content length]==0) {
        
        
        height=kDeviceWidth*[model.height floatValue]/[model.width floatValue];
        height=height+25;
        
    }

   

    return height;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *id=@"ID";
    FeedDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell=[[FeedDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }

    [cell resetModel:[_feedDetailModel.detail objectAtIndex:indexPath.row]];
    return cell;
}


- (void)loadData
{
    if (!_albumId) {
        return;
    }
    NSDictionary *dic=@{@"albumId":_albumId};
    
    [self getRequestParam:dic AppURL:AppURL_Feed_Getdetail isHead:YES CompleteBlock:^(NSDictionary *dic) {
        
        if ([dic isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *data=[dic dictionaryForKey:@"data"];
            _feedDetailModel=[[FeedDetailModel alloc]initWithDictionary:data error:nil];
            
             [self changeLeftImage:nil title:_feedDetailModel.title rightString:nil];
            if (_feedDetailModel) {
                [_tbView reloadData];
                
            }
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
