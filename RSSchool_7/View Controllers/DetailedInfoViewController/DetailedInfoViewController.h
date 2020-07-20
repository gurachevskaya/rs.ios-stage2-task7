//
//  DetailedInfoViewController.h
//  RSSchool_7
//
//  Created by Karina on 7/20/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TedVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailedInfoViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil video:(TedVideo *)video;

@end

NS_ASSUME_NONNULL_END
