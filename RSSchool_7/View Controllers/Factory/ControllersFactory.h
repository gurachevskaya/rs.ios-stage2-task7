//
//  ControllersFactory.h
//  RSSchool_7
//
//  Created by Karina on 8/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideosListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ControllersFactory : NSObject

+ (VideosListViewController *)createViewControllerWithType:(ViewControllerType)type;

@end

NS_ASSUME_NONNULL_END
