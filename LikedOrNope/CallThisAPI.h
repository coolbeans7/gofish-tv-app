//
//  CallThisAPI.h
//  LikedOrNope
//
//  Created by Gerhold, Andrew on 9/4/14.
//  Copyright (c) 2014 modocache. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallThisAPI : NSObject

+(NSMutableArray *) getMoreShows;
+(NSMutableArray *) getMoreShowsFromServer;
+ (void) likedShow;
+ (void) dislikedShow;
+ (void) tuneToThisShow;

@end
