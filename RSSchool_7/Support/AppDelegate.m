//
//  AppDelegate.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "AppDelegate.h"
#import "VideosListViewController.h"
#import "FavouritesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [UITabBar appearance].tintColor = [UIColor grayColor];
    
    UITabBarController *tabBarController = [UITabBarController new];
    NSMutableArray *tabBarControllers = [[NSMutableArray alloc] init];
    
    VideosListViewController *startVC = [[VideosListViewController alloc] initWithType:AllVideos];
    UINavigationController *firstViewController = [[UINavigationController alloc] initWithRootViewController:startVC];
    [firstViewController.navigationBar setHidden:YES];
    firstViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Home"] tag:0];
    [tabBarControllers addObject:firstViewController];
    
    VideosListViewController *favouritesVC = [[VideosListViewController alloc] initWithType:FavouriteVideos];
    UINavigationController *secondViewController = [[UINavigationController alloc] initWithRootViewController:favouritesVC];
    [secondViewController.navigationBar setHidden:YES];
    secondViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Star"] tag:0];
    [tabBarControllers addObject:secondViewController];
    
    tabBarController.viewControllers = tabBarControllers;
    tabBarController.customizableViewControllers = nil;
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];;
    return YES;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"RSSchool_7"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
