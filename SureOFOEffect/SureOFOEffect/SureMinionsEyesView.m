//
//  SureMinionsEyesView.m
//  SureOFOEffect
//
//  Created by 刘硕 on 2017/7/6.
//  Copyright © 2017年 刘硕. All rights reserved.
//

#import "SureMinionsEyesView.h"

@interface SureMinionsEyesView ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UIImageView *eyesImageView;
@end
@implementation SureMinionsEyesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.eyesImageView];
    }
    return self;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return _animator;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self createDynamic];
}

- (void)createDynamic {
    // 1.创建重力行为
    _gravity = [[UIGravityBehavior alloc] init];
    _gravity.gravityDirection = CGVectorMake(0, 1);
    [_gravity addItem:self.eyesImageView];
    
    // 2.创建碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.eyesImageView];
    
    // 添加边界
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    
    // 3.开始仿真
    [self.animator addBehavior:_gravity];
    [self.animator addBehavior:collision];
}

- (UIImageView*)eyesImageView {
    if (!_eyesImageView) {
        _eyesImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minions_eyes"]];
    }
    return _eyesImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _eyesImageView.frame = CGRectMake(0, 0, 50, 50);
    _eyesImageView.center = self.center;
}


@end
