//
// Created by Pablo Carrillo on 06/01/2016.
// Copyright (c) 2016 calvium. All rights reserved.
//

#import "NetworkManager.h"
#import "API_Key_Header.h"

#define PER_PAGE 100

@interface NetworkManager ()
@property(nonatomic, strong) AFURLSessionManager *manager;
@property(nonatomic, strong) AFURLSessionManager *imageManager;
@end

@implementation NetworkManager {

}

+ (instancetype)instance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [self.manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    self.imageManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [self.imageManager setResponseSerializer:[AFImageResponseSerializer serializer]];
    return self;
}

- (NSInteger)catPageSize {
    return PER_PAGE;
}

- (void)searchCats:(void (^) (NSDictionary *))completion {
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=cat%%2Cfluffy&tag_mode=all&safe_search=1&per_page=%@&page=1&media=photos&extras=url_o%%2Curl_l&format=json&nojsoncallback=1", FLICKER_API_KEY,
                                                     @(PER_PAGE)];
    NSURL *url = [NSURL URLWithString:urlString];
    [[self.manager dataTaskWithRequest:[NSURLRequest requestWithURL:url]
                     completionHandler:^(NSURLResponse *response, NSDictionary *responseObject, NSError *error) {
                         completion(responseObject);
                     }] resume];

}

@end