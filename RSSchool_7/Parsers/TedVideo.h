//
//  TedVideo.h
//  RSSchool_7
//
//  Created by Karina on 7/19/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TedVideo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *speaker;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *duration;

@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
