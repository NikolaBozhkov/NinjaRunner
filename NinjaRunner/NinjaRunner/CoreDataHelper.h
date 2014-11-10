//
//  CoreDataHelper.h
//  CoreDataDemo
//
//  Created by Gabriela Angelova on 11/9/14.
//  Copyright (c) 2014 telerik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, strong) NSPersistentStore *store;

-(void)saveContext;
-(void)setupCoreData;


@end
