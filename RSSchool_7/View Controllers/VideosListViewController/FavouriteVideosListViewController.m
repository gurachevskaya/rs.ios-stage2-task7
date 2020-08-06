//
//  FavouriteVideosListViewController.m
//  RSSchool_7
//
//  Created by Karina on 8/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "FavouriteVideosListViewController.h"

@interface FavouriteVideosListViewController ()

@end

@implementation FavouriteVideosListViewController

- (void)configureVideosLabel {
    self.explanationLabel.text = @"Избранные видео";
}

- (void)startLoading {
    self.dataManager = [DataManager sharedManager];
    NSManagedObjectContext *context = [self.dataManager newBackgroundContext];
    
    self.videosArray = [NSMutableArray array];
    NSArray *array = [context executeFetchRequest:[Video fetchRequest] error:nil];
    for (Video *video in array) {
        TedVideo *tedVideo = [TedVideo new];
        tedVideo.duration = video.duration;
        tedVideo.imageUrl = video.imageUrl;
        tedVideo.info = video.info;
        tedVideo.speaker = video.speaker;
        tedVideo.title = video.title;
        tedVideo.link = video.link;
        tedVideo.downloadLink = video.downloadLink;
        [self.videosArray addObject:tedVideo];
    }
    [self.tableView reloadData];
}


@end
