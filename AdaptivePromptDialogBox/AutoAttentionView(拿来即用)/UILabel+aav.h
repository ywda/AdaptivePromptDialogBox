//
//  UILabel+aav.h
//  black_War_Box
//
//  Created by Mac_NJW on 16/11/30.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (aav)

// 存在、非nil 判定（对字符串对象判定）
- (BOOL)is_NoNuLL_really:(NSString*)tempStr;

/**
 *  本次封装，仅仅是方便 UIlabe 的富文本的格式支持
 *
 *  @param richText 要设置的文字
 *  @param dic        要传入的字体格式的字典
 */
- (void)aav_makeLableRichText:(NSString*)richText attributeDic:(NSDictionary*)dic;


/**
 *  本次封装，根据 Labe 的文字自己计算出高度,并设置 Lab 的位置
 *
 *  @param orignSize 原来的 size ；如要自适应高度，一般传入 CGSizeMake(控件的宽度, 1000)
 *  @param dic       Labe 文字的一些属性
 */
- (void)aav_setLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic;


/**
 *  本次封装，仅仅是方便，根据 Labe 的文字自己计算出高度
 *
 *  @param orignSize 原来的 size ；如要自适应高度，一般传入 CGSizeMake(控件的宽度, 1000)
 *  @param dic       Labe 文字的一些属性
 */
- (CGSize)aav_getLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic;

// 设置行宽的函数
-(void)aav_setLabsLineSpacing:(CGFloat)space;


@end
