//
//  BaseViewController.h
//  Trade
//
//  Created by Yuyangdexue on 15/6/24.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
typedef void (^completeBlock_t)(NSDictionary *dic);
typedef void (^errorBlock_t)(NSError *error);
typedef void (^goBackBlock_t)();
@interface BaseViewController : UIViewController
{
    UIView *baseBgView;
    UIView *baseTopBackView;
    UIButton *_baseTitleView;
}

@property(nonatomic, assign) BOOL isTabViewController;
@property(nonatomic, copy)goBackBlock_t goBack;
- (void)showToast:(NSString *)txt;
- (void)showLoading;
- (void)hideLoading;
- (void)clickNavBack:(UIButton *)btn;
- (void)changeTitle:(NSString *)title;
- (void)onClickTitle;
- (void)addRightButton:(NSDictionary *)info clickAction:(SEL)clickAction;
- (void)hideTitleBtn;


- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage;

- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightString:(NSString *)rightString;


- (void)goBackAction;
- (void)rightClick;

- (void)postRequestParam:(NSDictionary *)param
                  AppURL:(int)appUrl
                  isHead:(BOOL)isHead
           CompleteBlock:(completeBlock_t)completeBlock
              errorBlock:(errorBlock_t)errorBlock;
- (void)getRequestParam:(NSDictionary *)param
                 AppURL:(int)appUrl
                 isHead:(BOOL)isHead
          CompleteBlock:(completeBlock_t)completeBlock
             errorBlock:(errorBlock_t)errorBlock;

- (void)showNav:(NavType)type;

/**
 *  添加一个右上角NavigationBar按钮;
 *
 *  @param title       这个按钮的Title;
 *  @param clickAction 点击按钮触发的selector;
 */
- (void)addRightBarWithTitle:(NSString *)title clickAction:(SEL)clickAction;

/**
 * 清除Navigation中其它ViewController, 只保留RootViewController
 * 和当前ViewController
 */
- (void)cleanupNavigationControllers;

- (void)presentModalVCByString:(NSString *)strClass;
- (void)presentModalVC:(UIViewController *)viewController;
- (void)disMissModalVC;

- (void)pushVControllerByString:(NSString *)strClass;
- (void)pushVController:(UIViewController *)viewController;
- (void)popVController:(BOOL)animated;
- (void)popVControllerToRoot:(BOOL)animated;

@end
