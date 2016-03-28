//
//  BaseViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/6/24.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import "BaseViewController.h"
#import "BarButtonModel.h"
#import "App.h"
#import "Constants.h"
#import "NavgationView.h"
@interface BaseViewController ()
{
    UILabel *noDataLable;
    UIButton *baseTitleView;
    
    NSMutableDictionary *loadingDic;
    NavgationView *navView;
}
@end

@implementation BaseViewController
- (void)postRequestParam:(NSDictionary *)param
                  AppURL:(int)appUrl
                  isHead:(BOOL)isHead
           CompleteBlock:(completeBlock_t)completeBlock
              errorBlock:(errorBlock_t)errorBlock {
    
    if ([loadingDic boolForKey:appString(appUrl)]) {
        return;
    }
    [loadingDic setObject:@"1" forKey:appString(appUrl)];
    [App httpPOST:appUrl
           headerWithUserInfo:isHead
                   parameters:param
                 successBlock:^(int code, NSDictionary *dictResp) {
                     [loadingDic setObject:@"0" forKey:appString(appUrl)];
                     if (code == 1) {
                         if (completeBlock) {
                             completeBlock(dictResp);
                         }
                     }
                     else
                     {
                         if (completeBlock) {
                             completeBlock(nil);
                         }
                     }
                     DLog(@"%@", dictResp);
                 }
                 failureBlock:^(NSError *error) {
                     DLog(@"%@", error);
                     [loadingDic setObject:@"0" forKey:appString(appUrl)];
                     if (errorBlock) {
                         errorBlock(error);
                     }
                     
                     [self showToast:@"请检查网络！"];
                 }];
}
- (void)getRequestParam:(NSDictionary *)param
                 AppURL:(int)appUrl
                 isHead:(BOOL)isHead
          CompleteBlock:(completeBlock_t)completeBlock
             errorBlock:(errorBlock_t)errorBlock {
    if ([loadingDic boolForKey:appString(appUrl)]) {
        return;
    }
    [loadingDic setObject:@"1" forKey:appString(appUrl)];
    [App httpGET:appUrl
          headerWithUserInfo:isHead
                  parameters:param
                successBlock:^(int code, NSDictionary *dictResp) {
                    [loadingDic setObject:@"0" forKey:appString(appUrl)];
                    if (code == 1) {
                        if (completeBlock) {
                            completeBlock(dictResp);
                        }
                    }
                    else
                    {
                        if (completeBlock) {
                            completeBlock(nil);
                        }
                    }
                    DLog(@"%@", dictResp);
                }
                failureBlock:^(NSError *error) {
                    [loadingDic setObject:@"0" forKey:appString(appUrl)];
                    DLog(@"%@", error);
                    if (errorBlock) {
                        errorBlock(error);
                    }
                    [self showToast:@"请检查网络！"];
                }];
}


- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage
{
    if (navView) {
        [navView changeLeftImage:leftImage title:title rightImage:rightImage];
        navView.hidden=NO;
        //[self changeTitle:title];
    }
}

- (void)changeLeftImage:(NSString *)leftImage title:(NSString *)title rightString:(NSString *)rightString
{
    if (navView) {
        [navView changeLeftImage:leftImage title:title rightString:rightString];
         navView.hidden=NO;
        //[self changeTitle:title];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_isTabViewController) {
        self.title = @"返回";
    }
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];
    loadingDic = [[NSMutableDictionary alloc] init];

    
    navView=[[NavgationView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50) NavType:NavType_BlackForground];
    navView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:navView];
    
    
    __weak BaseViewController *weakSelf=self;
    navView.goBackBlock=^()
    {
        [weakSelf goBackAction];
    };
    navView.rightBlock=^()
    {
        [weakSelf rightClick];
    };
    navView.hidden=YES;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationDidBecomeActive:)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    self.view.backgroundColor=[UIColor lightGrayColor];
    
     self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;

    // Do any additional setup after loading the view.
}

- (void)rightClick
{
    
}

- (void)goBackAction
{
    NSLog(@"123123");
    [self popVController:YES];
}
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    printf("按理说是重新进来后响应\n");
    //[[RootViewController getInstance] startLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNav:(NavType)type;
{
    [navView changeType:type];
    navView.hidden=NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [MobClick beginLogPageView:[self getPageTagName]];
    [self.view bringSubviewToFront:navView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [MobClick endLogPageView:[self getPageTagName]];
}

- (void)dealloc {
    [[App instance]cancelHttpMethods];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLog(@"dealloc====%@", [self description]);
}

- (NSString *)getPageTagName {
    NSString *strTitle = baseTitleView.titleLabel.text;
    
    if (strTitle && strTitle.length > 0 &&
        ![strTitle isEqualToString:@"未指定"]) {
        
    } else {
        strTitle = NSStringFromClass([self class]);
    }
    return strTitle;
}

- (void)clickedTitleView {
    [self onClickTitle];
}

- (void)onClickTitle {
    DLog(@"clicked Title of %@", [self getPageTagName]);
}

- (void)changeTitle:(NSString *)title {
    self.title=title;

}

- (void)addRightButton:(NSDictionary *)info clickAction:(SEL)clickAction {
    int width = [info intForKey:@"width"];
    int height = [info intForKey:@"height"];
    int tag = [info intForKey:@"tag"];
    NSString *title = [info stringForKey:@"title"];
    NSString *image = [info stringForKey:@"image"];
    NSString *imageHL = [info stringForKey:@"imagehl"];
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newBtn setFrame:CGRectMake(0, 0, width, height)];
    if (title) {
        [newBtn setTitle:title forState:UIControlStateNormal];
    }
    if (image) {
        [newBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (imageHL) {
        [newBtn setImage:[UIImage imageNamed:image]
                forState:UIControlStateHighlighted];
    }
    [newBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (clickAction) {
        [newBtn addTarget:self
                   action:clickAction
         forControlEvents:UIControlEventTouchUpInside];
    }
    if (tag > 0) {
        newBtn.tag = tag;
    }
    
    UIBarButtonItem *rightItem =
    [[UIBarButtonItem alloc] initWithCustomView:newBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - HUD Handler
- (void)dispatchMainAfter:(NSTimeInterval)delay block:(void (^)())block {
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       block();
                   });
}

- (void)showToast:(NSString *)txt {
    [SVProgressHUD showInfoWithStatus:txt];
    [self dispatchMainAfter:1.4
                      block:^{
                          [SVProgressHUD dismiss];
                      }];
}

- (void)showLoading {
    
    [SVProgressHUD
     setBackgroundColor:[UIColor colorWithHexRGBAString:@"00000099"]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:@"加载中..."
                         maskType:SVProgressHUDMaskTypeNone];
}

- (void)hideLoading {
    //  [self dispatchMainAfter:0.2
    //                    block:^{
    //                      [SVProgressHUD dismiss];
    //                    }];
    [SVProgressHUD dismiss];
}

- (void)dismissHUD {
    [SVProgressHUD dismiss];
}

- (void)hideTitleBtn {
    //[baseTitleView setHidden:YES];
}

#pragma mark - Navigation Bar Button on the Right
- (void)addRightBarWithTitle:(NSString *)title clickAction:(SEL)clickAction {
    BarButtonModel *btnModel = [BarButtonModel new];
    btnModel.title = title;
    [self addRightBar:btnModel clickAction:clickAction];
}

- (void)addRightBar:(BarButtonModel *)btnModel clickAction:(SEL)clickAction {
    if (!btnModel) {
        self.navigationItem.rightBarButtonItem = nil;
    } else if (btnModel.title && btnModel.title.length > 0) {
        UIBarButtonItem *rightBtn =
        [[UIBarButtonItem alloc] initWithTitle:btnModel.title
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:clickAction];
        rightBtn.accessibilityValue = @"abcd";
        self.navigationItem.rightBarButtonItem = rightBtn;
        
    } else if (btnModel.image && btnModel.image.length > 0) {
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
                                     initWithImage:[UIImage imageNamed:btnModel.image]
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:clickAction];
        self.navigationItem.rightBarButtonItem = rightBtn;
    } else {
        UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (btnModel.width && btnModel.width.floatValue > 0 && btnModel.height &&
            btnModel.height.floatValue > 0) {
            [newBtn setFrame:CGRectMake(0, 0, btnModel.width.floatValue,
                                        btnModel.height.floatValue)];
        } else if (btnModel.title && btnModel.title.length > 0) {
            
            NSDictionary *attributes =
            @{NSFontAttributeName : [UIFont systemFontOfSize:17.0]};
            CGRect newRect = [btnModel.title
                              boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                              options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:attributes
                              context:nil];
            newRect.size.width += 2;
            newRect.size.height += 2;
            [newBtn setFrame:newRect];
        }
        
        if (btnModel.title && btnModel.title.length > 0) {
            newBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
            newBtn.titleLabel.textAlignment = NSTextAlignmentRight;
            newBtn.backgroundColor = [UIColor grayColor];
            [newBtn setTitle:btnModel.title forState:UIControlStateNormal];
        }
        if (btnModel.image && btnModel.image.length > 0) {
            [newBtn setImage:[UIImage imageNamed:btnModel.image]
                    forState:UIControlStateNormal];
        }
        if (btnModel.imageHL && btnModel.imageHL.length > 0) {
            [newBtn setImage:[UIImage imageNamed:btnModel.imageHL]
                    forState:UIControlStateHighlighted];
        }
        [newBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (clickAction) {
            [newBtn addTarget:self
                       action:clickAction
             forControlEvents:UIControlEventTouchUpInside];
        }
        if (btnModel.tag && btnModel.tag.intValue > 0) {
            newBtn.tag = btnModel.tag.integerValue;
        }
        
        UIBarButtonItem *rightItem =
        [[UIBarButtonItem alloc] initWithCustomView:newBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

#pragma mark - Push ViewController Handler

- (void)pushVControllerByString:(NSString *)strClass {
    BaseViewController *controller = [NSClassFromString(strClass) new];
    
    [self pushVController:controller];
}

- (void)pushVController:(UIViewController *)viewController {
    if (viewController) {
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)popVControllerToRoot:(BOOL)animated {
    [self.navigationController popToRootViewControllerAnimated:animated];
   
}

- (void)popVController:(BOOL)animated {
    if (self.navigationController.viewControllers.count <= 2) {
       
    }
    [self.navigationController popViewControllerAnimated:animated];
}
#pragma mark - Navigation Controller Utility
- (void)clickNavBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)cleanupNavigationControllers {
    NSMutableArray *navigationArray =
    [self.navigationController.viewControllers mutableCopy];
    for (NSInteger k = navigationArray.count - 2; k > 0; k--) {
        [navigationArray removeObjectAtIndex:k];
    }
    self.navigationController.viewControllers = navigationArray;
}

#pragma mark - Present Modal ViewController Handler
- (void)presentModalVCByString:(NSString *)strClass {
    UIViewController *controller = [NSClassFromString(strClass) new];
    [self presentModalVC:controller];
}

- (void)presentModalVC:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    
    if ([NSStringFromClass([viewController class])
         isEqualToString:@"WalkthoughtViewController"]) {
        
        [self.navigationController presentViewController:viewController
                                                animated:YES
                                              completion:nil];
    } else {
        
        UINavigationController *navVC = [[UINavigationController alloc]
                                         initWithRootViewController:viewController];
        [navVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"pixel_blank"]
                                  forBarMetrics:UIBarMetricsDefault];
        [navVC.navigationBar setShadowImage:[UIImage imageNamed:@"pixel_blank"]];
        navVC.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [navVC.navigationBar setBarTintColor:kColor_Main_Color];
        [navVC.navigationBar setTintColor:[UIColor whiteColor]];
        
        viewController.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(disMissModalVC)];
        
        [self.navigationController presentViewController:navVC
                                                animated:YES
                                              completion:nil];
    }
}

- (void)disMissModalVC {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
