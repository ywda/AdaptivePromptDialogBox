//
//  AutoAttentionView.m
//  black_War_Box
//
//  Created by Mac_NJW on 16/11/30.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#define K_NO_DATA_LAB_TAG  6302
#define K_NO_DATA_IMG_TAG  6303

#import "AutoAttentionView.h"
#import "Masonry.h"

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
static  CGFloat h_scale = 1.0f;

static UIImageView * no_data_img = nil;
static UILabel* no_data_lab = nil;
static NSString * _img_Name = nil;
static UILabel *tempLab = nil;
static AutoAttentionView * share = nil;

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
                                                               (a_h - c_m_t - c_m_b),
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

+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view
{
    share = [AutoAttentionView sharedInstance];
    
    c_h = 0.0f;
    b_m_l = 15.0f;
    b_m_r = 15.0f;
    c_m_l = 10.0f;
    
    tempLab = [[UILabel alloc] init];
    [tempLab sizeToFit];
    [share setFrame:[UIScreen mainScreen].bounds];
    share.label.alpha = 0;
    share.c_view.alpha = 0;
   
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineSpacing = 3.50f;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle};
    
    share.label.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
    tempLab.attributedText = share.label.attributedText;
    CGFloat a_w = share.frame.size.width;
    CGFloat a_h = share.frame.size.height*h_scale;
    CGFloat b_w = (a_w - b_m_l - b_m_r);
    CGFloat c_w = (b_w - c_m_l - c_m_r);
    
    CGSize t_size = [share.label aav_getLableCGsize:CGSizeMake(c_h, 24) attributes:attributes];
    CGFloat t_w = t_size.width;
    
    if (t_w < c_w) {
        
        if (t_w < a_w*0.33f) {
            
            t_w = a_w*0.33f;
        }
        
        c_w = t_w;
        b_m_l = (a_w - c_w - c_m_l - c_m_r)*0.50f;

    }

    CGSize l_size = [share.label aav_getLableCGsize:CGSizeMake(c_w, c_h) attributes:attributes];
    
    c_h = l_size.height;
    
    [share.label setFrame:CGRectMake(c_m_l,
                                    c_m_t,
                                    c_w,
                                    c_h + c_m_b)];
    
    CGFloat b_m_t = (a_h  - c_h - c_m_t - c_m_b) * 0.50f;
    
    [share.c_view setFrame:CGRectMake(b_m_l,
                                     b_m_t,
                                     c_w + c_m_l + c_m_r,
                                     c_m_t + (c_h + c_m_b) + c_m_b)];


    if (b_m_l != 15.0f) {
        
        share.label.textAlignment = NSTextAlignmentCenter;
    }
    
    if ([share.label is_NoNuLL_really:str]) {
        
        [share addSubview:share.c_view];
        
        [view addSubview:share];
    }

    [UIView animateWithDuration:0.3
        animations:^{
            share.label.alpha = 1.0f;
            share.c_view.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            [share performSelector:@selector(hideNow) withObject:nil afterDelay:1.0];
        }];
}

+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view hScale:(CGFloat)scale{
    
    BOOL is_scale = (scale >= -0.80f && scale <= 0.80f)?YES:NO;
    h_scale = 1.0f;
    if (is_scale) {
        
        h_scale += scale;
    }
    
    [AutoAttentionView autoShowAttentionWith:str andWith:view];
}

- (void)hideNow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3
            animations:^{
                share.label.alpha = 0;
                share.c_view.alpha = 0;
            }
            completion:^(BOOL finished) {
                [share removeFromSuperview];
            }];
    });
}


#pragma mark———————— 页面展示效果 <使用场景：添加无数据图片>

+ (void)ndv_With:(NSString *)str andWith:(__weak UIView *)s_view{

    __weak UIView *view = s_view;

    BOOL is_link_net = YES;

    if (nil == [s_view viewWithTag:K_NO_DATA_IMG_TAG]) {

        if (!no_data_img) {

            no_data_img = [UIImageView new];
            no_data_img.tag = K_NO_DATA_IMG_TAG;
            [view addSubview:no_data_img];

            [no_data_img mas_makeConstraints:^(MASConstraintMaker *make) {

                make.centerX.equalTo(view).offset(12);
                make.centerY.equalTo(view).offset(-(10+30));
                make.width.mas_equalTo(99);
                make.height.mas_equalTo(70);
            }];
        }else{

            [view addSubview:no_data_img];

            [no_data_img mas_makeConstraints:^(MASConstraintMaker *make) {

                make.centerX.equalTo(view).offset(12);
                make.centerY.equalTo(view).offset(-(10+30));
                make.width.mas_equalTo(99);
                make.height.mas_equalTo(70);
            }];

        }

        if (_img_Name) {

            no_data_img.image = [UIImage imageNamed:_img_Name];
        }else{

            no_data_img.image = [UIImage imageNamed:@"icon_wu.png"];
        }

    }

    if (nil == [s_view viewWithTag:K_NO_DATA_LAB_TAG]) {

        if (!no_data_lab) {

            no_data_lab = [UILabel new];
            no_data_lab.tag = K_NO_DATA_LAB_TAG;
            no_data_lab.textAlignment = NSTextAlignmentCenter;
            [view addSubview:no_data_lab];

            [no_data_lab mas_makeConstraints:^(MASConstraintMaker *make) {

                make.centerX.equalTo(view);
                make.top.equalTo(no_data_img.mas_bottom).offset(10);
                make.width.equalTo(view);
                make.height.mas_equalTo(30);
            }];

        }else{

            [view addSubview:no_data_lab];

            [no_data_lab mas_makeConstraints:^(MASConstraintMaker *make) {

                make.centerX.equalTo(view);
                make.top.equalTo(no_data_img.mas_bottom).offset(10);
                make.width.equalTo(view);
                make.height.mas_equalTo(30);
            }];
        }

    }

    if (no_data_lab) {

        if (is_link_net) {

            // 有网络
            no_data_lab.text = str;

        }else{

            // 无网络
            no_data_lab.text = @"网络连接失败";
        }
    }
}

+ (void)ndv_With:(NSString *)str img:(NSString*)imgName andWith:(__weak UIView *)s_view{
    
    _img_Name = imgName;
    [AutoAttentionView ndv_With:str  andWith:s_view];
}

+ (void)ndv_Remove{
    
    if (no_data_img) {
        
        [no_data_img removeFromSuperview];
        no_data_img = nil;
    }
    
    if (no_data_lab) {
        
        [no_data_lab removeFromSuperview];
        no_data_lab = nil;
    }
}

@end
