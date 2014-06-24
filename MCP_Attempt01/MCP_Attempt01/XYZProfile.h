//
//  XYZProfile.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 09/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZProfile : NSObject

@property NSInteger profileId;
@property NSString *username;
@property NSString *password;
@property NSMutableArray *subjectList;
@property NSInteger *coins;


-(void)getListOfSubjects;


@end
