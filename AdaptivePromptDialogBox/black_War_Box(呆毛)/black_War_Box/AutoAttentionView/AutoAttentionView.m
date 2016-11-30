//
//  AutoAttentionView.m
//  BatchPro
//
//  Created by wangchao on 15-6-23.
//  Copyright (c) 2015年 wangchao. All rights reserved.
//

#import "AutoAttentionView.h"

@interface AutoAttentionView ()

@property(nonatomic, strong) UILabel *label;
@property(nonatomic,strong)UIView *c_view;

@end

static  CGFloat b_m_l = 15.0f;
static  CGFloat b_m_r = 15.0f;
static  CGFloat c_m_t = 10.0f;
static  CGFloat c_m_b = 10.0f;
static  CGFloat c_m_l = 10.0f;
static  CGFloat c_m_r = 10.0f;
static  CGFloat c_h = 0.0f;

static UILabel *tempLab = nil;

@implementation AutoAttentionView

+ (AutoAttentionView *)sharedInstance
{
    static AutoAttentionView *singleton = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        singleton = [[AutoAttentionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return singleton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];

        CGFloat a_w = self.frame.size.width;
        CGFloat a_h = self.frame.size.height;
        CGFloat b_w = (a_w - b_m_l - b_m_r);
        CGFloat c_w = (b_w - c_m_l - c_m_r);
        
        c_h = 0.0f;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake((a_w - c_m_l - c_m_r)*0.50f,
                                                               (a_h - c_m_t - c_m_b)*0.50f,
                                                               c_w,
                                                               c_h)];
        self.label.backgroundColor = [UIColor blackColor];
        [self.label sizeToFit];
        self.label.layer.cornerRadius = 3;
        [self.label.layer setMasksToBounds:YES];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:15];
        
        self.c_view = [[UIView alloc] initWithFrame:self.label.frame];
        self.c_view.backgroundColor = self.label.backgroundColor;
        self.c_view.layer.cornerRadius = self.label.layer.cornerRadius;
        [self.c_view.layer setMasksToBounds:YES];
        
        [self.c_view addSubview:self.label];
        [self addSubview:self.c_view];
        [self bringSubviewToFront:self.label];
  
    }
    return self;
}

- (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view
{
    c_h = 0.0f;
    b_m_l = 15.0f;
    b_m_r = 15.0f;
    c_m_l = 10.0f;
    
    tempLab = [[UILabel alloc] init];
    [tempLab sizeToFit];
    [self setFrame:[UIScreen mainScreen].bounds];
    self.label.alpha = 0;
    self.c_view.alpha = 0;
   
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineSpacing = 3.50f;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle};
    
    self.label.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
    tempLab.attributedText = self.label.attributedText;
    CGFloat a_w = self.frame.size.width;
    CGFloat a_h = self.frame.size.height;
    CGFloat b_w = (a_w - b_m_l - b_m_r);
    CGFloat c_w = (b_w - c_m_l - c_m_r);
    
    CGSize t_size = [self.label aav_getLableCGsize:CGSizeMake(c_h, 24) attributes:attributes];
    CGFloat t_w = t_size.width;
    
    if (t_w < c_w) {
        
        if (t_w < a_w*0.33f) {
            
            t_w = a_w*0.33f;
        }
        
        c_w = t_w;
        b_m_l = (a_w - c_w - c_m_l - c_m_r)*0.50f;

    }

    CGSize l_size = [self.label aav_getLableCGsize:CGSizeMake(c_w, c_h) attributes:attributes];
    
    c_h = l_size.height;
    
    [self.label setFrame:CGRectMake(c_m_l,
                                    c_m_t,
                                    c_w,
                                    c_h + c_m_b)];
    
    CGFloat b_m_t = (a_h  - c_h - c_m_t - c_m_b) * 0.50f;
    
    [self.c_view setFrame:CGRectMake(b_m_l,
                                     b_m_t,
                                     c_w + c_m_l + c_m_r,
                                     c_m_t + (c_h + c_m_b) + c_m_b)];


    if (b_m_l != 15.0f) {
        
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    
    if ([self.label is_NoNuLL_really:str]) {
        
        [self addSubview:self.c_view];
        
        [view addSubview:self];
    }

    [UIView animateWithDuration:0.01
        animations:^{
            self.label.alpha = 1.0f;
            self.c_view.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            [self performSelector:@selector(hideNow) withObject:nil afterDelay:1.0];
        }];
}

- (void)hideNow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.01
            animations:^{
                self.label.alpha = 0;
                self.c_view.alpha = 0;
            }
            completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
    });
}

@end
