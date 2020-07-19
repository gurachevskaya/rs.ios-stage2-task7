//
//  XMLParser.h
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TedVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLParser : NSObject

- (void)parseVideos:(NSData *)data completion:(void (^)(NSArray<TedVideo *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
