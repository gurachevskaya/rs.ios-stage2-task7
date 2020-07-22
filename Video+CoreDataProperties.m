//
//  Video+CoreDataProperties.m
//  RSSchool_7
//
//  Created by Karina on 7/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//
//

#import "Video+CoreDataProperties.h"

@implementation Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Video"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    return request;
}

@dynamic duration;
@dynamic imageUrl;
@dynamic info;
@dynamic speaker;
@dynamic title;
@dynamic link;
@dynamic downloadLink;

@end
