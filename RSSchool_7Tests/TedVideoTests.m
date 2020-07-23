//
//  TedVideoTests.m
//  RSSchool_7Tests
//
//  Created by Karina on 7/22/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TedVideo.h"

@interface TedVideoTests : XCTestCase
@property (nonatomic, copy) NSDictionary *dictionary;
@end

@implementation TedVideoTests

- (void)setUp {
    [super setUp];
    self.dictionary = @{ @"title" : @"title",
                                  @"description" : @"description",
                                  @"media:credit" : @"media:credit",
                                  @"itunes:image" : @"itunes:image",
                                  @"itunes:duration" : @"itunes:duration",
                                  @"link" : @"link",
                                  @"media:content" : @"media:content"
    };
}

- (void)tearDown {
    [super tearDown];
    self.dictionary = nil;
}

- (void)testInit {
    TedVideo *tedVideo = [[TedVideo alloc] initWithDictionary:self.dictionary];
    
    XCTAssertTrue([tedVideo.downloadLink isEqualToString:@"media:content"]);
    XCTAssertTrue([tedVideo.duration isEqualToString:@"itunes:duration"]);
    XCTAssertNil(tedVideo.image);
    XCTAssertTrue([tedVideo.imageUrl isEqualToString:@"itunes:image"]);
    XCTAssertTrue([tedVideo.info isEqualToString:@"description"]);
    XCTAssertTrue([tedVideo.link isEqualToString:@"link"]);
    XCTAssertTrue([tedVideo.speaker isEqualToString:@"media:credit"]);
    XCTAssertTrue([tedVideo.title isEqualToString:@"title"]);

    XCTAssertNotNil(tedVideo);
}



@end
