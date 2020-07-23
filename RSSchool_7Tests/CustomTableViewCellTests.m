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
@property (strong, nonatomic) TedVideo *video;
@end

@implementation CustomTableViewCellTests

- (void)setUp {
    self.video = [[TedVideo alloc] init];
       self.video.downloadLink = @"downloadLink";
       self.video.duration = @"duration";
       self.video.image = [UIImage imageNamed:@"Home"];
       self.video.info = @"info";
       self.video.link = @"link";
       self.video.speaker = @"speaker";
       self.video.title = @"title";
}

- (void)tearDown {
    self.video = nil;
}

- (void)test_ConfigureWithItem {
    UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    CustomTableViewCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    [cell configureWithItem:self.video];

    XCTAssertNotNil(cell);
    XCTAssertTrue([cell.durationLabel.text isEqualToString:@"duration"]);
    XCTAssertTrue([cell.speakerLabel.text isEqualToString:@"speaker"]);
    XCTAssertTrue([cell.speechNameLabel.text isEqualToString:@"title"]);
    XCTAssertTrue([cell.videoImageView.image isEqual:[UIImage imageNamed:@"Home"]]);
}



@end
