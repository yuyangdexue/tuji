//
//  MenuSourceModel.m
//  Trade
//
//  Created by Yuyangdexue on 15/6/24.
//  Copyright (c) 2015年 yuyang. All rights reserved.
//

#import "MenuSourceModel.h"

@implementation MenuSourceModel
- (instancetype)initWithFileName:(NSString *)fileName
                       extension:(NSString *)extension {
    NSString *strJSONPath =
    [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    NSDictionary *dict = [NSJSONSerialization
                          JSONObjectWithData:[NSData dataWithContentsOfFile:strJSONPath]
                          options:0
                          error:nil];
    
    self = [self initWithDictionary:dict error:nil];
    return self;
}
@end
