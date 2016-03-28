//
//  CreateFootView.h
//  Trade
//
//  Created by Yuyangdexue on 15/10/30.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickPicturesBlock_t)();
typedef void (^ClickTextBlock_t)();
@interface CreateFootView : UIView

@property (nonatomic,copy)ClickPicturesBlock_t clickPicturesBlock;

@property (nonatomic,copy)ClickTextBlock_t clickTextBlock;

@end
