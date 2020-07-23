//
//  CustomTableViewCellTests.m
//  RSSchool_7Tests
//
//  Created by Karina on 7/23/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CustomTableViewCell.h"
#import "TedVideo.h"

@interface CustomTableViewCellTests : XCTestCase

@end

@implementation CustomTableViewCellTests

- (void)setUp {
    
}

- (void)tearDown {
}

- (void)testExample {
    
    TedVideo *video = [[TedVideo alloc] init];
    video.downloadLink = @"";
    video.duration = @"duration";
    video.image = [[UIImage alloc] init];;
    video.info = @"";
    video.link = @"";
    video.speaker = @"speaker";
    video.title = @"";
    
    CustomTableViewCell *cell = [[CustomTableViewCell alloc] init];
    [cell configureWithItem:video];
//    UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];

    XCTAssertNotNil(cell);

}



@end
