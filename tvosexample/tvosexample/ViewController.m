//
//  ViewController.m
//  tvosexample
//
//  Created by Pablo Carrillo on 06/01/2016.
//  Copyright © 2016 calvium. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewer.h"
#import "SettingsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *catButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.backgroundImageView.image = [UIImage imageNamed:@"Menu"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user interactions
- (IBAction)catButtonTapped:(id)sender {
    ImageViewer * viewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ImageViewer class])];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)aboutButtonTapped:(id)sender {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Made by Calvium" message:@"This app was made by Calvium Ltd. for Learning purposes." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)settingsButtonTapped:(id)sender {
    ImageViewer * viewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SettingsViewController class])];
    [self.navigationController presentViewController:viewController
                                            animated:YES
                                          completion:nil];
}
@end
