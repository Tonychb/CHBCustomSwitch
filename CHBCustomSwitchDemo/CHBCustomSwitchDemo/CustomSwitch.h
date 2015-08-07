//
//  CustomSwitch.h
//  CHBCustomSwitchDemo
//
//  Created by chenhuabao on 15/8/7.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSwitch : UIView

/**
 *  Target-Action回调模式,方法用于注册目标动作，也就是说目标对象和目标对象的方法是通过这个方法传入到组件中的
 *
 *  @param target 用于接收Controler的对象，也就是要回调的目标对象。
 *  @param action 用于接收目标对象的方法，也就是要在目标对象中要回调的方法
 */
- (void)addTarget:(id)target action:(SEL)action;

@end
