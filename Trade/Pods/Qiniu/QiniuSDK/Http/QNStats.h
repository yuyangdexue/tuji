//
//  QNStats.h
//  QiniuSDK
//
//  Created by ltz on 9/21/15.
//  Copyright (c) 2015 Qiniu. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HappyDns.h"

#if TARGET_OS_IPHONE
#import "Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#endif

@interface QNStats : NSObject

#if TARGET_OS_IPHONE
@property (nonatomic, readonly) Reachability *wifiReach;
@property (nonatomic, readonly) CTTelephonyNetworkInfo *telephonyInfo;
@property (atomic, readonly) NetworkStatus reachabilityStatus;
#endif

@property (nonatomic,retain) NSTimer *pushTimer;
@property (readonly) int pushInterval;
@property (nonatomic, readonly) NSString *statsHost;
@property (nonatomic, readonly) QNDnsManager *dns;

// 切换网络的时候需要拿本地IP
@property (atomic, readonly) NSString *sip;

- (instancetype) init;
- (instancetype) initWithPushInterval: (int) interval
                             dropRate: (float) dropRate
                            statsHost:(NSString *) statsHost
                                  dns:(QNDnsManager *) dns;

- (void) addStatics: (NSMutableDictionary *) stat;
- (void) pushStats;
- (NSString *) getSIP;
- (NSString *) getNetType;

@property int count;

@end

void setStat(NSMutableDictionary *dic, id key, id value);
NSString *errorFromDesc(NSString *desc);
