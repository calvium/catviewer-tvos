//
// Created by Pablo Carrillo on 07/01/2016.
// Copyright (c) 2016 calvium. All rights reserved.
//

#import "SettingsManager.h"

#define ANIMAL_SOUNDS_KEY @"animalSounds"

#define TRANSITION_TIME_KEY @"transitionTime"

@implementation SettingsManager {

}

+ (BOOL)getAnimalSoundActiveValue {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [[settings valueForKey:ANIMAL_SOUNDS_KEY] boolValue];
}

+ (void)applyAnimalSoundActiveValue:(BOOL)active {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setBool:active forKey:ANIMAL_SOUNDS_KEY];
    [settings synchronize];
}

+ (NSInteger)getTransitionTimeValue {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSInteger transitionTime = [[settings valueForKey:TRANSITION_TIME_KEY] integerValue];
    if (transitionTime < MIN_TRANSITION_TIME) {
        transitionTime = MIN_TRANSITION_TIME;
    }
    return transitionTime;
}

+ (void)applyTransitionTime:(NSInteger)transitionTime{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger:transitionTime forKey:TRANSITION_TIME_KEY];
    [settings synchronize];
}
@end