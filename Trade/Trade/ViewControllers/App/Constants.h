//
//  Constants.h
//  Trade
//
//  Created by Yuyangdexue on 15/6/24.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#ifndef Trade_Constants_h
#define Trade_Constants_h
#import <AFNetworking.h>
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import <UIColor+MCUIColorsUtils.h>
#import <UIAlertView+Block.h>
#import <UIActionSheet+Blocks.h>
#import "UIImageView+AFNetworking.h"
#import "NSDictionary+Accessors.h"
#import "MobClick.h"
#import "Utilities.h"
#import "NSArray+BFKit.h"
#import "NSDate+BFKit.h"
#import "NSString+BFKit.h"
#import "CacheFile.h"
#import "MJRefresh.h"
#import "UserEntity.h"
#import "HttpRequestClass.h"
#import <QiniuSDK.h>
#import "App.h"

#define kHeaderPullToRefreshText     @"下拉刷新"
#define kHeaderReleaseToRefreshText  @"释放即可刷新"
#define kHeaderRefreshingText        @"正在刷新..."


#define kFooterPullToRefreshText     @"上拉可以加载更多数据"
#define kFooterReleaseToRefreshText  @"释放马上加载更多数据"
#define kFooterRefreshingText        @"加载中，请稍等..."

#endif

#define kErrorMessage @"返回数据异常"

#define PREFIX_URL @"http://www.yuehu.im/server/basic/web/"


#define DEBUG_LOG_OPEN

#ifdef DEBUG_LOG_OPEN
#define DLog(fmt, ...)                                                         \
NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define appRemove(ikey) [[App instance] removeKey:ikey]

#define appInteger(ikey) [[App instance] getInteger:ikey]
#define appSetInteger(ikey, sval)                                              \
[[AppInfo instance] setInteger:ikey val:sval]

#define appString(ikey) [[App instance] getString:ikey]
#define appSetString(ikey, sval)                                               \
[[AppInfo instance] setString:ikey str:sval]

#define appBOOL(ikey) [[App instance] getBool:ikey]
#define appSetBOOL(ikey, sval)                                                 \
[[App instance] setBool:ikey val:sval]
//notification


#define kNotificationEvectionUpateDate @"kNotificationEvectionUpateDate"


extern float kDeviceFactor;
extern float kDeviceWidth;
extern float kDeviceHeight;

#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kMarginTopHeight 64
#define kTabBarHeight 49

#define kColor_Main_Color  [UIColor colorWithHexRGB:0xf6f6f6]                            //主色(橙色)

#define main_color [UIColor colorWithHexRGB:0xffa32c]



#define ImagePngWithName(_name)                                                \
[UIImage                                                                     \
imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_name     \
ofType:@"png"]]

typedef NS_ENUM(NSInteger, State)
{
    State_Prepare = 0,//备货中
    State_DidShipments,//已发货
    State_DidConstruct,//已施工
    State_DidSigned,//已签约
    State_DidQualified,//已验收
    State_NoSigned,//未签约
    State_Complete,//货到齐
    State_ConstructIng//正在施工
    
};



typedef NS_ENUM( NSInteger , NavType)
{
    NavType_WhiteForground,
    NavType_BlackForground,
};




typedef NS_ENUM(NSInteger, EvectionStatusLevel)
{
    EvectionStatusLevel_No=1000,
    EvectionStatusLevel_Nomarl,
    EvectionStatusLevel_Imporant,
    EvectionStatusLevel_Zero
};

typedef NS_ENUM(NSInteger, ReplyStatus)
{
    ReplyStatus_No=1000,
    ReplyStatus_Have,
    ReplyStatus_Zero
};

typedef NS_ENUM(NSInteger,ConfigrationStatus)
{
    ConfigrationStatus_Start,
    ConfigrationStatus_Create,
    
    ConfigrationStatus_Edit
};
#define kColor_arrow_Color [UIColor colorWithHexRGB:0xfe4444] //红色

#define kColor_Placeholder_Color [UIColor colorWithHexRGB:0x0e0e0e] //textField placeholder;

#define kColor_RegBack_Color [UIColor colorWithHexRGB:0x9b9170] //registerBack;
#define kColor_LoginBack_Color [UIColor colorWithHexRGB:0xc9c9c9]
#define kColor_e8e8e8_Color [UIColor colorWithHexRGB:0xe8e8e8]

#define kColor_f0f0f0_Color [UIColor colorWithHexRGB:0xf0f0f0]


#define kColor_tbViewbackgroud_Color [UIColor colorWithIntegerGray:244]//tableView背景色（灰）
#define kColor_b3b3b3_Color [UIColor colorForHex:@"b3b3b3"]
#define kColor_BgView_Color [UIColor colorWithHexRGB:0x4167bc]
#define kColor_LoginBtn_Color [UIColor colorWithHexRGB:0x45cd37]
#define kColor_RegisterBtn_Color [UIColor colorWithHexRGB:0x1493ff]
#define kColor_LightGray_Color  [UIColor colorWithHexRGB:0xa4a4a4]
#define kColor_Black_Color [UIColor colorWithHexRGB:0x272727]     //黑色
#define kColor_Green_Color [UIColor colorWithHexRGB:0x7dc648]    //绿色
#define kColor_Line_Color [UIColor colorWithHexRGB:0xd3d3d3]   //线的颜色
#define kColor_GrayBackground_Color [UIColor colorWithHexRGB:0xf6f6f6]//灰色背景