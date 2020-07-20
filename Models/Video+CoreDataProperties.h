//
//  Video+CoreDataProperties.h
//  RSSchool_7
//
//  Created by Karina on 7/20/20.
//  Copyright © 2020 Karina. All rights reserved.
//
//

#import "Video+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *duration;
@property (nullable, nonatomic, copy) NSString *speaker;
@property (nullable, nonatomic, copy) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END
