//
//  DetailedViewControllerTests.m
//  RSSchool_7Tests
//
//  Created by Karina on 7/23/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DetailedInfoViewController.h"

@interface DetailedViewControllerTests : XCTestCase
@property (strong, nonatomic) DetailedInfoViewController *viewController;

@end

@implementation DetailedViewControllerTests

- (void)setUp {
    self.viewController = [[DetailedInfoViewController alloc] initWithNibName:@"DetailedInfoViewController" bundle:nil];
}

- (void)tearDown {
    self.viewController = nil;
}

- (void)testExample {
    
}


@end
