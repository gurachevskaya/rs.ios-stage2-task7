//
//  FavouritesViewController.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "FavouritesViewController.h"
#import "CustomTableViewCell.h"
#import "TedVideo.h"

@interface FavouritesViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>


@property (copy, nonatomic) NSArray<TedVideo *> *dataSource;

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.tableView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Table view data source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
   // cell.videoImageView.image = [UIImage imageNamed:@"Снимок экрана 2020-07-15 в 17.34.47"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
