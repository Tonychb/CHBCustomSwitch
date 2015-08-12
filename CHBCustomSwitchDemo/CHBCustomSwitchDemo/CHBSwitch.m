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


@property (nonatomic, strong) UIView *thumbView;

@property (nonatomic, strong) UIImageView *onInsideImageView;

@property (nonatomic, strong) UIImageView *offInsideImageView;

@property (nonatomic, assign) BOOL isTouchThumbView;

@property (nonatomic, assign) CGPoint beganLocationInThumbView;

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
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 0.0;
    self.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
    self.layer.borderWidth = 1.5f;
    self.userInteractionEnabled = YES;
    //*****************开时内部图像视图*******************
    self.onInsideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                              ];
    self.onInsideImageView.backgroundColor = RGBAColor(225, 225, 225, 1);
    self.onInsideImageView.contentMode = UIViewContentModeCenter;
    self.onInsideImageView.hidden = YES;
    [self addSubview:self.onInsideImageView];
    
    //*****************关时内部图像视图*******************
    self.offInsideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                               ];
    self.offInsideImageView.backgroundColor = [UIColor whiteColor];
    self.offInsideImageView.contentMode = UIViewContentModeCenter;
    self.offInsideImageView.hidden = YES;
    [self addSubview:self.offInsideImageView];
    
    //****************开关按钮视图******************
    CGFloat thumbViewWH =  self.frame.size.height - kInterval * 2;
    self.thumbView = [[UIView alloc]initWithFrame:CGRectMake(kInterval, kInterval, thumbViewWH, thumbViewWH)];
    self.thumbView.backgroundColor = [UIColor whiteColor];
    //圆角半径
    self.thumbView.layer.cornerRadius = 0.0;
    self.thumbView.layer.borderColor = RGBAColor(237, 237, 237, 1).CGColor;
    self.thumbView.layer.borderWidth = 1.0f;
    //阴影效果
    self.thumbView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.thumbView.layer.shadowRadius = 2.0;
    //阴影透明度，注意默认为0，如果设置阴影必须设置此属性
    self.thumbView.layer.shadowOpacity = 0.5;
    //阴影偏移量
    self.thumbView.layer.shadowOffset = CGSizeMake(0, 2);
    //阴影的形状
    self.thumbView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.thumbView.bounds cornerRadius:self.thumbView.layer.cornerRadius].CGPath;
    //子图层是否剪切图层边界，默认为NO
    //self.thumbView.layer.masksToBounds = YES;
    //self.thumbView.userInteractionEnabled = NO;
    [self addSubview:self.thumbView];
    
    
    //默认开关状态是关闭的
    self.on = NO;
    
    //    //开和关的内部图像视图
    //    self.onInsideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, insideContentWidth, insideContentHeight)];
    //    self.onInsideImageView.contentMode = UIViewContentModeCenter;
    //    [self.backgroundView addSubview:self.onInsideImageView];
    //
    //    self.offInsideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(insideContentHeight, 0, insideContentWidth, insideContentHeight)];
    //    self.offInsideImageView.contentMode = UIViewContentModeCenter;
    //    [self.backgroundView addSubview:self.offInsideImageView];
    //
    //    //开和关的内部标签视图
    //    self.onInsideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, insideContentWidth, insideContentHeight)];
    //    self.onInsideLabel.textAlignment = NSTextAlignmentCenter;
    //    self.onInsideLabel.textColor = [UIColor lightGrayColor];
    //    self.onInsideLabel.font = [UIFont systemFontOfSize:12];
    //    [self.backgroundView addSubview:self.onInsideLabel];
    //
    //    self.offInsideLabel = [[UILabel alloc]initWithFrame:CGRectMake(insideContentHeight, 0, insideContentWidth, insideContentHeight)];
    //    self.offInsideLabel.textAlignment = NSTextAlignmentCenter;
    //    self.offInsideLabel.textColor = [UIColor lightGrayColor];
    //    self.offInsideLabel.font = [UIFont systemFontOfSize:12];
    //    [self.backgroundView addSubview:self.offInsideLabel];
    
    
    
    //    //开关按钮图像视图
    //    self.thumbImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.thumbView.frame), CGRectGetHeight(self.thumbView.frame))];
    //    self.thumbImageView.contentMode = UIViewContentModeCenter;
    //    [self.thumbView addSubview:self.thumbImageView];
    
    
}

#pragma mark 设置开关动画
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    if (_on != on){
        _on = on;
    }
    
    
    
    //判断是否需要动画操作
    if (animated) {
        
        CGRect thumbFrame = self.thumbView.frame;
        if (on) {//开启操作
            thumbFrame.origin.x = self.frame.size.width - (self.frame.size.height - kInterval * 2) - kInterval;
            self.thumbView.frame = thumbFrame;
            self.backgroundColor = RGBAColor(0, 220, 0, 1);
            self.layer.borderColor = RGBAColor(0, 220, 0, 1).CGColor;
            self.onInsideImageView.hidden = YES;
            self.offInsideImageView.hidden = YES;
            
        } else {//关闭操作
            thumbFrame.origin.x = kInterval;
            self.thumbView.frame = thumbFrame;
            self.backgroundColor = [UIColor whiteColor];
            self.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
            self.onInsideImageView.hidden = YES;
            self.offInsideImageView.hidden = YES;
            
        }
        
        
    } else {
        
        CGRect thumbFrame = self.thumbView.frame;
        if (on) {//开启操作
            thumbFrame.origin.x = self.frame.size.width - (self.frame.size.height - kInterval * 2) - kInterval;
            self.thumbView.frame = thumbFrame;
            self.backgroundColor = RGBAColor(0, 220, 0, 1);
            self.layer.borderColor = RGBAColor(0, 220, 0, 1).CGColor;
            self.onInsideImageView.hidden = YES;
            self.offInsideImageView.hidden = YES;
            
        } else {//关闭操作
            thumbFrame.origin.x = kInterval;
            self.thumbView.frame = thumbFrame;
            self.backgroundColor = [UIColor whiteColor];
            self.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
            self.onInsideImageView.hidden = YES;
            self.offInsideImageView.hidden = YES;
            
        }
        
    }
    
    
}


#pragma mark - Event Response 事件响应

#pragma mark 触摸响应事件
#pragma mark (一根或多根手指开始触摸屏幕时执行)
- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //    for (UITouch *touch in touches) {
    //        NSLog(@"touch-->:%@",touch);
    //    }
    //
    //    NSLog(@"event-->:%@",event);
    
    //判断开始触摸的是否thumbView
    UITouch *touch = [touches anyObject];
    UIView *tempView = touch.view;
    
    if (tempView == self.thumbView) {
        _isTouchThumbView = YES;
        //获取在ThumbView上的位置
        _beganLocationInThumbView = [touch locationInView:self.thumbView];
        NSLog(@"_beganLocationInThumbView-->: %@",NSStringFromCGPoint(_beganLocationInThumbView));
    }else {
        _isTouchThumbView = NO;
    }

    
    if (self.isOn) {
        
    } else {
        
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
    
    if (_isTouchThumbView) {
        
        
        CGPoint currentLocationInThumbView = [[touches anyObject] locationInView:self.thumbView];
        //移动偏移量
        CGPoint moveOffset = CGPointMake(_beganLocationInThumbView.x - currentLocationInThumbView.x, _beganLocationInThumbView.y - currentLocationInThumbView.y);
        
        
        if (self.isOn) {
            
        } else {
            //************offInsideImageView放大到显示**************
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
        
    }
    
}

#pragma mark (一根或多根手指触摸结束离开屏幕时执行)
- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //获取当前开关状态，判断动画要向左移动还是向右移动
    if (self.isOn) {
        [self setOn:NO animated:YES];
    } else {
        [self setOn:YES animated:YES];
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark --触摸意外取消时执行(例如正在触摸时打入电话)
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    
}



@end
