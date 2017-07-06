//
//  ViewController.m
//  SureOFOEffect
//
//  Created by 刘硕 on 2017/7/6.
//  Copyright © 2017年 刘硕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong)  UIGravityBehavior *gravity;
@property (weak, nonatomic) IBOutlet UIImageView *minionsEyesView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createDynamic];
    
    [self createView];
}
- (IBAction)left:(id)sender {
    _gravity.gravityDirection = CGVectorMake(-1, 0);
    [_animator addBehavior:_gravity];
}
- (IBAction)right:(id)sender {
    _gravity.gravityDirection = CGVectorMake(1, 0);
    [_animator addBehavior:_gravity];
}
- (IBAction)top:(id)sender {
    _gravity.gravityDirection = CGVectorMake(0, -1);
    [_animator addBehavior:_gravity];
}
- (IBAction)bottom:(id)sender {
    _gravity.gravityDirection = CGVectorMake(0, 1);
    [_animator addBehavior:_gravity];
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)createDynamic {
    // 1.创建重力行为
    _gravity = [[UIGravityBehavior alloc] init];
    [_gravity addItem:self.minionsEyesView];
    
    // 2.创建碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.minionsEyesView];
    
    // 添加边界
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.width)];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    
    // 3.开始仿真
    [self.animator addBehavior:_gravity];
    [self.animator addBehavior:collision];
}

- (void)createView {
    UIView *ovalView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width,  self.view.frame.size.width)];
    ovalView.backgroundColor = [UIColor clearColor];
    ovalView.layer.borderColor = [UIColor blackColor].CGColor;
    ovalView.layer.borderWidth = 1;
    ovalView.layer.cornerRadius = self.view.frame.size.width / 2;
    [self.view addSubview:ovalView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
