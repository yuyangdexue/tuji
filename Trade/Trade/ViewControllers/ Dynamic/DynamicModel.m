//
//  DynamicModel.m
//  Trade
//
//  Created by 于洋 on 15/11/10.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "DynamicModel.h"
#import "App.h"
@implementation DynamicModel

- (void)requsetCallBackModel:(ModelBlock_t )blockModel;
{
    [App httpGET:AppURL_Discover_Getdiscover headerWithUserInfo:YES parameters:nil successBlock:^(int code, NSDictionary *dictResp) {
        
        if ([dictResp integerForKey:@"code"]==1) {
            if ([dictResp dictionaryForKey:@"data"]) {
                DynamicModel *model=[[DynamicModel alloc]initWithDictionary:[dictResp dictionaryForKey:@"data"] error:nil];
                if (model) {
                    blockModel(model);
                }
                
                
            }
            
        }
        
        
    } failureBlock:^(NSError *error) {
        
    }];
}
@end
@implementation DynamicUserModel

@end
@implementation DynamicContentModel



@end
