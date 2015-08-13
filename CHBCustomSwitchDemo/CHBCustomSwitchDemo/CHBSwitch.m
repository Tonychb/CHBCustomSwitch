//
//  CHBSwitch.m
//  CHBCustomSwitchDemo
//
//  Created by chenhuabao on 15/8/10.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import "CHBSwitch.h"

#define RGBAColor(R, G, B, A)   [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A]

static const CGFloat kInterval = 1.5f;



@interface CHBSwitch ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIView *thumbView;

@property (nonatomic, strong) UIImageView *onInsideImageView;

@property (nonatomic, strong) UIImageView *offInsideImageView;

@property (nonatomic, assign) CGPoint beganLocation;

@property (nonatomic, assign) CGFloat thumbViewCenterXY;


//@property (nonatomic, strong) UIImageView *thumbImageView;
//
//@property (nonatomic, strong) UILabel *onInsideLabel;
//
//@property (nonatomic, strong) UILabel *offInsideLabel;
//
//@property (nonatomic, assign) BOOL switchValue;
//
//@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation CHBSwitch

@synthesize on = _on;


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubControl];
    }
    return self;
}



#pragma mark - Getters And Setters
#pragma mark get方法
- (BOOL)isOn {
    
    return _on;
}

#pragma mark set方法
- (void)setOn:(BOOL)on {
    
    [self setOn:on animated:NO];
    
}

#pragma mark - Private Methods 私有方法
- (void)setupSubControl {
    
    self.backgroundColor = [UIColor clearColor];
    
    //*****************背景视图*******************
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.layer.cornerRadius = self.frame.size.height * 0.5;
    self.backgroundView.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
    self.backgroundView.layer.borderWidth = 1.5f;
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    [self sendSubviewToBack:self.backgroundView];
    
    //*****************开时内部图像视图*******************
    self.onInsideImageView = [[UIImageView alloc]initWithFrame:self.backgroundView.bounds];
    self.onInsideImageView.backgroundColor = RGBAColor(225, 225, 225, 1);
    self.onInsideImageView.contentMode = UIViewContentModeCenter;
    self.onInsideImageView.hidden = YES;
    self.onInsideImageView.layer.cornerRadius = self.frame.size.height * 0.5;
    [self.backgroundView addSubview:self.onInsideImageView];
    
    //*****************关时内部图像视图*******************
    self.offInsideImageView = [[UIImageView alloc]initWithFrame:self.backgroundView.bounds];
    self.offInsideImageView.backgroundColor = [UIColor whiteColor];
    self.offInsideImageView.contentMode = UIViewContentModeCenter;
    self.offInsideImageView.hidden = YES;
    self.offInsideImageView.layer.cornerRadius = self.frame.size.height * 0.5;
    [self.backgroundView addSubview:self.offInsideImageView];
    
    //****************开关按钮视图******************
    CGFloat thumbViewWH =  self.frame.size.height - kInterval * 2;
    self.thumbView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, thumbViewWH, thumbViewWH)];
    _thumbViewCenterXY = kInterval + thumbViewWH * 0.5;
    self.thumbView.backgroundColor = [UIColor whiteColor];
    //圆角半径
    self.thumbView.layer.cornerRadius = thumbViewWH * 0.5;
    self.thumbView.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
    self.thumbView.layer.borderWidth = 0.5f;
    //阴影效果
    self.thumbView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.thumbView.layer.shadowRadius = 1.0;
    //阴影透明度，注意默认为0，如果设置阴影必须设置此属性
    self.thumbView.layer.shadowOpacity = 0.3;
    //阴影偏移量
    self.thumbView.layer.shadowOffset = CGSizeMake(0, 2);
    //阴影的形状
    self.thumbView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.thumbView.bounds cornerRadius:self.thumbView.layer.cornerRadius].CGPath;
    //子图层是否剪切图层边界，默认为NO
    //self.thumbView.layer.masksToBounds = YES;
    //self.thumbView.userInteractionEnabled = NO;
    [self addSubview:self.thumbView];
    [self bringSubviewToFront:self.thumbView];
    
    //******************添加手势*************************
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(disposeThumbViewPanGesture:)];
    panGesture.delegate = self;
    [self.thumbView addGestureRecognizer:panGesture];
    
    //默认开关状态是关闭的
    self.on = NO;
    
}

#pragma mark 设置开关动画
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    if (_on != on){
        _on = on;
    }
    
    
    
    //判断是否需要动画操作
    if (animated) {
        
        if (on) {//开启操作
            self.thumbView.center = CGPointMake(self.frame.size.width - _thumbViewCenterXY, self.frame.size.height - _thumbViewCenterXY);
            self.backgroundView.backgroundColor = RGBAColor(0, 220, 0, 1);
            self.backgroundView.layer.borderColor = RGBAColor(0, 220, 0, 1).CGColor;
            self.onInsideImageView.hidden = YES;
            self.offInsideImageView.hidden = YES;
            
        } else {//关闭操作
            self.thumbView.center = CGPointMake(_thumbViewCenterXY, _thumbViewCenterXY);
            self.backgroundView.backgroundColor = [UIColor whiteColor];
            self.backgroundView.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
            
            //************offInsideImageView放大到显示**************
            self.offInsideImageView.hidden = NO;
            self.onInsideImageView.hidden = NO;
            // 设定为缩放
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            // 动画选项设定
            animation.duration = 0.2; // 动画持续时间
            animation.repeatCount = 1; // 重复次数
            animation.autoreverses = NO; // 动画结束时执行逆动画
            // 缩放倍数
            animation.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的倍率
            animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
            // 动画终了后不返回初始状态
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            // 添加动画
            [self.offInsideImageView.layer addAnimation:animation forKey:@"offInsideImageViewLayer"];
            
        }
        
    } else {
        
        if (on) {//开启操作
            self.thumbView.center = CGPointMake(self.frame.size.width - _thumbViewCenterXY, self.frame.size.height - _thumbViewCenterXY);
            self.backgroundView.backgroundColor = RGBAColor(0, 220, 0, 1);
            self.backgroundView.layer.borderColor = RGBAColor(0, 220, 0, 1).CGColor;
            self.onInsideImageView.hidden = YES;
            self.offInsideImageView.hidden = YES;
            
        } else {//关闭操作
            self.thumbView.center = CGPointMake(_thumbViewCenterXY, _thumbViewCenterXY);
            self.backgroundView.backgroundColor = [UIColor whiteColor];
            self.backgroundView.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
            
            //************offInsideImageView放大到显示**************
            self.offInsideImageView.hidden = NO;
            self.onInsideImageView.hidden = NO;
            // 设定为缩放
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            // 动画选项设定
            animation.duration = 0.2; // 动画持续时间
            animation.repeatCount = 1; // 重复次数
            animation.autoreverses = NO; // 动画结束时执行逆动画
            // 缩放倍数
            animation.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的倍率
            animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
            // 动画终了后不返回初始状态
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            // 添加动画
            [self.offInsideImageView.layer addAnimation:animation forKey:@"offInsideImageViewLayer"];
            
        }
        
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


#pragma mark - Event Response 事件响应
#pragma mark 手势响应
- (void)disposeThumbViewPanGesture:(UIPanGestureRecognizer *)pan {

    
}

#pragma mark 触摸响应事件
#pragma mark (一根或多根手指开始触摸屏幕时执行)
- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //    for (UITouch *touch in touches) {
    //        NSLog(@"touch-->:%@",touch);
    //    }
    //
    //    NSLog(@"event-->:%@",event);
    
    //获取在self上的位置
    _beganLocation = [[touches anyObject] locationInView:self];
    NSLog(@"beganLocation-->:%@",NSStringFromCGPoint(_beganLocation));

    
    
    if (!self.isOn) {
        
        //************offInsideImageView缩小到消失,显示出onInsideImageView**************
        self.offInsideImageView.hidden = NO;
        self.onInsideImageView.hidden = NO;
        // 设定为缩放
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        // 动画选项设定
        animation.duration = 0.2; // 动画持续时间
        animation.repeatCount = 1; // 重复次数
        animation.autoreverses = NO; // 动画结束时执行逆动画
        // 缩放倍数
        animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
        animation.toValue = [NSNumber numberWithFloat:0.0]; // 结束时的倍率
        // 动画终了后不返回初始状态
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        // 添加动画
        [self.offInsideImageView.layer addAnimation:animation forKey:@"offInsideImageViewLayer"];
        
    }
    
}

#pragma mark (一根或多根手指在屏幕上移动时执行，注意此方法在移动过程中会重复调用)
- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    NSLog(@"触摸移动！");
    
    CGPoint currentLocation = [[touches anyObject] locationInView:self];
    //移动偏移量
    CGPoint moveOffset = CGPointMake(_beganLocation.x - currentLocation.x, _beganLocation.y - currentLocation.y);
    //向左移动X坐标为正数，向右移动X坐标为负数,向上移动Y坐标为正数，向下移动Y坐标为负数
    NSLog(@"moveOffset-->%@",NSStringFromCGPoint(moveOffset));
    
    
    
}

#pragma mark (一根或多根手指触摸结束离开屏幕时执行)
- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //获取当前开关状态，判断动画要向左移动还是向右移动
    if (self.isOn) {
        [self setOn:NO animated:YES];
    } else {
        [self setOn:YES animated:YES];
        
    }

}

#pragma mark --触摸意外取消时执行(例如正在触摸时打入电话)
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    
}



@end
