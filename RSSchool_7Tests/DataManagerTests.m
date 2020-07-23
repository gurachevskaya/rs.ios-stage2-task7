//
//  DataManagerTests.m
//  RSSchool_7Tests
//
//  Created by Karina on 7/23/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"

@interface DataManagerTests : XCTestCase

@end

@implementation DataManagerTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)test_viewContext {
    DataManager *manager = [DataManager sharedManager];
    XCTAssertNotNil([manager viewContext]);
}


- (void)test_newBackgroundContext {
    DataManager *manager = [DataManager sharedManager];
    XCTAssertNotNil([manager newBackgroundContext]);
}

- (void)test_persistentContainer {
    
    DataManager *manager = [DataManager sharedManager];
//    [manager persistentContainer];
    
    XCTAssertNotNil([manager persistentContainer]);

}



@end
