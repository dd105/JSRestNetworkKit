//
//  TwitterRequestManager.m
//  JSRestNetworkKitSampleProject
//
//  Created by Javier Soto on 5/6/12.
//  Copyright (c) 2012 JavierSoto. All rights reserved.
//

#import "TwitterRequestManager.h"
#import "JSWebServiceRequest.h"
#import "JSWebServiceRequestParameters.h"

#import "TwitterResponseParser.h"

#import "Tweet.h"

@interface TwitterRequestManager ()
{
    JSWebServiceProxy *_webProxy;
}
@end

@implementation TwitterRequestManager

- (id)init
{
    if ((self = [super init]))
    {
        TwitterResponseParser *responseParser = [[TwitterResponseParser alloc] init];
        
        _webProxy = [[JSWebServiceProxy alloc] initWithBaseURL:[NSURL URLWithString:@"http://search.twitter.com"] responseParser:responseParser];
        
        [responseParser release];
    }
        
    return self;
}

/* https://dev.twitter.com/docs/api/1/get/search */

- (void)requestTweetsWithSearch:(NSString *)search successCallback:(TwitterRequestManagerSucessCallback)success errorCallback:(TwitterRequestManagerErrorCallback)error
{
    JSWebServiceRequestParameters *parameters = [JSWebServiceRequestParameters emptyRequestParameters];
    [parameters setValue:search forKey:@"q"];
    
    JSWebServiceRequest *request = [[JSWebServiceRequest alloc] initWithType:JSWebServiceRequestTypeGET path:@"search.json" parameters:parameters];
    
    [_webProxy makeRequest:request withCacheKey:@"tweets" parseBlock:^id(NSArray *tweetDictionaries) {
        NSMutableArray *tweets = [NSMutableArray array];
        for (NSDictionary *tweetDictionary in tweetDictionaries)
        {
            Tweet *tweet = [[Tweet alloc] initWithDictionary:tweetDictionary];
            [tweets addObject:tweet];
        }
            
        return tweets;
    } success:success error:error];
}

#pragma mark - Memory Management

- (void)dealloc
{
    [_webProxy release];
    
    [super dealloc];
}
    
@end
