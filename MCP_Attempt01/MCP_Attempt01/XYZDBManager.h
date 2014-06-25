//
//  XYZDBManager.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 10/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface XYZDBManager : NSObject
{
    NSString *databasePath;
}

+(XYZDBManager *)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveUsername:(NSString *)username andPassword:(NSString*)password;
-(NSArray*) getProfileByProfileID:(NSInteger)profileId;


@end
