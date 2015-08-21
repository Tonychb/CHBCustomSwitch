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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CHBSwitch *chbSwitch = [[CHBSwitch alloc]initWithFrame:CGRectMake(100, 100, 60, 30)];
    chbSwitch.tintColor = [UIColor redColor];
    chbSwitch.onTintColor = [UIColor blueColor];
    chbSwitch.thumbTintColor = [UIColor greenColor];
    chbSwitch.on = YES;
    //[chbSwitch setOn:NO animated:YES];
    //chbSwitch.switchStyle = CHBSwitchStyleSquare;
    [chbSwitch addTarget:self action:@selector(chbSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:chbSwitch];

    //UISwitch
    UISwitch *systemSwitch = [[UISwitch alloc]init];
    systemSwitch.center = self.view.center;
    systemSwitch.tintColor = [UIColor redColor];
    systemSwitch.onTintColor = [UIColor blueColor];
    systemSwitch.thumbTintColor = [UIColor clearColor];
    systemSwitch.on = YES;
    [systemSwitch addTarget:self action:@selector(systemSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:systemSwitch];
    
}

- (void)chbSwitchAction:(CHBSwitch *)sender {

    if (sender.isOn) {
        NSLog(@"开启");
    }else {
        NSLog(@"关闭");
    }
}

- (void)systemSwitchAction:(UISwitch *)sender {
    
    if (sender.isOn) {
        NSLog(@"systemSwitch开启");
    }else {
        NSLog(@"systemSwitch关闭");
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
