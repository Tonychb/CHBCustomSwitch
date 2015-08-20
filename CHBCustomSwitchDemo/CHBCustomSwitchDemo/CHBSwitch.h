//
//  CHBSwitch.h
//  CHBCustomSwitchDemo
//
//  Created by chenhuabao on 15/8/10.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  开关控件的样式
 */
typedef NS_ENUM(NSUInteger, CHBSwitchStyle){
    /**
     *  圆形(默认)
     */
    CHBSwitchStyleCircle = 1,
    /**
     *  方形
     */
    CHBSwitchStyleSquare
};

@interface CHBSwitch : UIControl

/**
 *  开启时的整个视图的着色
 */
@property(nonatomic, strong) UIColor *onTintColor;
/**
 *  关闭时的内部背景颜色
 */
@property(nonatomic, strong) UIColor *offInternalBackgroundColor;
/**
 *  整个视图的着色
 */
@property(nonatomic, strong) UIColor *tintColor;
/**
 *  开关按钮颜色
 */
@property(nonatomic, strong) UIColor *thumbTintColor;

@property(nonatomic, assign) CHBSwitchStyle switchStyle;

@property(nonatomic, getter=isOn) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
