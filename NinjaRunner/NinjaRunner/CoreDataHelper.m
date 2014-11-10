//
//  CoreDataHelper.m
//  CoreDataDemo
//
//  Created by Gabriela Angelova on 11/9/14.
//  Copyright (c) 2014 telerik. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

NSString *storeFilename = @"CDatabase.sqlite";

-(id)init{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    self = [super init];
    
    if(!self) { return nil; }
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel: _model];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    
    return self;
}

-(void)saveContext{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if([_context hasChanges]){
        NSError *error = nil;
        if([_context save:&error]){
            NSLog(@"_context SAVED changes to persistent store");
        } else {
            NSLog(@"Failed to save _context: %@", error);
        }
    } else {
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

-(void) loadStore{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if(_store){return;}
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error];
    
    if(!_store){
        NSLog(@"Failed to add store. Error: %@", error);
        abort();
    } else {
        NSLog(@"Successfully added store: %@", _store);
    }
}

-(NSURL *)storeURL{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    return [[self applicationStoreDirectory] URLByAppendingPathComponent:storeFilename];
}

-(void)setupCoreData{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [self loadStore];
}

-(NSString *) applicationDocumentsDirectory{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSURL *)applicationStoreDirectory
{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if(![filemanager fileExistsAtPath:[storesDirectory path]]){
        NSError *error = nil;
        if([filemanager createDirectoryAtURL:storesDirectory withIntermediateDirectories:YES attributes:nil error:&error]){
            NSLog(@"Successfully created Stores directory");
        } else{
            NSLog(@"Successfully created stores directory");
        }
    }
    return storesDirectory;
}

@end
