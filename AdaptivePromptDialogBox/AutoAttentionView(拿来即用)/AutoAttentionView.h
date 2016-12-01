//
//  AutoAttentionView.h
//  black_War_Box
//
//  Created by Mac_NJW on 16/11/30.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+aav.h"

@interface AutoAttentionView : UIView

#pragma mark———————— 页面文字提示效果

/* 提示文字(str) 到 父视图上 (view) 🐂*/
+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view;

/* 提示文字(str) 到 父视图上 (view) 设置提示框（偏上、中、下部位 def = 1.0f 中间<-0.80f~0.80f>） 🐂*/
+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view hScale:(CGFloat)scale;


#pragma mark———————— 页面展示效果 <使用场景：添加无数据图片>

/* 添加无数据图（默认图）到 父视图（s_view）设置图下的文字（str）✨✨*/
+ (void)ndv_With:(NSString *)str andWith:(__weak UIView *)s_view;

/* 添加无数据图（自定义图）到 父视图（s_view）设置图下的文字（str）✨✨*/
+ (void)ndv_With:(NSString *)str img:(NSString*)imgName andWith:(__weak UIView *)s_view;

/* 移除图片，文字 从 父视图 ✨✨*/
+ (void)ndv_Remove;

@end
