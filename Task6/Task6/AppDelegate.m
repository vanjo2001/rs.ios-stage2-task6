//
//  AppDelegate.m
//  Task6
//
//  Created by IvanLyuhtikov on 6/23/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Constants.h"

@interface AppDelegate ()



@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationBar.appearance.barTintColor = YELLOW_COLOR;
    UINavigationBar.appearance.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
    
    [UIButton.appearance setFont:[UIFont systemFontOfSize:20 weight: UIFontWeightMedium]];
    
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = YELLOW_HIGHLIGHTED_COLOR;
    
    [UITableViewCell.appearance setSelectedBackgroundView: customColorView];
    
    [UIButton.appearance setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    
    
    if (@available(iOS 13, *)) {
        
    } else {
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        self.window.rootViewController = [[ViewController alloc] init];
        
        [self.window makeKeyAndVisible];
        
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13)) {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13)) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
