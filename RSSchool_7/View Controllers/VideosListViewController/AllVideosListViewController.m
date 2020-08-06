//
//  AllVideosListViewController.m
//  RSSchool_7
//
//  Created by Karina on 8/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "AllVideosListViewController.h"

@interface AllVideosListViewController ()

@end

@implementation AllVideosListViewController

- (void)configureVideosLabel {
    self.explanationLabel.text = @"Все видео";
}

- (void)startLoading {
    __weak typeof(self) weakSelf = self;
    [self.activityIndicator startAnimating];
    [self.userService loadVideos:^(NSArray<TedVideo *> *videos, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                         message:[NSString stringWithFormat:@"%@", error]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                weakSelf.videosArray = [videos mutableCopy];
                weakSelf.dataSource = weakSelf.videosArray;
                [weakSelf.tableView reloadData];
            }
            [weakSelf.activityIndicator stopAnimating];
        });
    }];
}

@end
