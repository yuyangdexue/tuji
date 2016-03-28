//
//  FlatTabBar.h
//  nj12320
//
//  Created by yiliao6 on 24/12/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlatTabBar : UIView

@property (nonatomic, assign) int selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)setOnClickTab:(void (^)(int index))block;
- (void)setSelectedIndex:(int)index;
- (void)resetItems:(NSArray *)items;

@end
