//
//  ViewController.m
//  Task6
//
//  Created by IvanLyuhtikov on 6/23/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "UIViewController+StatusBarOff.h"

#import "ViewController.h"
#import "Constants.h"
#import "MenuViewController.h"
#import "ShapeFabric.h"




@interface ViewController ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *startButton;

@property (strong, nonatomic) UIView *circleView;
@property (strong, nonatomic) UIView *rectangleView;
@property (strong, nonatomic) UIView *triangleView;

@property (strong, nonatomic) UIStackView *figureStackView;

@property (strong, nonatomic) NSLayoutConstraint *topTitleConstraint;
@property (strong, nonatomic) NSLayoutConstraint *topStartButtonConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHITE_COLOR;
    [self setupTitleLabel];
    
    self.circleView = [ShapeFabric createCircle];
    self.rectangleView = [ShapeFabric createRectangle];
    self.triangleView = [ShapeFabric createTriangle];
    
    [self setupStackView: @[self.circleView, self.rectangleView, self.triangleView]];
    
    [self setupButton];
    
    
    [self.startButton addTarget:self action:@selector(actionFunc) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
        [self animateFigures];
}


- (void)actionFunc {
    
    MenuViewController *tabBar = [[MenuViewController alloc] init];
    
    
    tabBar.view.backgroundColor = WHITE_COLOR;
    
    tabBar.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:tabBar animated:true completion:nil];
    
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    
    
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        self.topTitleConstraint.constant = 0;
        self.topStartButtonConstraint.constant = 70;
        
    } else {
        self.topTitleConstraint.constant = 100;
        self.topStartButtonConstraint.constant = UIScreen.mainScreen.bounds.size.height/3;
    }
}



//MARK: setupButton

- (void)setupButton {
    
    self.startButton = [[UIButton alloc] init];
    self.startButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    [self.startButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    self.startButton.backgroundColor = YELLOW_COLOR;
    self.startButton.layer.cornerRadius = 27.5;
    
    [self.view addSubview: self.startButton];
    
    
    //Layout
    
    [self.startButton.heightAnchor constraintEqualToConstant:55].active = true;
    self.topStartButtonConstraint = [self.startButton.topAnchor constraintEqualToAnchor:self.figureStackView.bottomAnchor constant:UIScreen.mainScreen.bounds.size.height/3];
    self.topStartButtonConstraint.active = YES;
    
    [self.startButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30].active = YES;
    [self.startButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-30].active = YES;
    
}



//MARK: setupStackView

- (void)setupStackView:(NSArray<UIView *> *)arrOfView {
    
    for (UIView *view in arrOfView) {
        [view.heightAnchor constraintEqualToConstant:70].active = true;
        [view.widthAnchor constraintEqualToConstant:70].active = true;
    }
    
    self.figureStackView = [[UIStackView alloc] initWithArrangedSubviews:arrOfView];
    
    self.figureStackView.axis = UILayoutConstraintAxisHorizontal;
    self.figureStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.figureStackView.alignment = UIStackViewAlignmentCenter;
    self.figureStackView.spacing = 20;
    
    self.figureStackView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.figureStackView];
    
    
    //Layout
    
    [NSLayoutConstraint activateConstraints:@[
        [self.figureStackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:30],
        [self.figureStackView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-30],
        [self.figureStackView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant: UIScreen.mainScreen.bounds.size.height/7]
    ]];
    
}


- (void)animateFigures {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    
    animation.fromValue = @0;
    animation.toValue = [NSNumber numberWithFloat:((360 * M_PI)/180)];
    animation.duration = 1;
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.triangleView.layer addAnimation:animation forKey:@"transform.rotation"];
    
    
    long value = self.view.frame.size.height - self.figureStackView.bounds.origin.y;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"position.y";
    animation2.fromValue = 0;
    animation2.toValue = [NSNumber numberWithLong:-value];
    animation2.duration = 1;
    animation2.repeatCount = CGFLOAT_MAX;
    
//    [self.rectangleView.layer addAnimation:animation2 forKey:@"basic"];
    
    
    CAKeyframeAnimation *squareAnimation = [CAKeyframeAnimation animation];
    squareAnimation.keyPath = @"position.y";
    squareAnimation.values = @[@0, [NSNumber numberWithFloat:UIScreen.mainScreen.bounds.size.height-self.figureStackView.frame.origin.y-self.circleView.frame.size.height], @0];
    squareAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    squareAnimation.keyTimes = @[@0, @0.50, @1];
    squareAnimation.duration = 1.5;
    squareAnimation.additive = YES;
    squareAnimation.repeatCount = CGFLOAT_MAX;
    
    [self.rectangleView.layer addAnimation:squareAnimation forKey:@"move"];
    
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animation];
    circleAnimation.keyPath = @"transform.scale";
    circleAnimation.duration = 0.9;
    circleAnimation.repeatCount = CGFLOAT_MAX;
    circleAnimation.fromValue = [NSNumber numberWithFloat:0.9];
    circleAnimation.toValue = [NSNumber numberWithFloat:1.1];
    [self.circleView.layer addAnimation:circleAnimation forKey:@"animateOpacity"];
    
    
    
}



//MARK: Label setup

- (void)setupTitleLabel {
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.titleLabel setFont: [UIFont fontWithName:@".SFUIText-Medium" size:24]];
    self.titleLabel.text = @"Are you ready?";
    [self.titleLabel sizeToFit];
    
    [self.view addSubview: self.titleLabel];
    
    [self setupTitleLabelAnchors];
}

- (void)setupTitleLabelAnchors {
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    [self.titleLabel.centerXAnchor constraintEqualToAnchor:margins.centerXAnchor constant:0].active = YES;
    self.topTitleConstraint = [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor constant:100];
    self.topTitleConstraint.active = true;
    
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
