//
//  NSString+textSize.m
//  GGLabelLimitDemo
//
//  Created by 顾宜林 on 2020/1/7.
//  Copyright © 2020 顾宜林. All rights reserved.
//

#import "NSString+textSize.h"

@implementation NSString (textSize)
- (NSMutableAttributedString *)GG_setTextWithFont:(CGFloat)font
                                           isBold:(BOOL)isBold
                                      lineSpacing:(CGFloat)lineSpacing
                                         showSize:(CGSize)size{
        UIFont *textFont = [UIFont systemFontOfSize:font];
        if (isBold) {
          textFont = [UIFont boldSystemFontOfSize:font];
         }
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpacing;
        NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle};
        NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
        [attributeString addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, self.length)];
        CGRect rect = [attributeString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        // 单行且是汉字的时候:行高=0
        if ((rect.size.height - textFont.lineHeight) <= lineSpacing) {
            paragraphStyle.lineSpacing = 0;
            if ([self containChinese:self]) {
                paragraphStyle.lineSpacing = 0;
            }
        }else{
            paragraphStyle.lineSpacing = lineSpacing;
        }
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
        return attributeString;
}

- (CGFloat)GG_getMaxHeightWithFont:(CGFloat)font
                            isBold:(BOOL)isBold
                       lineSpacing:(CGFloat)lineSpacing
                          showSize:(CGSize)size{
    UIFont *textFont = [UIFont systemFontOfSize:font];
    if (isBold) {
       textFont = [UIFont boldSystemFontOfSize:font];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    [attributeString addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, self.length)];
    CGRect rect = [attributeString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - textFont.lineHeight) <= lineSpacing) {
         rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-lineSpacing+3);
        if ([self containChinese:self]) {
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    CGFloat height = rect.size.height;
    return ceil(height);
}

- (CGFloat)GG_getLimitHeightWithFont:(CGFloat)font
                              isBold:(BOOL)isBold
                         lineSpacing:(CGFloat)lineSpacing
                                 row:(NSInteger)row{
     UIFont *textFont = [UIFont systemFontOfSize:font];
     if (isBold) {
        textFont = [UIFont boldSystemFontOfSize:font];
     }
      CGFloat height = textFont.lineHeight *row + lineSpacing * (row-1);
      return ceil(height);
}

/*optionMethod*/
- (BOOL)containChinese:(NSString *)str {
    BOOL haveChinese = NO;
    for(int i=0; i< [str length];i++){
        unichar a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            haveChinese = YES;
        }
    }
    return haveChinese;
}
@end
