//
//  VideosListViewController.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "VideosListViewController.h"
#import "CustomTableViewCell.h"
#import "UserService.h"
#import "XMLParser.h"
#import <CoreData/CoreData.h>
#import "DetailedInfoViewController.h"
#import "DataManager.h"
#import "Video+CoreDataProperties.h"

@interface VideosListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *videoSearchBar;
@property (strong, nonatomic) IBOutlet UILabel *allVideosLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UserService *userService;
@property (copy, nonatomic) NSArray<TedVideo *> *dataSource;

@property (strong, nonatomic) NSMutableArray<TedVideo *> *videosArray;
@property (strong, nonatomic) NSMutableArray<TedVideo *> *searchResultArray;
@property (nonatomic) BOOL isFiltered;
@property (copy, nonatomic) NSString *searchText;

@property (nonatomic) ViewControllerType type;

@end

@interface AllVideosListViewController : VideosListViewController 

@end

@interface FavouriteVideosListViewController : VideosListViewController

@property (nonatomic, strong) DataManager *dataManager;

@end

@implementation VideosListViewController

//Ensuring below that the startLoading and cellForRowAtIndexPath method must be implemented by the private subclasses
- (void)startLoading {
    [NSException raise:NSInternalInconsistencyException
                format:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
}

- (instancetype)initWithType:(ViewControllerType)type {
    self = nil;
    if (type == AllVideos) {
        self = [[AllVideosListViewController alloc] initWithNibName:@"VideosViewController" bundle:nil];
    } else if (type == FavouriteVideos) {
        self = [[FavouriteVideosListViewController alloc] initWithNibName:@"VideosViewController" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userService = [[UserService alloc] initWithParser:[XMLParser new]];
    self.dataSource = [NSArray new];
    self.videoSearchBar.delegate = self;
    self.isFiltered = NO;

    self.tableView.rowHeight = 150;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
//    [self startLoading];

    [self configureActivityIndicator];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.tableView reloadData];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
  
    [self startLoading];
}

- (void)loadImageForIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    
    [self.activityIndicator startAnimating];
    TedVideo *video = [TedVideo new];
 
    video = self.dataSource[indexPath.row];
    [self.userService loadImageForURL:video.imageUrl completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.dataSource[indexPath.row].image = image;
            //            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.tableView reloadData];
            [self.activityIndicator stopAnimating];
        });
    }];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
  
    TedVideo *video = self.dataSource[indexPath.row];
    if (!video.image && !self.isFiltered) {
        [self loadImageForIndexPath:indexPath];
    } else if (!video.image && self.isFiltered) {
        for (TedVideo *tedVideo in self.videosArray) {
            if ([video.imageUrl isEqualToString:tedVideo.imageUrl]) {
                [self.userService loadImageForURL:tedVideo.imageUrl completion:^(UIImage *image) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                             video.image = image;
                      });
                  }];
            }
        }
    }

    [cell configureWithItem:video];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltered) {
        self.dataSource = self.searchResultArray;
    } else {
        self.dataSource = self.videosArray;
    }
    return self.dataSource.count;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TedVideo *video = self.dataSource[indexPath.row];
    [self.userService cancelDownloadingForUrl:video.imageUrl];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TedVideo *video = self.dataSource[indexPath.row];
    DetailedInfoViewController *vc = [[DetailedInfoViewController alloc] initWithNibName:@"DetailedInfoViewController" bundle:[NSBundle mainBundle] video:video];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI Setup

- (void)configureActivityIndicator {
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    if (@available(iOS 13.0, *)) {
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
    }
}


#pragma mark - SearchBar Delegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isFiltered = NO;
        self.dataSource = self.videosArray;
    } else {
        searchBar.showsCancelButton = YES;
        self.isFiltered = YES;
        self.dataSource = self.videosArray;
        self.searchResultArray = [NSMutableArray array];
        for (TedVideo *video in self.dataSource) {
            NSRange titleRange = [video.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange speakerRange = [video.speaker rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleRange.location != NSNotFound || speakerRange.location != NSNotFound) {
                [self.searchResultArray addObject:video];
            }
        }
        self.dataSource = self.searchResultArray;
    }
    if (self.dataSource) {
        [self.tableView reloadData];
    } else {
        self.dataSource = self.videosArray;
        return;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.text = nil;
    self.isFiltered = NO;
    [self.tableView reloadData];
}

@end


@implementation AllVideosListViewController 

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
//                weakSelf.searchResultDataSource = [videos mutableCopy];
                weakSelf.videosArray = [videos mutableCopy];
                weakSelf.dataSource = weakSelf.videosArray;
                [weakSelf.tableView reloadData];
            }
            [weakSelf.activityIndicator stopAnimating];
        });
    }];
}

@end


@implementation FavouriteVideosListViewController

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
//    self.dataSource = self.videosArray;
    [self.tableView reloadData];
}

#pragma mark - Table View delegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TedVideo *video = self.dataSource[indexPath.row];
    [self.userService cancelDownloadingForUrl:video.imageUrl];
}


@end
