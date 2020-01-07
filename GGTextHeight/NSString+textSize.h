//
//  NSString+textSize.h
//  GGLabelLimitDemo
//
//  Created by 顾宜林 on 2020/1/7.
//  Copyright © 2020 顾宜林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (textSize)

- (NSMutableAttributedString *)GG_setTextWithFont:(CGFloat)font
                                           isBold:(BOOL)isBold
                                      lineSpacing:(CGFloat)lineSpacing
                                         showSize:(CGSize)size;

- (CGFloat)GG_getMaxHeightWithFont:(CGFloat)font
                            isBold:(BOOL)isBold
                       lineSpacing:(CGFloat)lineSpacing
                          showSize:(CGSize)size;

- (CGFloat)GG_getLimitHeightWithFont:(CGFloat)font
                             isBold:(BOOL)isBold
                        lineSpacing:(CGFloat)lineSpacing
                           row:(NSInteger)row;


@end

