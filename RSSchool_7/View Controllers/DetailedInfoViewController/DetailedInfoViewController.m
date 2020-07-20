//
//  DetailedInfoViewController.m
//  RSSchool_7
//
//  Created by Karina on 7/20/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "DetailedInfoViewController.h"

@interface DetailedInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakerLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (nonatomic) BOOL isFavourite;

@property (strong, nonatomic) TedVideo *video;

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
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor greenColor];

    
//    self.heartButton.imageView.image = [UIImage imageNamed:@"heart"];
    self.heartButton.tintColor = [UIColor grayColor];
    
    self.durationLabel.text = self.video.duration;
    self.speakerLabel.text = self.video.speaker;
    self.videoNameLabel.text = self.video.title;
    self.informationLabel.text = self.video.info;
    NSLog(@"%@", NSStringFromCGSize(self.video.image.size));
    self.videoImageView.image = self.video.image;
    self.isFavourite = NO;
    
}

- (IBAction)heartTapped:(id)sender {
    self.isFavourite = !self.isFavourite;
    if (self.isFavourite == YES) {
        [self.heartButton setImage:[UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
    } else {
        [self.heartButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }
   
}


@end
