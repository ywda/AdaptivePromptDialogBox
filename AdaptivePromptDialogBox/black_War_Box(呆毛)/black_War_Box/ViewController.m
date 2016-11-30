//
//  ViewController.m
//  black_War_Box
//
//  Created by Mac_NJW on 16/11/30.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#define K_TEXT_a  @"倭"
#define K_TEXT_b  @"倭人"
#define K_TEXT_c  @"倭人为"
#define K_TEXT_d  @"李光耀一"
#define K_TEXT_e  @"倭人为寇"
#define K_TEXT_f  @"倭人为寇,是寇"
#define K_TEXT_g  @"倭人为寇,是为倭寇。"
#define K_TEXT_h  @"李光耀一人民行动党人"
#define K_TEXT_i  @"倭人为寇是寇是寇是寇是寇"
#define K_TEXT_j  @"倭人为寇,是寇是寇是寇是寇是寇"
#define K_TEXT_k  @"倭人为寇,是为倭寇。是寇是寇是寇是寇"
#define K_TEXT_l  @"李光耀一人民行动党人民行动党人民行动党"
#define K_TEXT_m  @"倭人为寇是寇是寇是寇是寇是寇是寇是寇是寇"
#define K_TEXT_n  @"倭人为寇,是寇是寇是寇是寇是寇是寇是寇是寇是寇"
#define K_TEXT_o  @"倭人为寇,是为倭寇。是寇是寇是寇是寇是寇是寇是寇是寇"
#define K_TEXT_p  @"李光耀（Lee Kuan Yew，1923年09月16日~ 2015年03月23日），又名GCMG、CH，新加坡华人，祖籍广东省梅州市大埔县高陂镇党溪乡，毕业于新加坡莱佛士学院，新加坡人民行动党创始人之一"


#import "ViewController.h"
#import "AutoAttentionView.h"

@interface ViewController ()
{
    int _sumNum;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _sumNum = 0;
    
}


// 模拟黑框出现
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    NSString *temp_Str = @"";
    
    BOOL is_a = (0 == _sumNum)?YES:NO;
    BOOL is_b = (1 == _sumNum)?YES:NO;
    BOOL is_c = (2 == _sumNum)?YES:NO;
    BOOL is_d = (3 == _sumNum)?YES:NO;
    
    BOOL is_e = (4 == _sumNum)?YES:NO;
    BOOL is_f = (5 == _sumNum)?YES:NO;
    BOOL is_g = (6 == _sumNum)?YES:NO;
    BOOL is_h = (7 == _sumNum)?YES:NO;
    
    BOOL is_i = (8 == _sumNum)?YES:NO;
    BOOL is_j = (9 == _sumNum)?YES:NO;
    BOOL is_k = (10 == _sumNum)?YES:NO;
    BOOL is_l = (11 == _sumNum)?YES:NO;
    
    BOOL is_m = (12 == _sumNum)?YES:NO;
    BOOL is_n = (13 == _sumNum)?YES:NO;
    BOOL is_o = (14 == _sumNum)?YES:NO;
    BOOL is_p = (15 == _sumNum)?YES:NO;

    
    
    if (is_a) {
        
        temp_Str = K_TEXT_a;
    }
    else if (is_b) {
        
        temp_Str = K_TEXT_b;
    }
    else if (is_c) {
        
        temp_Str = K_TEXT_c;
    }
    else if (is_d) {
        
        temp_Str = K_TEXT_d;
    }
    else if (is_e) {//
        
        temp_Str = K_TEXT_e;
    }
    else if (is_f) {
        
        temp_Str = K_TEXT_f;
    }
    else if (is_g) {
        
        temp_Str = K_TEXT_g;
    }
    else if (is_h) {
        
        temp_Str = K_TEXT_h;
    }
    else if (is_i) {
        
        temp_Str = K_TEXT_i;
    }else if (is_j) {
        
        temp_Str = K_TEXT_j;
    }else if (is_k) {
        
        temp_Str = K_TEXT_k;
    }else if (is_l) {
        
        temp_Str = K_TEXT_l;
    }
    else if (is_m) {
        
        temp_Str = K_TEXT_m;
    }
    else if (is_n) {
        
        temp_Str = K_TEXT_n;
    }
    else if (is_o) {
        
        temp_Str = K_TEXT_o;
    }
    else if (is_p) {
        
        temp_Str = K_TEXT_p;
    }else{
        
        _sumNum = -1;//-1 模拟空字符串；0开始才是上面的判定开始
    }
    //temp_Str = K_TEXT_a;
    
    [[AutoAttentionView sharedInstance] autoShowAttentionWith:temp_Str andWith:[UIApplication sharedApplication].keyWindow];
    
    // ...自增模拟选择长提示文字
    
    _sumNum++;
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
