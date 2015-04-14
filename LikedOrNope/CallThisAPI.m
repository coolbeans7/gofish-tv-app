//
//  CallThisAPI.m
//  LikedOrNope
//
//  Created by Gerhold, Andrew on 9/4/14.
//  Copyright (c) 2014 modocache. All rights reserved.
//

#import "CallThisAPI.h"
#import "Person.h"

NSString *serverAddress = @"http://localhost:8080/getMoreShows";

@implementation CallThisAPI

+ (NSMutableArray *)getMoreShows {
    // It would be trivial to download these from a web service
    // as needed, but for the purposes of this sample app we'll
    // simply store them in memory.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shows" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"json = %@", json);
    
    NSMutableArray* shows;
    shows = [[NSMutableArray alloc] init];
    
    //if json is what we expect
    if ([json isKindOfClass:[NSArray class]]){ //Added instrospection
        for (NSDictionary *dictionary in json) {
            Person *person = [[Person alloc] init];
            person.name = [dictionary objectForKey:@"name"];
            person.age = [[dictionary objectForKey:@"age"] integerValue];
            person.image = [UIImage imageNamed:[dictionary objectForKey:@"image"]];
            person.numberOfSharedFriends = [[dictionary objectForKey:@"numberOfSharedFriends"] integerValue];
            person.numberOfSharedInterests = [[dictionary objectForKey:@"numberOfSharedInterests"] integerValue];
            person.numberOfPhotos = [[dictionary objectForKey:@"numberOfPhotos"] integerValue];
            //Do this for all property
            [shows addObject:person];
        }
        NSLog(@"shows = %@", shows);
    }
    
    return shows;
}

+ (void)likedShow {

    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/likedShow"];
    
    NSString *post =[[NSString alloc] initWithFormat:@"guid=%@&showid=%@", @"Comcast-1234567654321",@"theBlackList"];
    NSLog(@"Post is: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSLog(@"postData is: %@",postData);
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSLog(@"postLength is: %@",postLength);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"http://localhost:8080/likedShow" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSLog(@"request is: %@", [request allHTTPHeaderFields]);
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"urlData is: %@",urlData);
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
}

+ (void)dislikedShow {}
+ (void)tuneToThisShow {}

+ (NSMutableArray *)getMoreShowsFromServer {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
    
    NSLog(@"json = %@", json);
    
    NSMutableArray* shows;
    shows = [[NSMutableArray alloc] init];
    
    //if json is what we expect
    if ([json isKindOfClass:[NSArray class]]){ //Added instrospection
        for (NSDictionary *dictionary in json) {
            Person *person = [[Person alloc] init];
            person.name = [dictionary objectForKey:@"name"];
            person.age = [[dictionary objectForKey:@"age"] integerValue];
            person.image = [UIImage imageNamed:[dictionary objectForKey:@"image"]];
            person.numberOfSharedFriends = [[dictionary objectForKey:@"numberOfSharedFriends"] integerValue];
            person.numberOfSharedInterests = [[dictionary objectForKey:@"numberOfSharedInterests"] integerValue];
            person.numberOfPhotos = [[dictionary objectForKey:@"numberOfPhotos"] integerValue];
            //Do this for all property
            [shows addObject:person];
        }
        NSLog(@"shows = %@", shows);
    }
    
    return shows;
}

@end