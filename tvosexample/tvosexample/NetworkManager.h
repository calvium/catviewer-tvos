//
// Created by Pablo Carrillo on 06/01/2016.
// Copyright (c) 2016 calvium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkManager : NSObject
+ (instancetype)instance;

- (NSInteger)catPageSize;

- (void)searchCats:(void (^) (NSDictionary *))completion;
@end