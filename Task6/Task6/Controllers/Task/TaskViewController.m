//
//  TaskViewController.m
//  Task6
//
//  Created by IvanLyuhtikov on 6/24/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "TaskViewController.h"
#import "ShapeFabric.h"
#import "Constants.h"
#import "sys/utsname.h"

@interface TaskViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *appleLogo;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIButton *gitButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (strong, nonatomic) NSArray *arrOfString;


@property (strong, nonatomic) NSLayoutConstraint *topGitButton;
@property (strong, nonatomic) NSLayoutConstraint *topStartButton;
@property (strong, nonatomic) NSLayoutConstraint *topTopLineViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint *topBottomLineViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appleHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appleWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appleTopConstraint;

@property (strong, nonatomic) UIStackView *stackViewShapes;


//iPhone 5-5s CONSTRAINTS

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appleLogoLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineTrailing;

@property (strong, nonatomic) NSLayoutConstraint *stackViewLeading;
@property (strong, nonatomic) NSLayoutConstraint *stackViewTrailing;

@property (strong, nonatomic) NSLayoutConstraint *bottomLineLeading;
@property (strong, nonatomic) NSLayoutConstraint *bottomLineTrailing;

@property (strong, nonatomic) NSLayoutConstraint *gitButtonLeading;
@property (strong, nonatomic) NSLayoutConstraint *gitButtonTrailing;

@property (strong, nonatomic) NSLayoutConstraint *startButtonLeading;
@property (strong, nonatomic) NSLayoutConstraint *startButtonTrailing;



@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"RSSchool Task 6";
    
    UIDevice *current = [UIDevice currentDevice];
    
    NSString *name = current.name;
    NSString *type = current.model;
    NSString *version = current.systemVersion;
    
    self.arrOfString = @[name, type, version];
    
    [self setupLabels];
    
    [self setupStackView:@[[ShapeFabric createCircle], [ShapeFabric createRectangle], [ShapeFabric createTriangle]]];
    
    [self setupBottomLineView];
    
    [self setupButtons];
    
    [self checkiOS:[UIDevice currentDevice].systemVersion];
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        
        self.stackView.axis = UILayoutConstraintAxisHorizontal;
        
        self.topTopLineViewConstraint.constant = 0;
        self.topBottomLineViewConstraint.constant = 0;
        
        self.topGitButton.constant = 10;
        self.topStartButton.constant = 10;
        
        if (ABS(SCREEN_HEIGHT - SCREEN_WIDTH) == 248) {
            self.appleWidthConstraint.constant = 35;
            self.appleHeightConstraint.constant = 35;
            self.stackView.spacing = 5;


            self.appleLogoLeading.constant = 20;
            self.topLineLeading.constant = 20;
            self.topLineTrailing.constant = 20;
            self.stackViewLeading.constant = 20;
            self.stackViewTrailing.constant = -20;
            self.bottomLineLeading.constant = 20;
            self.bottomLineTrailing.constant = -20;
            
            self.gitButtonTrailing.constant = -SCREEN_WIDTH/2;
            self.startButtonLeading.constant = SCREEN_WIDTH/2;
            self.topStartButton.constant = -self.startButton.bounds.size.height;
            
            return;
        }
        
        self.appleHeightConstraint.constant = 50;
        self.appleWidthConstraint.constant = 50;
        
        
    } else {
        
        self.stackView.axis = UILayoutConstraintAxisVertical;

        self.topTopLineViewConstraint.constant = SCREEN_HEIGHT/10;
        self.topBottomLineViewConstraint.constant = SCREEN_HEIGHT/10;
        
        self.topGitButton.constant = SCREEN_HEIGHT/16;
        self.topStartButton.constant = SCREEN_HEIGHT/30;
        
        if (ABS(SCREEN_HEIGHT - SCREEN_WIDTH) == 248) {
            self.appleWidthConstraint.constant = 70;
            self.appleHeightConstraint.constant = 70;
            self.stackView.spacing = 5;
            
            self.appleLogoLeading.constant = 20;
            self.topLineLeading.constant = 20;
            self.topLineTrailing.constant = 20;
            self.stackViewLeading.constant = 20;
            self.stackViewTrailing.constant = -20;
            self.bottomLineLeading.constant = 20;
            self.bottomLineTrailing.constant = -20;
            
            self.gitButtonTrailing.constant = -50;
            self.startButtonLeading.constant = 50;
            
            return;
        }
        
        self.appleHeightConstraint.constant = 100;
        self.appleWidthConstraint.constant = 100;
        
    }
    
}




- (void)setupLabels {
    long i = 0;
    for (UILabel *label in self.stackView.arrangedSubviews) {
        if (i == 2) {
            label.text = [NSString stringWithFormat:@"iOS %@", self.arrOfString[i]];
            break;
        }
        label.text = self.arrOfString[i];
        i++;
    }
    
}

- (void)setupStackView:(NSArray<UIView *> *)arrOfView {
    
    for (UIView *view in arrOfView) {
        [view.heightAnchor constraintEqualToConstant:70].active = true;
        [view.widthAnchor constraintEqualToConstant:70].active = true;
    }
    
    self.stackViewShapes = [[UIStackView alloc] initWithArrangedSubviews:arrOfView];
    
    self.stackViewShapes.axis = UILayoutConstraintAxisHorizontal;
    self.stackViewShapes.distribution = UIStackViewDistributionEqualSpacing;
    self.stackViewShapes.alignment = UIStackViewAlignmentCenter;
    self.stackViewShapes.spacing = 20;
    
    self.stackViewShapes.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.stackViewShapes];
    
    
    //Layout
    
    self.stackViewLeading = [self.stackViewShapes.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50];
    self.stackViewLeading.active = YES;
    
    self.stackViewTrailing = [self.stackViewShapes.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50];
    self.stackViewTrailing.active = YES;
    
    self.topTopLineViewConstraint = [self.stackViewShapes.topAnchor constraintEqualToAnchor:self.topLineView.bottomAnchor constant: SCREEN_HEIGHT/10];
    self.topTopLineViewConstraint.active = YES;
    
    
}

- (void)setupBottomLineView {
    self.bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.bottomLineLeading = [self.bottomLineView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50];
    self.bottomLineLeading.active = YES;
    self.bottomLineTrailing = [self.bottomLineView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50];
    self.bottomLineTrailing.active = YES;
    
    self.topBottomLineViewConstraint = [self.bottomLineView.topAnchor constraintEqualToAnchor:self.stackViewShapes.bottomAnchor constant: SCREEN_HEIGHT/10];
    self.topBottomLineViewConstraint.active = YES;
    
}

- (void)setupButtons {
    self.gitButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.gitButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    [self.startButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    
    self.gitButton.backgroundColor = YELLOW_COLOR;
    self.startButton.backgroundColor = RED_COLOR;
    [self.startButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    
    self.gitButton.layer.cornerRadius = 25;
    self.startButton.layer.cornerRadius = 25;
    
    [self.gitButton.heightAnchor constraintEqualToConstant:55].active = YES;
    [self.startButton.heightAnchor constraintEqualToConstant:55].active = YES;
    
    self.topGitButton = [self.gitButton.topAnchor constraintEqualToAnchor:self.bottomLineView.bottomAnchor constant: SCREEN_HEIGHT/16];
    self.topGitButton.active = YES;
    
    self.topStartButton = [self.startButton.topAnchor constraintEqualToAnchor:self.gitButton.bottomAnchor constant: SCREEN_HEIGHT/30];
    self.topStartButton.active = YES;
    
    self.gitButtonTrailing = [self.gitButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50];
    self.gitButtonTrailing.active = YES;
    
    self.startButtonLeading = [self.startButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50];
    self.startButtonLeading.active = YES;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.gitButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50],
        
        [self.startButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50]
    ]];
}


- (void)checkiOS:(NSString *)iOSVersion {
    
    double version = [iOSVersion doubleValue];
    
    if (version < 11.0) {
        self.appleTopConstraint.constant = 50;
    }
}

NSString* deviceName() {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);

    return [NSString stringWithCString:systemInfo.machine
                             encoding:NSUTF8StringEncoding];
    
}


- (BOOL)prefersStatusBarHidden {
    return true;
}

@end
