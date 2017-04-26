//
//  UILabel+aav.m
//  black_War_Box
//
//  Created by Mac_NJW on 16/11/30.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#import "UILabel+aav.h"

@implementation UILabel (aav)

// 设置富文本
- (void)aav_makeLableRichText:(NSString*)richText attributeDic:(NSDictionary*)dic{
    
    if ([self is_NoNuLL_really:richText]) {
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSRange range = [self.text rangeOfString:richText];
        [attributeString addAttributes:dic range:range];
        self.attributedText = attributeString;
        
    }else{
        
        NSLog(@"仅仅是方便 UIlabe 的富文本的格式支持判断: 你没有输入要设置富文本的文字，不能为nil");
    }
    
}

// 存在、非nil 判定（对字符串对象判定）
- (BOOL)is_NoNuLL_really:(NSString*)tempStr{
    
    return ((nil != tempStr)&&
            (![tempStr isEqualToString:@""]))?YES:NO;
    
}

// 设置规格
- (void)aav_setLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic{
    
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setNumberOfLines:0];
    CGSize size = [self.text boundingRectWithSize:orignSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height);
    
}


- (CGSize)aav_getLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic{
    
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setNumberOfLines:0];
    
    return [self.text boundingRectWithSize:orignSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

// 设置行宽的函数
-(void)aav_setLabsLineSpacing:(CGFloat)space{
    
    self.numberOfLines = 0;
    
    // 设置 Lab 行距使用
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineSpacing = space;
    
    NSDictionary *attributes = @{ NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle};
    
    self.attributedText = [[NSAttributedString alloc]initWithString:self.text attributes:attributes];
    
    [self sizeToFit];
    
}

@end
