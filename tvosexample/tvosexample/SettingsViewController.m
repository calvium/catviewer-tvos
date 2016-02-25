//
// Created by Pablo Carrillo on 07/01/2016.
// Copyright (c) 2016 calvium. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsManager.h"

@interface SettingsViewController ()
@property(weak, nonatomic) IBOutlet UISegmentedControl *soundSegmentedControl;
@property(weak, nonatomic) IBOutlet UISegmentedControl *transitionTimeSegmentedControl;
@end

@implementation SettingsViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL soundActive = [SettingsManager getAnimalSoundActiveValue];
    if (soundActive) {
        [self.soundSegmentedControl setSelectedSegmentIndex:0];
    } else {
        [self.soundSegmentedControl setSelectedSegmentIndex:1];
    }
    NSInteger transitionTime = [SettingsManager getTransitionTimeValue];
    switch (transitionTime) {
        case MIN_TRANSITION_TIME:
            self.transitionTimeSegmentedControl.selectedSegmentIndex = 0;
            break;
        case MEDIUM_TRANSITION_TIME:
            self.transitionTimeSegmentedControl.selectedSegmentIndex = 1;
            break;
        default:
            self.transitionTimeSegmentedControl.selectedSegmentIndex = 2;
            break;
    }
}

#pragma mark - user interactions

- (IBAction)soundSegmentedControlValueChanged:(UISegmentedControl *)sender {
    [SettingsManager applyAnimalSoundActiveValue:sender.selectedSegmentIndex == 0 ? YES : NO];
}

- (IBAction)transitionTimeSegmentedControlValueChanged:(UISegmentedControl *)sender {
    NSInteger transitionTime = 0;
    switch (sender.selectedSegmentIndex) {
        case 0:
            transitionTime = MIN_TRANSITION_TIME;
            break;
        case 1:
            transitionTime = MEDIUM_TRANSITION_TIME;
            break;
        default:
            transitionTime = MAX_TRANSITION_TIME;
            break;
    }
    [SettingsManager applyTransitionTime:transitionTime];;
}
@end