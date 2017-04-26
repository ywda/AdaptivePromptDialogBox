//
//  AutoAttentionView.m
//  black_War_Box
//
//  Created by Mac_NJW on 16/11/30.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#define KNoDataLabTag  6302
#define KNoDataImgTag  6303

#import "AutoAttentionView.h"
#import "Masonry.h"

@interface AutoAttentionView ()

@property(nonatomic, strong) UILabel *label;
@property(nonatomic,strong)UIView *containerView;

@end

static  CGFloat outterViewXLeft = 15.0f;
static  CGFloat outterViewXRight = 15.0f;
static  CGFloat containerViewMarginTop = 10.0f;
static  CGFloat containerViewMarginBottom = 10.0f;
static  CGFloat containerViewMarginLeft = 10.0f;
static  CGFloat containerViewMarginRight = 10.0f;
static  CGFloat containerHeight = 0.0f;
static  CGFloat orignYscale = 1.0f;

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

        CGFloat screenWidth = self.frame.size.width;
        CGFloat screenHeight = self.frame.size.height;
        CGFloat b_w = (screenWidth - outterViewXLeft - outterViewXRight);
        CGFloat containerWidth = (b_w - containerViewMarginLeft - containerViewMarginRight);
        
        containerHeight = 0.0f;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - containerViewMarginLeft - containerViewMarginRight)*0.50f,
                                                               (screenHeight - containerViewMarginTop - containerViewMarginBottom),
                                                               containerWidth,
                                                               containerHeight)];
        self.label.backgroundColor = [UIColor blackColor];
        [self.label sizeToFit];
        self.label.layer.cornerRadius = 3;
        [self.label.layer setMasksToBounds:YES];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:15];
        
        self.containerView = [[UIView alloc] initWithFrame:self.label.frame];
        self.containerView.backgroundColor = self.label.backgroundColor;
        self.containerView.layer.cornerRadius = self.label.layer.cornerRadius;
        [self.containerView.layer setMasksToBounds:YES];
        
        [self.containerView addSubview:self.label];
        [self addSubview:self.containerView];
        [self bringSubviewToFront:self.label];
  
    }
    return self;
}

+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)superView
{
    share = [AutoAttentionView sharedInstance];
    
    containerHeight = 0.0f;
    outterViewXLeft = 15.0f;
    outterViewXRight = 15.0f;
    containerViewMarginLeft = 10.0f;
    
    tempLab = [[UILabel alloc] init];
    [tempLab sizeToFit];
    [share setFrame:[UIScreen mainScreen].bounds];
    share.label.alpha = 0;
    share.containerView.alpha = 0;
   
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineSpacing = 3.50f;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle};
    
    share.label.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
    tempLab.attributedText = share.label.attributedText;
    CGFloat screenWidth = share.frame.size.width;
    CGFloat screenHeight = share.frame.size.height*orignYscale;
    CGFloat outterViewWidth = (screenWidth - outterViewXLeft - outterViewXRight);
    CGFloat containerViewWidth = (outterViewWidth - containerViewMarginLeft - containerViewMarginRight);
    
    CGSize t_size = [share.label aav_getLableCGsize:CGSizeMake(containerHeight, 24) attributes:attributes];
    CGFloat tempWidth = t_size.width;
    
    if (tempWidth < containerViewWidth) {
        
        if (tempWidth < screenWidth*0.33f) {
            
            tempWidth = screenWidth*0.33f;
        }
        
        containerViewWidth = tempWidth;
        outterViewXLeft = (screenWidth - containerViewWidth - containerViewMarginLeft - containerViewMarginRight)*0.50f;

    }

    CGSize l_size = [share.label aav_getLableCGsize:CGSizeMake(containerViewWidth, containerHeight) attributes:attributes];
    
    containerHeight = l_size.height;
    
    [share.label setFrame:CGRectMake(containerViewMarginLeft,
                                    containerViewMarginTop,
                                    containerViewWidth,
                                    containerHeight + containerViewMarginBottom)];
    
    CGFloat b_m_t = (screenHeight  - containerHeight - containerViewMarginTop - containerViewMarginBottom) * 0.50f;
    
    [share.containerView setFrame:CGRectMake(outterViewXLeft,
                                     b_m_t,
                                     containerViewWidth + containerViewMarginLeft + containerViewMarginRight,
                                     containerViewMarginTop + (containerHeight + containerViewMarginBottom) + containerViewMarginBottom)];


    if (outterViewXLeft != 15.0f) {
        
        share.label.textAlignment = NSTextAlignmentCenter;
    }
    
    if ([share.label is_NoNuLL_really:str]) {
        
        [share addSubview:share.containerView];
        
        [superView addSubview:share];
    }

    [UIView animateWithDuration:0.3
        animations:^{
            share.label.alpha = 1.0f;
            share.containerView.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            [share performSelector:@selector(hideNow) withObject:nil afterDelay:1.0];
        }];
}

+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)superView hScale:(CGFloat)scale{
    
    BOOL is_scale = (scale >= -0.80f && scale <= 0.80f)?YES:NO;
    orignYscale = 1.0f;
    if (is_scale) {
        
        orignYscale += scale;
    }
    
    [AutoAttentionView autoShowAttentionWith:str andWith:superView];
}

- (void)hideNow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3
            animations:^{
                share.label.alpha = 0;
                share.containerView.alpha = 0;
            }
            completion:^(BOOL finished) {
                [share removeFromSuperview];
            }];
    });
}


#pragma mark———————— 页面展示效果 <使用场景：添加无数据图片>

+ (void)noDataViewWith:(NSString *)str andWith:(__weak UIView *)superView{
    
    __weak UIView *view = superView;
    
    BOOL is_link_net = YES;
    
    if (nil == [superView viewWithTag:KNoDataImgTag]) {
        
        if (!no_data_img) {
            
            no_data_img = [UIImageView new];
            no_data_img.tag = KNoDataImgTag;
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
    
    if (nil == [superView viewWithTag:KNoDataLabTag]) {
        
        if (!no_data_lab) {
            
            no_data_lab = [UILabel new];
            no_data_lab.tag = KNoDataLabTag;
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

+ (void)noDataViewWith:(NSString *)str img:(NSString*)imgName andWith:(__weak UIView *)superView{
    
    _img_Name = imgName;
    [AutoAttentionView noDataViewWith:str  andWith:superView];
}

+ (void)noDataViewRemove{
    
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
