//
//  AutoAttentionView.h
//  BatchPro
//
//  Created by wangchao on 15-6-23.
//  Copyright (c) 2015年 wangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+aav.h"

@interface AutoAttentionView : UIView

+ (AutoAttentionView *)sharedInstance;

- (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view;

@end
