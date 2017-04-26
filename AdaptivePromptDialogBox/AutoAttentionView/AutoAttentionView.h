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

#pragma mark———— 页面文字提示效果

/* 提示框 */
+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)superView;

/* scale 值（-0.80f~0.80f） */
+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)superView hScale:(CGFloat)scale;


#pragma mark———— 无网络下自动加载无数据图片

/* 添加无数据图 */
+ (void)noDataViewWith:(NSString *)str andWith:(__weak UIView *)superView;

/* 添加无数据图 指定图片 */
+ (void)noDataViewWith:(NSString *)str img:(NSString*)imgName andWith:(__weak UIView *)superView;

/* 移除图片，文字 从 父视图 */
+ (void)noDataViewRemove;

@end
