//
//  XYZSubject.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 09/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZSubject : NSObject

@property NSInteger subjectId;
@property NSMutableArray *lectureLsit;


-(NSMutableArray *) getLecturesByList:(NSInteger) lectureID;

@end
