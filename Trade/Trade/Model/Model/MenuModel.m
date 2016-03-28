//
//  MenuModel.m
//  Trade
//
//  Created by Yuyangdexue on 15/6/24.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

+ (UIViewController*)viewControllerWithKey:(NSString*)key
{
    NSString *strClass = @"";
    NSDictionary *dict = @{
                           @"first_tab" : @"HomeViewController",
                           @"second_tab" : @"TradeViewController",
                           @"third_tab" : @"PersonViewController",
                           };
    
    if (key && key.length > 0) {
        strClass = [dict objectForKey:key];
        if (strClass && strClass.length > 0) {
            UIViewController *controller = [NSClassFromString(strClass) new];
            return controller;
        }
    }
    return nil;

}
+ (SEL)selectorWithKey:(NSString *)key {
    NSString *strClass = @"";
    NSDictionary *dict = @{
                           @"location_center" : @"openLocation",
                           @"message_center" : @"openMessageCenter",
                           @"setting_center" : @"openSettingCenter"
                           };
    
    if (key && key.length > 0) {
        strClass = [dict objectForKey:key];
        if (strClass && strClass.length > 0) {
            SEL selector = NSSelectorFromString(strClass);
            return selector;
        }
    }
    return nil;
}
@end
