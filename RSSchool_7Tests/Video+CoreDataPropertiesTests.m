//
//  Video+CoreDataPropertiesTests.m
//  RSSchool_7Tests
//
//  Created by Karina on 7/22/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Video+CoreDataClass.h"

@interface Video_CoreDataPropertiesTests : XCTestCase
@property (nonatomic, strong) NSFetchRequest *request;

@end

@implementation Video_CoreDataPropertiesTests

- (void)setUp {
    [super setUp];
    self.request = [NSFetchRequest fetchRequestWithEntityName:@"Video"];
    self.request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
}

- (void)tearDown {
    [super tearDown];
    self.request = nil;
}

- (void)testExample {
    NSFetchRequest *videoRequest = [Video fetchRequest];
    XCTAssertTrue([self.request isEqual:videoRequest]);
}


@end
