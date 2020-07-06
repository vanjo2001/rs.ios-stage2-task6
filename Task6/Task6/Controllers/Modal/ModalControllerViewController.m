//
//  ModalControllerViewController.m
//  Task6
//
//  Created by IvanLyuhtikov on 7/2/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "ModalControllerViewController.h"
#import "AnchorDragView.h"
#import "Constants.h"




@interface ModalControllerViewController ()

typedef enum: NSUInteger {
    
    ModalVCStateOpen        = 0,
    ModalVCStateClose       = 1,
    
} ModalVCState;

@property (nonatomic, strong) AnchorDragView *top;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) NSMutableArray<UIViewPropertyAnimator *> *animations;
@property (nonatomic, assign) ModalVCState current;
@property (nonatomic, assign) CGFloat animationProgress;

@end

@implementation ModalControllerViewController


- (void)loadView {
    [super loadView];
    
    if (@available(iOS 13, *)) {
        
    } else {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        view.layer.cornerRadius = 20;
        view.layer.masksToBounds = YES;
        
        self.view = view;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (@available(iOS 13, *)) {
        
        
    } else {
        
        self.current = ModalVCStateOpen;
        self.top = [[AnchorDragView alloc] init];
        [self.view addSubview:self.top];
        
        self.top.translatesAutoresizingMaskIntoConstraints = NO;
        self.top.view.backgroundColor = YELLOW_COLOR;
        
        self.panGesture = [UIPanGestureRecognizer new];
        [self.panGesture addTarget:self action:@selector(panGestureHandle:)];
        [self.top.drag addGestureRecognizer:self.panGesture];
        [self setupAnimator];
        
    }
    
    [self setupImageView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (@available(iOS 13, *)) {
        
    } else {
        self.view.frame = CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-50);
        
        [self.top.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0].active = YES;
        [self.top.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
        [self.top.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    }
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    } else {
        
    }
}



- (ModalVCState)changeCurrentState {
    return self.current = self.current == ModalVCStateOpen ? ModalVCStateClose : ModalVCStateOpen;
}

- (void)setupImageView {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.imageView];
    
    if (@available(iOS 13, *)) {
        
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
        
        
    } else {
        self.imageView.backgroundColor = WHITE_COLOR;
        
        
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
        [self.imageView.topAnchor constraintEqualToAnchor:self.top.topAnchor constant:50].active = YES;
    }
    
    [self.imageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [self.imageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
//    [self.imageView.heightAnchor constraintEqualToConstant:200].active = YES;
    
    
    self.imageView.image = [UIImage imageNamed:@"field"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
}


- (void)setupAnimator {
    self.animations = [NSMutableArray new];
}


- (void)panGestureHandle: (UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.top.drag];
    CGFloat fractionComplete = 0;
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        fractionComplete = translation.y / (self.view.frame.size.height * SCREEN_HEIGHT/SCREEN_WIDTH/1.6);
        fractionComplete = (self.current == ModalVCStateOpen) ? fractionComplete : -fractionComplete;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self startInteractionTransition:self.current animationDuration:0.5];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:fractionComplete];
            break;
        case UIGestureRecognizerStateEnded:
            [self continueInteractiveTransition];
            break;
        default:
            break;
    }
}

- (void)animateTransitionIfNeeded: (ModalVCState)state animateDuration:(NSTimeInterval)duration {
    if (self.animations.count == 0) {
        UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc]
                                            initWithDuration:duration
                                            dampingRatio:1
                                            animations:^{
            
            switch (state) {
                case ModalVCStateClose:
                    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                    break;
                default:
                    self.view.frame = CGRectMake(0, self.view.frame.size.height*SCREEN_HEIGHT/SCREEN_WIDTH/1.6, self.view.frame.size.width, self.view.frame.size.height);
                    break;
            }
        }];
        
        [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
            [self changeCurrentState];
            [self.animations removeAllObjects];
        }];
        
        [animator startAnimation];
        [self.animations addObject:animator];
    }
}


- (void)startInteractionTransition: (ModalVCState)state animationDuration:(NSTimeInterval)duration {
    if (self.animations.count == 0) {
        [self animateTransitionIfNeeded:state animateDuration:duration];
    }
    
    for (UIViewPropertyAnimator *animation in self.animations) {
        [animation pauseAnimation];
    }
}

- (void)updateInteractiveTransition: (CGFloat)fractionCompleted {
    for (UIViewPropertyAnimator *animation in self.animations) {
        animation.fractionComplete = fractionCompleted;
        self.animationProgress = fractionCompleted;
    }
}

- (void)continueInteractiveTransition {
    
    
    if (self.animationProgress < 0.3 && self.current == ModalVCStateOpen) {
        
        UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc]
                                            initWithDuration:0.5
                                            dampingRatio:1
                                            animations:^{
            
            self.view.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height);
            
        }];
        
        [self.animations removeAllObjects];
        
        [animator startAnimation];
        [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
            [self changeCurrentState];
        }];
        [self.animations addObject:animator];
    
    }
    
    for (UIViewPropertyAnimator *animation in self.animations) {
        [animation continueAnimationWithTimingParameters:nil durationFactor:0];
        
        [animation addCompletion:^(UIViewAnimatingPosition finalPosition) {
            if (self.current == ModalVCStateClose)
                [self dismissViewControllerAnimated:true completion:nil];
        }];
    }
    
//    if (self.current == closeModal) {
//        [self dismissViewControllerAnimated:true completion:nil];
//    }
}


@end
