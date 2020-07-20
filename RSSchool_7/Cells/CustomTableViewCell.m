//
//  CustomTableViewCell.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell()


@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)configureWithItem:(TedVideo *)video {
    self.durationLabel.text = video.duration;
    self.speakerLabel.text = video.speaker;
    self.speechNameLabel.text = video.title;
    self.videoImageView.image = video.image;
}

@end
