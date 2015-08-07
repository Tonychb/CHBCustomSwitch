//
//  CustomSwitch.m
//  CHBCustomSwitchDemo
//
//  Created by chenhuabao on 15/8/7.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import "CustomSwitch.h"

@interface CustomSwitch ()

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL action;

@end

@implementation CustomSwitch


/**
 *  Target-Action回调模式,方法用于注册目标动作，也就是说目标对象和目标对象的方法是通过这个方法传入到组件中的
 *
 *  @param target 用于接收Controler的对象，也就是要回调的目标对象。
 *  @param action 用于接收目标对象的方法，也就是要在目标对象中要回调的方法
 */
- (void)addTarget:(id)target action:(SEL)action {
    
    self.target = target;
    
    self.action = action;

}

#pragma mark - UIView触摸事件

#pragma mark 当触摸开始时会调用下面的事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    

    
    

}

#pragma mark 当触摸取消时会调用下面的事件
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

}

#pragma mark 当触摸结束时会调用下面的事件
- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    //当UIView点击结束时，如果结束点在UIView区域中执行action方法
    
    //获取触摸对象
    UITouch *touche = [touches anyObject];
    
    //获取touche的位置
    CGPoint touchePoint = [touche locationInView:self];
    
    //判断点是否在当前UIView中
    if (CGRectContainsPoint(self.bounds, touchePoint)) {
        //执行action
        [self.target performSelector:self.action withObject:self];
    }
}


#pragma mark 当触摸移动时会调用下面的事件
- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

}


@end
