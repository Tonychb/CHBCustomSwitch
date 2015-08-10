//
//  CHBSwitch.m
//  CHBCustomSwitchDemo
//
//  Created by chenhuabao on 15/8/10.
//  Copyright © 2015年 Tonychb. All rights reserved.
//

#import "CHBSwitch.h"

@interface CHBSwitch ()

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIView *thumbView;

@property (nonatomic, strong) UIImageView *thumbImageView;

@property (nonatomic, strong) UIImageView *onInsideImageView;

@property (nonatomic, strong) UIImageView *offInsideImageView;

@property (nonatomic, strong) UILabel *onInsideLabel;

@property (nonatomic, strong) UILabel *offInsideLabel;

@property (nonatomic, assign) BOOL switchValue;

@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation CHBSwitch

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubControl];
    }
    return self;
}



#pragma mark - Getters And Setters
#pragma mark get方法
- (BOOL)isOn {

    return self.switchValue;
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

    self.switchValue = on;
    [self setOn:on animated:NO];
}

#pragma mark - Private Methods 私有方法
- (void)setupSubControl {
    
    
    //背景视图
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                           ];
    self.backgroundView.backgroundColor = [UIColor yellowColor];
    //self.backgroundView.layer.cornerRadius = self.frame.size.height * 0.5;
    self.backgroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backgroundView.layer.borderWidth = 1.0;
    self.backgroundView.userInteractionEnabled = NO;
    self.backgroundView.clipsToBounds = YES;
    [self addSubview:self.backgroundView];
    
    //开和关的内部图像视图
    CGFloat insideContentWidth = self.frame.size.width - self.frame.size.height;
    CGFloat insideContentHeight = self.frame.size.height;
    
    self.onInsideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, insideContentWidth, insideContentHeight)];
    self.onInsideImageView.contentMode = UIViewContentModeCenter;
    [self.backgroundView addSubview:self.onInsideImageView];
    
    self.offInsideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(insideContentHeight, 0, insideContentWidth, insideContentHeight)];
    self.offInsideImageView.contentMode = UIViewContentModeCenter;
    [self.backgroundView addSubview:self.offInsideImageView];
    
    //开和关的内部标签视图
    self.onInsideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, insideContentWidth, insideContentHeight)];
    self.onInsideLabel.textAlignment = NSTextAlignmentCenter;
    self.onInsideLabel.textColor = [UIColor lightGrayColor];
    self.onInsideLabel.font = [UIFont systemFontOfSize:12];
    [self.backgroundView addSubview:self.onInsideLabel];
    
    self.offInsideLabel = [[UILabel alloc]initWithFrame:CGRectMake(insideContentHeight, 0, insideContentWidth, insideContentHeight)];
    self.offInsideLabel.textAlignment = NSTextAlignmentCenter;
    self.offInsideLabel.textColor = [UIColor lightGrayColor];
    self.offInsideLabel.font = [UIFont systemFontOfSize:12];
    [self.backgroundView addSubview:self.offInsideLabel];
    
    //开关按钮视图
    CGFloat interval = 1.0;
    self.thumbView = [[UIView alloc]initWithFrame:CGRectMake(interval, interval, insideContentHeight - interval * 2, insideContentHeight - interval * 2)];
    self.thumbView.backgroundColor = [UIColor whiteColor];
    //圆角半径
    //self.thumbView.layer.cornerRadius = CGRectGetHeight(self.thumbView.frame) * 0.5;
    self.thumbView.layer.cornerRadius = 0.0;
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
    self.thumbView.userInteractionEnabled = NO;
    
    //开关按钮图像视图
    self.thumbImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.thumbView.frame), CGRectGetHeight(self.thumbView.frame))];
    self.thumbImageView.contentMode = UIViewContentModeCenter;
    [self.thumbView addSubview:self.thumbImageView];
    
    self.on = NO;
    
}

- (void)showOnWithAnimated:(BOOL)animated {

    if (animated) {
        
        _isAnimating = YES;
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            
            
        } completion:^(BOOL finished) {
            _isAnimating = NO;
        }];
        
    } else {
        
    }
    
}

#pragma mark - Event Response 事件响应
- (void)setOn:(BOOL)on animated:(BOOL)animated {

    self.switchValue = on;
    
    if (self.on) {
        
        [self showOnWithAnimated:animated];
        
        
    } else {
        
    }
    
}





@end
