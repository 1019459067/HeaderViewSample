//
//  AppDelegate.m
//  HeaderViewSample
//
//  Created by HN on 2020/8/5.
//  Copyright © 2020 HN. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [[TestViewController alloc] init];;
    
    [self.window makeKeyAndVisible];

    return YES;
}



@end
