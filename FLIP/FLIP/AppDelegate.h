//
//  AppDelegate.h
//  FLIP
//
//  Created by Giorgio Pretto on 6/25/14.
//  Copyright (c) 2014 MCP 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// for core data
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (NSURL *)applicationDocumentsDirectory; // nice to have to reference files for core data


@property (strong, nonatomic) UIWindow *window;

@end
