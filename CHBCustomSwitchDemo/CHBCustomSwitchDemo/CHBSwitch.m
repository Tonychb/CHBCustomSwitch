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

//@property (nonatomic, strong) UIImageView *thumbImageView;
//
//@property (nonatomic, strong) UIImageView *onInsideImageView;
//
//@property (nonatomic, strong) UIImageView *offInsideImageView;
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
- (void)setBackgroundViewBorderColor:(UIColor *)backgroundViewBorderColor{
    
    self.backgroundView.layer.borderColor = backgroundViewBorderColor.CGColor;
    
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    
    self.thumbView.backgroundColor = thumbTintColor;
}

- (void)setThumbShadowColor:(UIColor *)thumbShadowColor {
    
    self.thumbView.layer.shadowColor = thumbShadowColor.CGColor;
}

- (void)setOn:(BOOL)on {
    
    if (_on != on) {
        _on = on;
    }
    
    [self setOn:_on animated:NO];
    
}

#pragma mark - Private Methods 私有方法
- (void)setupSubControl {
    
    self.backgroundColor = [UIColor clearColor];
    //*****************背景视图*******************
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                           ];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.cornerRadius = 0.0;
    self.backgroundView.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
    self.backgroundView.layer.borderWidth = 1.5f;
    [self addSubview:self.backgroundView];
    
    //****************开关按钮视图******************
    CGFloat thumbViewWH =  self.frame.size.height - kInterval * 2;
    self.thumbView = [[UIView alloc]initWithFrame:CGRectMake(kInterval, kInterval, thumbViewWH, thumbViewWH)];
    self.thumbView.backgroundColor = [UIColor whiteColor];
    //圆角半径
    self.thumbView.layer.cornerRadius = 0.0;
    self.thumbView.layer.borderColor = RGBAColor(237, 237, 237, 1).CGColor;
    self.thumbView.layer.borderWidth = 0.5f;
    //阴影效果
    self.thumbView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.thumbView.layer.shadowRadius = 2.0;
    //阴影透明度，注意默认为0，如果设置阴影必须设置此属性
    self.thumbView.layer.shadowOpacity = 0.5;
    //阴影偏移量
    self.thumbView.layer.shadowOffset = CGSizeMake(0, 3);
    //阴影的形状
    self.thumbView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.thumbView.bounds cornerRadius:self.thumbView.layer.cornerRadius].CGPath;
    //子图层是否剪切图层边界，默认为NO
    self.thumbView.layer.masksToBounds = NO;
    [self addSubview:self.thumbView];
    
    //****************添加点击手势**************
    //开关按钮点击手势
    UITapGestureRecognizer *tapGestureOfThumbView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleThumbViewTap:)];
    tapGestureOfThumbView.delegate = self;
    [self.thumbView addGestureRecognizer:tapGestureOfThumbView];
    
    //开关按钮拖动手势
    UIPanGestureRecognizer *panGestureOfThumbView = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleThumbViewPan:)];
    panGestureOfThumbView.delegate = self;
    [self.thumbView addGestureRecognizer:panGestureOfThumbView];
    
    //当前控件添加点击手势
    UITapGestureRecognizer *tapGestureOfSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSelfTap:)];
    tapGestureOfSelf.delegate = self;
    [self addGestureRecognizer:tapGestureOfSelf];
    
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

#pragma mark - Event Response 事件响应
- (void)handleThumbViewTap:(UITapGestureRecognizer *)tap {
    
    //判断手势识别器的当前状态
    switch (tap.state) {
            
        case UIGestureRecognizerStateBegan:
            NSLog(@"手势开始！");
            break;
        case UIGestureRecognizerStateEnded:
            //获取当前开关状态，判断动画要向左移动还是向右移动
            if (self.isOn) {
                self.on = NO;
            } else {
                self.on = YES;
            }
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)handleThumbViewPan:(UIPanGestureRecognizer *)pan {
    
    //返回在横坐标上、纵坐标上拖动了多少像素
    CGPoint translationPoint = [pan translationInView:self.thumbView];
    
    NSLog(@"translationPoint:%@",NSStringFromCGPoint(translationPoint));
    
    //返回值就是拖动时X和Y轴上的速度，速度是矢量，有方向。
    CGPoint velocityPoint = [pan velocityInView:self.thumbView];
    
    NSLog(@"velocityPoint:%@",NSStringFromCGPoint(velocityPoint));
}

- (void)handleSelfTap:(UITapGestureRecognizer *)tap {
    
    //判断手势识别器的当前状态
    switch (tap.state) {
        case UIGestureRecognizerStateEnded:
            //获取当前开关状态，判断动画要向左移动还是向右移动
            if (self.isOn) {
                self.on = NO;
            } else {
                self.on = YES;
            }
            break;
            
        default:
            break;
    }
    
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    //判断是否需要动画操作
    if (animated) {
        
        
        
    } else {
        
        CGRect thumbFrame = self.thumbView.frame;
        if (on) {
            thumbFrame.origin.x = self.frame.size.width - (self.frame.size.height - kInterval * 2) - kInterval;
            self.thumbView.frame = thumbFrame;
            self.backgroundView.backgroundColor = RGBAColor(0, 210, 0, 1);
            self.backgroundView.layer.borderColor = RGBAColor(0, 210, 0, 1).CGColor;
        } else {
            thumbFrame.origin.x = kInterval;
            self.thumbView.frame = thumbFrame;
            self.backgroundView.backgroundColor = [UIColor whiteColor];
            self.backgroundView.layer.borderColor = RGBAColor(225, 225, 225, 1).CGColor;
        }
        
    }
    
    
}





@end
