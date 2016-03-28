//
//  DynamicUserView.m
//  Trade
//
//  Created by 于洋 on 15/11/10.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "DynamicUserView.h"
#import "Constants.h"
#import "DynamicUserCell.h"
#define IDENTIFIER_CELL @"DynamicUserCell"
@interface DynamicUserView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    UILabel *lable;
    NSMutableArray *_array;
}


@end

@implementation DynamicUserView


- (void)resetArray:(NSArray *)array
{
    _array=[NSMutableArray arrayWithArray:array];
    [_collectionView reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor=[UIColor whiteColor];
    _array=[[NSMutableArray alloc]init];
    [self initSubView];
    return self;
}

- (void)initSubView
{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kDeviceWidth , 0.5)];
    line.backgroundColor=kColor_Line_Color;
    [self addSubview:line];
    
    lable=[UILabel labelWithRect:CGRectMake(15, 15, 200, 20) text:@"推荐用户" textColor:[UIColor redColor] fontSize: 14 textAlignment: NSTextAlignmentLeft];
    lable.font=[UIFont boldSystemFontOfSize:14];
    lable.textColor=kColor_RegBack_Color;
    [self addSubview:lable];
    
    
    UIButton *moreBtn=[UIButton ButtonWithRect:CGRectMake(kDeviceWidth-40, 15,30 , 20) title:@"更多" titleColor:[UIColor darkGrayColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(clickBtn) viewController:self titleFont:12 contentEdgeInsets:UIEdgeInsetsZero];
    
    [self addSubview:moreBtn];
    [self addSubview:self.collectionView];
    
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout =
        [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kDeviceWidth, 80) collectionViewLayout:layout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.showsVerticalScrollIndicator=NO;
        [_collectionView registerClass:[DynamicUserCell class]
      forCellWithReuseIdentifier:IDENTIFIER_CELL];
        
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DynamicUserCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL
                                              forIndexPath:indexPath];
    [cell resetModel:[_array objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

}



- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 80);
}




- (void)clickBtn
{
    
}


@end
