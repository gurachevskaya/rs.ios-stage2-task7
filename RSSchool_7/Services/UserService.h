//
//  UserService.h
//  RSSchool_7
//
//  Created by Karina on 7/19/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "tedVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserService : NSObject

- (instancetype)initWithParser:(id)parser;

- (void)loadVideos:(void(^)(NSArray<TedVideo *> *, NSError *))completion;
- (void)loadImageForURL:(NSString *)url completion:(void(^)(UIImage *))completion;
- (void)cancelDownloadingForUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
