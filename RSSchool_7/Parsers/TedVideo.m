//
//  TedVideo.m
//  RSSchool_7
//
//  Created by Karina on 7/19/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "TedVideo.h"

@implementation TedVideo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _info = dictionary[@"description"];
        _speaker = dictionary[@"media:credit"];
        _imageUrl = dictionary[@"itunes:image"];
        _duration = dictionary[@"itunes:duration"];
    }
    return self;
}

@end
