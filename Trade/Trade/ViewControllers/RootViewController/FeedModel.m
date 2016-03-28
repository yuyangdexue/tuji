//
//  FeedModel.m
//  Trade
//
//  Created by Yuyangdexue on 15/11/2.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel


- (void)appUrl:(AppURL )appUrl paramers:(NSDictionary *)dic successBlock:(successBlock_t)block
{
    [App httpGET:appUrl headerWithUserInfo:YES parameters:dic successBlock:^(int code, NSDictionary *dictResp) {
        if ([dictResp isKindOfClass:[NSDictionary class]]) {
            if ([dictResp intForKey:@"code"]==1) {
                if (block) {
                    NSMutableArray *array=[[NSMutableArray alloc]init];
                    NSArray *data=[dictResp arrayForKey:@"data"];
                    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *dic=obj;
                        FeedModel *model=[self initWithDictionary:dic error:nil];
                        [array addObject:model];
                    }];
                    block(array,appUrl);
                }
            }
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
}

@end
