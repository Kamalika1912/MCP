//
//  XYZFlashcard.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 09/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZFlashcard : NSObject

@property NSInteger flashcardID;
@property NSString *question;
@property NSString *answer;
@property NSInteger thumbsUp;
@property NSInteger thumbsDown;
@property NSInteger cost;
@property Boolean addedToFavourites;
@property NSInteger createdBy;


@end
