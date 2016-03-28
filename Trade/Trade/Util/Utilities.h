//
//  Utilities.h
//  leyi
//
//  Created by Yuyangdexue on 15/5/8.
//  Copyright (c) 2015年 yiliao6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utilities : NSObject
    //CGRect newRe=[lb2_Str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lb2Font} context:nil];
+ (CGRect)boundingRectWithSize:(CGSize)size  attributes:(NSDictionary *)dic string:(NSString *)string;
//根据文本设置label的尺寸（单行）
+ (CGSize)setLabelSize:(NSString *)text font:(CGFloat)font;
//根据文本设置label的尺寸（多行）
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
//设置label副文本 （仅限两个字符串）
+ (NSMutableAttributedString *)setLabelText:(NSString *)string1 string2:(NSString *)string2 string1Font:(CGFloat)string1Font string2Font:(CGFloat)string2Font color:(UIColor *)color;
@end

@interface NSDictionary (Helper)

- (id)kObjectForKey:(id)aKey;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


@end

@interface NSMutableDictionary (Helper)

- (void)kSetObject:(id)obj forKey:(id)key;

@end

@interface NSString (Helper)

@end

@interface UILabel (Helper)

+ (UILabel *)labelWithRect:(CGRect)rect
                      text:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
             textAlignment:(NSTextAlignment)textAlignment;

+ (CGSize)sizeWithText:(NSString *)text
                  font:(UIFont *)font
               maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)boundingRectWithSize:(CGSize)size;
+ (CGFloat)getStingHeight:(NSString *)string;
+ (CGFloat)getStingWidth:(NSString *)string;

@end

@interface UIView (Helper)

- (void)addLabelWithRect:(CGRect)rect
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                fontSize:(CGFloat)fontSize
                     tag:(NSInteger)tag
           textAlignment:(NSTextAlignment)textAlignment;

- (void)addEdgingViewWithRect:(CGRect)rect
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)width
                    viewColor:(UIColor *)viewColor
                      viewTag:(int)tag;



-(UIView *)addHospitalViewWithRect:(CGRect)rect Dic:(NSDictionary *)dic andTag:(int )tag;

+ (void)cornerView:(UIView *)view andUpLeft:(UIRectCorner )upleft andUpRight:(UIRectCorner )upright andBottomLeft:(UIRectCorner )bottomleft  andBottomRight:(UIRectCorner )bottomright andSizeMake:(int) cornerlayerSize;


+ (UIView *)getNewButtonWithImage:(UIImage *)img title:(NSString *)title clickAction:(SEL)clickAction ViewController:(id)viewController;

@end

@interface UITextField (Helper)

+ (UITextField *)textFieldWithRect:(CGRect)rect
                              text:(NSString *)text
                       placeholder:(NSString *)placeholder
                         textColor:(UIColor *)textColor
                          fontSize:(CGFloat)fontSize
                     textAlignment:(NSTextAlignment)textAlignment;

- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end

@interface UIButton (Helper)
+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
    BackgroundImageWithColor:(UIColor *)imageColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                   titleFont:(CGFloat)font contentEdgeInsets:(UIEdgeInsets )contentEdgeInsets;

+ (UIButton *)ButtonWithRect:(CGRect)rect
                defaultImage:(NSString *)defaultimage
                selectedImage:(NSString *)selectedimage
                highlightedImage:(NSString *)highlightedimage
                 clickAction:(SEL)clickAction
              viewController:(id)viewController;


+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
    BackgroundImageWithColor:(UIColor *)imageColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                   titleFont:(CGFloat)font contentEdgeInsets:(UIEdgeInsets )contentEdgeInsets cornerRadius:(float)radius;
@end

@interface UIImageView (Helper)
+ (UIImageView *)ImageViewWithRect:(CGRect)rect imageName:(NSString *)name tag:(int )tag parentId:(id)body;

- (void)fillImage;
- (void)changeCircleCornerRadius:(CGFloat )cornerRadius andborderWidth:(CGFloat)width;

@end





@interface UIImage (Helper)
/**
 纯色UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 剪切图片，从图片中心向边缘最大区域
 */
+ (UIImage *)getCutImageSize:(CGSize)size
               originalImage:(UIImage *)originalImage;

/**
 修改图片处理后旋转的问题
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end

@interface NSData (ASEEncryption)


@end

@interface UITableView (Helper)

- (void)UIEdgeInsetsZero;

@end


@interface UITableViewCell(Helper)

- (void)setEdgeInsetsZero;

@end




