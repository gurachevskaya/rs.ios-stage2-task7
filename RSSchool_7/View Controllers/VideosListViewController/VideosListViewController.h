//
//  VideosListViewController.h
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "VideoService.h"
#import "XMLParser.h"
#import <CoreData/CoreData.h>
#import "DetailedInfoViewController.h"
#import "DataManager.h"
#import "Video+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ViewControllerType) {
  AllVideos,
  FavouriteVideos
};

@protocol VideosLoadingProtocol

- (void)startLoading;
- (void)configureVideosLabel;

@end

@interface VideosListViewController : UIViewController <VideosLoadingProtocol>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *videoSearchBar;
@property (strong, nonatomic) IBOutlet UILabel *allVideosLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) VideoService *videoService;
@property (copy, nonatomic) NSArray<TedVideo *> *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (strong, nonatomic) NSMutableArray<TedVideo *> *videosArray;
@property (strong, nonatomic) NSMutableArray<TedVideo *> *searchResultArray;
@property (nonatomic) BOOL isFiltered;
@property (copy, nonatomic) NSString *searchText;


@end

NS_ASSUME_NONNULL_END
