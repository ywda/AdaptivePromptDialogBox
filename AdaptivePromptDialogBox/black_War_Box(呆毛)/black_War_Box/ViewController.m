//
//  ViewController.m
//  black_War_Box
//
//  Created by Mac_NJW on 16/11/30.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//


#import "ViewController.h"
#import "AutoAttentionView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textContentTV;
@property (weak, nonatomic) IBOutlet UITextField *paramTF;
@property (weak, nonatomic) IBOutlet UIButton *dataStatusShowBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// 提示文案
- (IBAction)showPromptCopywriter:(id)sender {
    
    if ([self.paramTF.text isEqualToString:@""]) {
        self.paramTF.text = @"0";
    }
    
    if ([self.textContentTV.text isEqualToString:@""]) {
        
        self.textContentTV.text = @"请 star 我一下！";
    }
    
    [AutoAttentionView autoShowAttentionWith:self.textContentTV.text
                                     andWith:self.view
                                      hScale:[self.paramTF.text floatValue]];
}

- (IBAction)setDefaultParm:(id)sender {
    self.paramTF.text = @"0.8";
}

- (IBAction)clearTVText:(id)sender {
    
    self.textContentTV.text = @"";
}

- (IBAction)stepAction:(UIStepper *)sender {
    
    self.paramTF.text =[NSString stringWithFormat:@"%f",sender.value];
}


// 模拟网络请求有无数据占位图
- (IBAction)noNetAndDataJudge:(id)sender {
    
    [self.dataStatusShowBtn setTitle:@"模拟网络请求无数据" forState:UIControlStateNormal];
    
    // 模拟无数据情况下加载 无数据图
    __weak typeof(self) WeakSelf = self;
    
    [AutoAttentionView ndv_With:@"敬请期待" andWith:WeakSelf.view];
    
    // 1秒后模拟有数据，移除无数据组件
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self.paramTF.text isEqualToString:@""]) {
            self.paramTF.text = @"0";
        }
        
         [self.dataStatusShowBtn setTitle:@"处于有数据状态" forState:UIControlStateNormal];
        
        [AutoAttentionView autoShowAttentionWith:@"网络连接后，模拟加载出了数据，占位图片自动消失"
                                         andWith:self.view
                                          hScale:[self.paramTF.text floatValue]];
        
        [AutoAttentionView ndv_Remove];
    });
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
