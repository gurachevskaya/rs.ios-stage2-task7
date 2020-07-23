//
//  AppDelegateTests.m
//  RSSchool_7Tests
//
//  Created by Karina on 7/23/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface AppDelegate (Testing)

- (UITabBarController *)rootVC;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end


@interface AppDelegateTests : XCTestCase


@end

@implementation AppDelegateTests

- (void)setUp {

}

- (void)tearDown {

}

- (void)test_rootVC {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    XCTAssertNotNil([appDelegate rootVC]);
    XCTAssertEqual([[appDelegate rootVC] class], [UITabBarController class]);
}

- (void)test_didFinishLaunchingWithOptions {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL testingValue = [appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    XCTAssertTrue(testingValue == YES);
}

@end
