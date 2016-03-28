//
//  BarButtonModel.h
//  huaqiao
//
//  Created by yiliao6 on 21/4/15.
//  Copyright (c) 2015 yiliao6. All rights reserved.
//

#import "JSONModel.h"

@interface BarButtonModel : JSONModel

/**
 *  Display Text
 */
@property (nonatomic, strong) NSString<Optional>* title;

/**
 *  Image Name when it's normal.
 */
@property (nonatomic, strong) NSString<Optional>* image;

/**
 *  Image Name when it's highlighted.
 */
@property (nonatomic, strong) NSString<Optional>* imageHL;
@property (nonatomic, strong) NSNumber<Optional>* width;
@property (nonatomic, strong) NSNumber<Optional>* height;

/**
 *  UIControl's Tag
 */
@property (nonatomic, strong) NSNumber<Optional>* tag;
@end
