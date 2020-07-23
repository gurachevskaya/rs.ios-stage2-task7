//
//  CustomTableViewCell.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation CustomTableViewCell

- (void)configureWithItem:(TedVideo *)video {
    self.durationLabel.text = video.duration;
    self.speakerLabel.text = video.speaker;
    self.speechNameLabel.text = video.title;
    self.videoImageView.image = video.image;
}

@end
