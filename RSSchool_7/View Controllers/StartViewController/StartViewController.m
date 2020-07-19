//
//  StartViewController.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "StartViewController.h"
#import "CustomTableViewCell.h"
#import "UserService.h"
#import "XMLParser.h"

@interface StartViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *videoSearchBar;
@property (strong, nonatomic) IBOutlet UILabel *allVideosLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UserService *userService;
@property (copy, nonatomic) NSArray<TedVideo *> *dataSource;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Networking
    self.userService = [[UserService alloc] initWithParser:[XMLParser new]];
    
    self.dataSource = [NSArray new];
    self.videoSearchBar.delegate = self;

    self.tableView.rowHeight = 150;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [self configureActivityIndicator];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startLoading];
    
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
                weakSelf.dataSource = videos;
                [weakSelf.tableView reloadData];
            }
            [weakSelf.activityIndicator stopAnimating];
        });
    }];
}


- (void)loadImageForIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    TedVideo *video = self.dataSource[indexPath.row];
    [self.userService loadImageForURL:video.imageUrl completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataSource[indexPath.row].image = image;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        });
    }];
}

#pragma mark - Table view data source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    TedVideo *video = self.dataSource[indexPath.row];
    if (!video.image) {
           [self loadImageForIndexPath:indexPath];
       }
       [cell configureWithItem:video];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TedVideo *video = self.dataSource[indexPath.row];
    [self.userService cancelDownloadingForUrl:video.imageUrl];
}

#pragma mark - UI Setup

- (void)configureActivityIndicator {
    if (@available(iOS 13.0, *)) {
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
    } else {
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }
}

#pragma mark - Keyboard

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:true];
}

- (void)dismissKeyboard {
    [self.videoSearchBar resignFirstResponder];
}



@end
