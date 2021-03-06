//
//  Video+CoreDataProperties.h
//  RSSchool_7
//
//  Created by Karina on 10/22/20.
//  Copyright © 2020 Karina. All rights reserved.
//
//

#import "Video+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *downloadLink;
@property (nullable, nonatomic, copy) NSString *duration;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, copy) NSString *link;
@property (nullable, nonatomic, copy) NSString *speaker;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
