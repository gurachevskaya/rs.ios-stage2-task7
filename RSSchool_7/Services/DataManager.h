//
//  DataManager.h
//  RSSchool_7
//
//  Created by Karina on 7/20/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (DataManager *)sharedManager;

- (void)saveContext;
- (NSManagedObjectContext *)viewContext;
- (NSManagedObjectContext *)newBackgroundContext;

@end

NS_ASSUME_NONNULL_END
