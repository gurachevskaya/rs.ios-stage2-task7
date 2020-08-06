//
//  ControllersFactory.m
//  RSSchool_7
//
//  Created by Karina on 8/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "ControllersFactory.h"
#import "AllVideosListViewController.h"
#import "FavouriteVideosListViewController.h"

@implementation ControllersFactory

+ (VideosListViewController *)createViewControllerWithType:(ViewControllerType)type {
    switch (type) {
        case AllVideos:
            return [[AllVideosListViewController alloc] initWithNibName:@"VideosViewController" bundle:nil];
            
        case FavouriteVideos:
            return [[FavouriteVideosListViewController alloc] initWithNibName:@"VideosViewController" bundle:nil];
    }
}


@end
