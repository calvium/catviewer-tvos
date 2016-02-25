//
// Created by Pablo Carrillo on 07/01/2016.
// Copyright (c) 2016 calvium. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MIN_TRANSITION_TIME 5
#define MEDIUM_TRANSITION_TIME 20
#define MAX_TRANSITION_TIME 60

@interface SettingsManager : NSObject
+ (BOOL)getAnimalSoundActiveValue;

+ (void)applyAnimalSoundActiveValue:(BOOL)active;

+ (NSInteger)getTransitionTimeValue;

+ (void)applyTransitionTime:(NSInteger)transitionTime;
@end