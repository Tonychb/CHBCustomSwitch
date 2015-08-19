//
//  CHBSwitch.h
//  CHBCustomSwitchDemo
//
//  Created by chenhuabao on 15/8/10.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHBSwitch : UIControl


@property(nonatomic, strong) UIColor *onTintColor;
@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, strong) UIColor *thumbTintColor;

@property(nonatomic, getter=isOn) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
