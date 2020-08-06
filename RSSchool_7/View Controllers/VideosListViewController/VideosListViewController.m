//
//  VideosListViewController.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "VideosListViewController.h"


@interface VideosListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@end


@implementation VideosListViewController

//Ensuring below that the startLoading and configureVideosLabel method must be implemented by the private subclasses
- (void)startLoading {
    [NSException raise:NSInternalInconsistencyException
                format:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
}

- (void)configureVideosLabel {
    [NSException raise:NSInternalInconsistencyException
                format:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureVideosLabel];
    
    self.userService = [[UserService alloc] initWithParser:[XMLParser new]];
    self.dataSource = [NSArray new];
    self.videoSearchBar.delegate = self;
    self.isFiltered = NO;

    self.tableView.rowHeight = 150;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];

    [self configureActivityIndicator];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    TedVideo *video = self.videosArray[indexPath.row];
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

