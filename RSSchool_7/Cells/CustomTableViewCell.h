//
//  CustomTableViewCell.h
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TedVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *videoImageView;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *speakerLabel;
@property (strong, nonatomic) IBOutlet UILabel *speechNameLabel;

- (void)configureWithItem:(TedVideo *)video;

@end

NS_ASSUME_NONNULL_END
