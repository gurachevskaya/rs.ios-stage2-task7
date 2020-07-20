//
//  VideosListViewController.h
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ViewControllerType) {
  AllVideos,
  FavouriteVideos
};

@protocol VideosLoadingProtocol
@required
- (void)startLoading;

@end

@interface VideosListViewController : UIViewController <VideosLoadingProtocol>

- (instancetype)initWithType:(ViewControllerType)type;

@end

NS_ASSUME_NONNULL_END
