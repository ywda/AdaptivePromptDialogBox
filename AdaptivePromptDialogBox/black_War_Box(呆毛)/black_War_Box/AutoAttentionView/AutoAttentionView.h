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

+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view;

+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view hScale:(CGFloat)scale;

@end
