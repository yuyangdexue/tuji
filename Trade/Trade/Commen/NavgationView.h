//
//  NavgationView.h
//  Trade
//
//  Created by Yuyangdexue on 15/10/29.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

typedef  void(^GoBack_t)();
typedef  void(^rightClick_t)();

@interface NavgationView : UIView

@property (nonatomic,copy)GoBack_t goBackBlock;
@property (nonatomic,copy)rightClick_t rightBlock;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UILabel  *titleLable;;
- (instancetype)initWithFrame:(CGRect)frame  NavType:(NavType )type;

- (void)changeType:(NavType )type;

- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage;

- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightString:(NSString *)rightString;

@end
