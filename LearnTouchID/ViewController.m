//
//  ViewController.m
//  LearnTouchID
//
//  Created by LIAN on 16/1/13.
//  Copyright (c) 2016年 com.Alice. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@property (strong,nonatomic) UIButton *btnClick;

@end

@implementation ViewController

@synthesize btnClick = _btnClick;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _btnClick = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnClick.frame = CGRectMake(50, 100, 200, 30);
    [_btnClick setTitle:@"点击测试指纹" forState:UIControlStateNormal];
    [_btnClick addTarget:self action:@selector(clickHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnClick];
    
    
 
}
-(void)clickHome:(id)sender
{
    NSLog(@"点击按钮开始测试");
    LAContext *laContext = [[LAContext alloc]init];
    NSError *err = nil;
    //判断设备是否支持指纹识别
    BOOL isSupport = [laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err];
    if (isSupport) {
        NSLog(@"设备开启了指纹识别");
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"放置指纹" reply:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"成功开启");
            }
            else
            {
                NSLog(@"识别失败！原因是  %@",error);
            }
        }];
    }
    else
    {
        NSLog(@"设备不支持指纹识别，原因是 %@",err);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
