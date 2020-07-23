//
//  AppDelegate.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "AppDelegate.h"
#import "VideosListViewController.h"
#import "DataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [UINavigationBar appearance].tintColor = [UIColor grayColor];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [self rootVC];
    [self.window makeKeyAndVisible];;
    return YES;
}

- (UITabBarController *)rootVC {
    UITabBarController *tabBarController = [UITabBarController new];
    NSMutableArray *tabBarControllers = [[NSMutableArray alloc] init];
    
    VideosListViewController *startVC = [[VideosListViewController alloc] initWithType:AllVideos];
    UINavigationController *firstViewController = [[UINavigationController alloc] initWithRootViewController:startVC];
    firstViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Home"] tag:0];
    [tabBarControllers addObject:firstViewController];
    
    VideosListViewController *favouritesVC = [[VideosListViewController alloc] initWithType:FavouriteVideos];
    UINavigationController *secondViewController = [[UINavigationController alloc] initWithRootViewController:favouritesVC];
    secondViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Star"] tag:0];
    [tabBarControllers addObject:secondViewController];
    
    tabBarController.viewControllers = tabBarControllers;
    tabBarController.customizableViewControllers = nil;
    
    return tabBarController;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     [[DataManager sharedManager] saveContext];
}


@end
