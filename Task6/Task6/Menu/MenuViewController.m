//
//  menuViewController.m
//  Task6
//
//  Created by IvanLyuhtikov on 6/24/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "UIViewController+StatusBarOff.h"

#import "MenuViewController.h"
#import "InfoViewController.h"
#import "GalleryViewController.h"
#import "TaskViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setupTabBar];
    
    [self setSelectedIndex:1];
    
}


- (void)setupTabBar {
    
    UINavigationController *info = [[UINavigationController alloc] initWithRootViewController:[[InfoViewController alloc] init]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UINavigationController *gallery = [[UINavigationController alloc] initWithRootViewController:[[GalleryViewController alloc] initWithCollectionViewLayout:layout]];
    
    UINavigationController *task = [[UINavigationController alloc] initWithRootViewController:[[TaskViewController alloc] init]];

    info.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"list"] tag:0];
    gallery.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"photo-camera"] tag:1];
    task.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"user"] tag:2];
    
    self.viewControllers = @[info, gallery, task];
}

- (BOOL)prefersStatusBarHidden {
    return true;
}

@end
