//
//  ViewController.m
//  CHBCustomSwitchDemo
//
//  Created by Tonychb on 15/8/7.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import "ViewController.h"
#import "CustomSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CustomSwitch *customSwitch = [[CustomSwitch alloc]initWithFrame:CGRectMake(150, 200, 100, 40)];
    customSwitch.center = self.view.center;
    customSwitch.backgroundColor = [UIColor yellowColor];
    [customSwitch addTarget:self action:@selector(customSwitch:)];
    [self.view addSubview:customSwitch];
    
    UISwitch *systemSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMinX(customSwitch.frame), CGRectGetMaxY(customSwitch.frame) + 20, CGRectGetWidth(customSwitch.frame), CGRectGetHeight(customSwitch.frame))];
    //systemSwitch.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:systemSwitch];

    
}

- (void)customSwitch:(id)sender {

    NSLog(@"自定义点击!");
    NSLog(@"%@",sender);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
