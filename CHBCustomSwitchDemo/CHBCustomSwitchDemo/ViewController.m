//
//  ViewController.m
//  CHBCustomSwitchDemo
//
//  Created by Tonychb on 15/8/7.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import "ViewController.h"
#import "CHBSwitch.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CHBSwitch *chbSwitch = [[CHBSwitch alloc]initWithFrame:CGRectMake(100, 100, 60, 30)];
    [self.view addSubview:chbSwitch];

    //UISwitch
    UISwitch *systemSwitch = [[UISwitch alloc]init];
    systemSwitch.center = self.view.center;
    [self.view addSubview:systemSwitch];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
