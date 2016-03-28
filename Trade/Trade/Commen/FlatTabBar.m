//
//  FlatTabBar.m
//  nj12320
//
//  Created by yiliao6 on 24/12/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "FlatTabBar.h"
#import "Constants.h"
#define SPAN_WIDTH 40
typedef NS_ENUM(int, ViewTag) {
    ViewTag_BackView = 600,
    ViewTag_Button = 1000,
    ViewTag_TextField = 2000,
    ViewTag_Label = 3000,
    ViewTag_ImageView = 4000,
    ViewTag_Switch = 5000
};
@implementation FlatTabBar {
  void (^onClickTab)(int index);

  NSMutableArray *arrTitle;
  UIView *selectedBar;
  CGSize itemSize;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items {

  if (self = [super initWithFrame:frame]) {
    arrTitle = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
    NSInteger len = items.count;
    itemSize = CGSizeMake(frame.size.width / len, frame.size.height);

    [items enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx,
                                        BOOL *stop) {

      NSString *title = [item stringForKey:@"title"];
      NSString *badge = [item stringForKey:@"badge"];
      badge = [badge isEqualToString:@"0"] ? @"" : badge;
      NSString *textToAdd = [NSString stringWithFormat:@"%@ %@", badge, title];
      textToAdd =
          [textToAdd stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      btn.backgroundColor = [UIColor clearColor];
      btn.frame = CGRectMake(itemSize.width * idx + 2, 0, itemSize.width - 4,
                             itemSize.height);
      [arrTitle addObject:textToAdd];

      btn.tag = ViewTag_Button + idx;
      [btn addTarget:self
                    action:@selector(clickTab:)
          forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:btn];
      [self changeTabState:(int)idx bSelected:(_selectedIndex == idx)];

      if (idx > 0) {
        UIView *line = [[UIView alloc]
            initWithFrame:CGRectMake(itemSize.width * idx, 10, 0.5,
                                     frame.size.height - 10 * 2)];
        line.backgroundColor = [UIColor lightGrayColor];
        //        [self addSubview:line];
      }

    }];
    selectedBar = [UIView new];
    selectedBar.frame =
        CGRectMake(_selectedIndex * itemSize.width + SPAN_WIDTH,
                   itemSize.height - 3, itemSize.width - SPAN_WIDTH * 2, 3);
    selectedBar.backgroundColor = kColor_RegBack_Color;
    [self addSubview:selectedBar];
//    UIView *lineView =
//        [[UIView alloc] initWithFrame:CGRectMake(0, itemSize.height - 0.5,
//                                                 frame.size.width, 0.5)];
//    lineView.backgroundColor = kColor_Line_Color;
//    [self addSubview:lineView];
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(changeFontSize:)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
  }

  return self;
}

- (void)clickTab:(UIButton *)btn {
  int index = (int)btn.tag - ViewTag_Button;
  self.selectedIndex = index;

  if (onClickTab) {
    onClickTab(index);
  }
}

- (void)changeFontSize:(NSNotification *)notice {
  NSInteger len = arrTitle.count;
  for (NSInteger k = 0; k < len; k++) {
    [self changeTabState:(int)k bSelected:(_selectedIndex == k)];
  }
}

- (void)setSelectedIndex:(int)index {
  [self changeTabState:self.selectedIndex bSelected:NO];
  [self changeTabState:index bSelected:YES];
  if (_selectedIndex != index) {
    CGRect newFrame = selectedBar.frame;
    newFrame.origin.x = index * itemSize.width + SPAN_WIDTH;
    [UIView animateWithDuration:0.2
        delay:0.0
        options:UIViewAnimationOptionCurveEaseInOut
        animations:^{
          selectedBar.frame = newFrame;
        }
        completion:^(BOOL finished){

        }];
  }
  _selectedIndex = index;
}

- (void)changeTabState:(int)index bSelected:(BOOL)bSelected {
  UIButton *btn = (UIButton *)[self viewWithTag:ViewTag_Button + index];
  if (!btn) {
    return;
  }
  NSString *textToAdd = (NSString *)arrTitle[index];
  UIColor *fontColor = bSelected ? [UIColor blackColor] : [UIColor blackColor];
  NSRange range = [textToAdd rangeOfString:@" "];

  NSUInteger loc = 0;
  if (range.location != NSNotFound) {
    loc = range.location;
  }

  NSMutableAttributedString *attrString =
      [[NSMutableAttributedString alloc] initWithString:textToAdd];
  if (loc > 0) {
    [attrString
        addAttribute:NSFontAttributeName
               value:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]
               range:NSMakeRange(0, loc)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:fontColor
                       range:NSMakeRange(0, loc)];
  }
  int istart = loc > 0 ? (int)loc + 1 : 0;
  int iend = loc > 0 ? (int)textToAdd.length - (int)loc - 1 : (int)textToAdd.length;
  [attrString
      addAttribute:NSFontAttributeName
             value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
             range:NSMakeRange(istart, iend)];
  [attrString addAttribute:NSForegroundColorAttributeName
                     value:fontColor
                     range:NSMakeRange(istart, iend)];
  [btn setAttributedTitle:attrString forState:UIControlStateNormal];
}

- (void)resetItems:(NSArray *)items {
  [arrTitle removeAllObjects];

  [items enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx,
                                      BOOL *stop) {
    NSString *title = [item stringForKey:@"title"];
    NSString *badge = [item stringForKey:@"badge"];
    badge = [badge isEqualToString:@"0"] ? @"" : badge;
    NSString *textToAdd = [NSString stringWithFormat:@"%@ %@", badge, title];
    [arrTitle addObject:textToAdd];
    [self changeTabState:(int)idx bSelected:(_selectedIndex == idx)];
  }];
}

- (void)setOnClickTab:(void (^)(int index))block {
  onClickTab = [block copy];
}
- (void)removeFromSuperview {
  [super removeFromSuperview];
  onClickTab = nil;
}

- (void)dealloc {
  onClickTab = nil;
}

@end
