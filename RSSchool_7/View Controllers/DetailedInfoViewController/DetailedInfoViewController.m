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
#import <AVKit/AVKit.h>


@interface DetailedInfoViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakerLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic) BOOL isFavourite;
@property (strong, nonatomic) TedVideo *video;
@property (strong, nonatomic) Video *dataVideo;
@property (strong, nonatomic) AVPlayer *player;
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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationItem.backBarButtonItem = backButton;
        
    self.durationLabel.text = self.video.duration;
    self.speakerLabel.text = self.video.speaker;
    self.videoNameLabel.text = self.video.title;
    self.informationLabel.text = self.video.info;
    self.videoImageView.image = self.video.image;
    if (self.videoImageView.image){
    [self.playButton setHidden:NO];
    float aspectRatio = self.videoImageView.image.size.height/self.videoImageView.image.size.width;
    [self.videoImageView.heightAnchor constraintEqualToAnchor:self.videoImageView.widthAnchor multiplier:aspectRatio].active = YES;
    }
    
    self.isFavourite = NO;

    self.dataManager = [DataManager sharedManager];
    NSManagedObjectContext *context = [self.dataManager newBackgroundContext];
    NSFetchRequest *request = [Video fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"info == %@", self.video.info];
    NSArray *array = [context executeFetchRequest:request error:nil];
    if (array.count) {
        self.isFavourite = YES;
    }
}

#pragma mark - Actions
 
- (IBAction)playButtonTapped:(id)sender {
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:self.video.downloadLink]];

    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    playerViewController.player = self.player;
    [self presentViewController:playerViewController animated:YES completion:^{
        [playerViewController.player play];
    }];
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
            self.dataVideo.link = self.video.link;
            [context save:nil];
        }];

    } else {
        NSFetchRequest *request = [Video fetchRequest];
        request.predicate = [NSPredicate predicateWithFormat:@"info == %@", self.video.info];
        NSArray *array = [context executeFetchRequest:request error:nil];
        [context deleteObject:[array objectAtIndex:0]];
        [context save:nil];
    }
}


- (IBAction)shareButtonTapped:(id)sender {
    UIActivityViewController *activityVC;
    activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.video.link] applicationActivities:nil];
    UIDevice *device = [[UIDevice alloc] init];
    //if iPad
    if ( !(device.userInterfaceIdiom == UIUserInterfaceIdiomPhone)) {
        if ([sender isKindOfClass:[UIView class]]) {
            activityVC.popoverPresentationController.sourceView = [sender superview];
            activityVC.popoverPresentationController.sourceRect = [sender frame];
        }
    }
    [self presentViewController:activityVC animated:YES completion:nil];
}


- (void)setIsFavourite:(BOOL)isFavourite {
    _isFavourite = isFavourite;
    if (isFavourite) {
        [self.heartButton setImage:[UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
        self.heartButton.tintColor = [UIColor blackColor];
        if (@available(iOS 12.0, *)) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                self.heartButton.tintColor = [UIColor whiteColor];
            }
        }
    } else {
        [self.heartButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        self.heartButton.tintColor = [UIColor grayColor];
    }
}



@end
