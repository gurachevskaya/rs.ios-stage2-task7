//
//  DetailedInfoViewController.m
//  RSSchool_7
//
//  Created by Karina on 7/20/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "DetailedInfoViewController.h"
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "Video+CoreDataProperties.h"


@interface DetailedInfoViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakerLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (nonatomic) BOOL isFavourite;

@property (strong, nonatomic) TedVideo *video;
@property (strong, nonatomic) Video *dataVideo;

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation DetailedInfoViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil video:(TedVideo *)video {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _video = video;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self.navigationController
                                                                  action:@selector(popViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.heartButton.tintColor = [UIColor grayColor];
    
    self.durationLabel.text = self.video.duration;
    self.speakerLabel.text = self.video.speaker;
    self.videoNameLabel.text = self.video.title;
    self.informationLabel.text = self.video.info;
    NSLog(@"%@", NSStringFromCGSize(self.video.image.size));
    self.videoImageView.image = self.video.image;
    
    self.dataManager = [DataManager sharedManager];
//    [self.dataManager viewContext].automaticallyMergesChangesFromParent = YES;
    NSManagedObjectContext *context = [self.dataManager newBackgroundContext];
    
    [self.heartButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    self.isFavourite = NO;
    NSFetchRequest *request = [Video fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"info == %@", self.video.info];
    NSArray *array = [context executeFetchRequest:request error:nil];
    
//    for (Video *video in array) {
//        if ([video.info isEqualToString:self.video.info]) {
//            self.isFavourite = YES;
//            [self.heartButton setImage:[UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
//            return;
//        }
//    }
    if (array.count) {
        self.isFavourite = YES;
        [self.heartButton setImage:[UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
    }
}
 

- (IBAction)heartTapped:(id)sender {
  
    NSManagedObjectContext *context = [self.dataManager newBackgroundContext];
    
    self.isFavourite = !self.isFavourite;
    if (self.isFavourite == YES) {
        [context performBlockAndWait:^{
            self.dataVideo = [[Video alloc] initWithContext:context];
            self.dataVideo.duration = self.video.duration;
            self.dataVideo.imageUrl = self.video.imageUrl;
            self.dataVideo.info = self.video.info;
            self.dataVideo.speaker = self.video.speaker;
            self.dataVideo.title = self.video.title;
            [context save:nil];
        }];
        NSLog(@"%ld", [context countForFetchRequest:[Video fetchRequest] error:nil]);
        [self.heartButton setImage:[UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
    } else {
        NSFetchRequest *request = [Video fetchRequest];
        request.predicate = [NSPredicate predicateWithFormat:@"info == %@", self.video.info];
        NSArray *array = [context executeFetchRequest:request error:nil];
//        for (Video *video in array) {
//            if ([video.info isEqualToString:self.video.info]) {
//                [context deleteObject:video];
//            }
//        }
        [context deleteObject:[array objectAtIndex:0]];

        [context save:nil];
        NSLog(@"%ld", [context countForFetchRequest:[Video fetchRequest] error:nil]);
        [self.heartButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }
}


@end
