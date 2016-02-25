//
//  ImageViewer.m
//  tvosexample
//
//  Created by Pablo Carrillo on 06/01/2016.
//  Copyright © 2016 calvium. All rights reserved.
//

#import "ImageViewer.h"
#import "NetworkManager.h"
#import "UIImageView+AFNetworking.h"
#import "SettingsManager.h"
#import <AVFoundation/AVPlayer.h>

@interface ImageViewer ()
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) AVPlayer *audioPlayer;
@property(nonatomic, strong) NSOperationQueue *operationQueue;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) NSArray *arrayOfFlickrImages;
@property(nonatomic) BOOL playSounds;
@property(nonatomic) NSInteger transitionTime;
@end

@implementation ImageViewer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"Menu"];
    self.operationQueue = [NSOperationQueue mainQueue];
    self.playSounds = [SettingsManager getAnimalSoundActiveValue];
    self.transitionTime = [SettingsManager getTransitionTimeValue];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getFlickrImages];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    self.navigationController.navigationBarHidden = NO;
    [self.operationQueue cancelAllOperations];
    [self.operationQueue waitUntilAllOperationsAreFinished];
    self.operationQueue = nil;
    self.arrayOfFlickrImages = nil;
}

- (void)getFlickrImages {
    [[NetworkManager instance] searchCats:^(NSDictionary *dictionary) {
        self.arrayOfFlickrImages = dictionary[@"photos"][@"photo"];
        [self prepareAndFireTimer];

    }];
}

- (void)prepareAndFireTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.transitionTime * [[NetworkManager instance] catPageSize]
                                             target:self
                                           selector:@selector(showImagesInCarousel)
                                           userInfo:nil
                                            repeats:YES];
    self.timer = timer;

    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

- (void)showImagesInCarousel {
    [self.arrayOfFlickrImages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        __block NSNumber *index = @(idx);
        __block NSDictionary *item = obj;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * self.transitionTime * [index intValue]), dispatch_get_main_queue(), ^{
            NSURL *imageURL = [NSURL URLWithString:item[@"url_l"]];
            if (imageURL) {
                NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
                    [self showImageWithURL:imageURL];
                }];
                [self.operationQueue addOperation:blockOperation];
            }
        });
    }];
}

- (void)showImageWithURL:(NSURL *)imageURL {
    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:imageURL]
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       [UIView transitionWithView:self.imageView
                                                         duration:1.0f
                                                          options:UIViewAnimationOptionTransitionCrossDissolve
                                                       animations:^{
                                                           self.imageView.image = image;
                                                       } completion:^(BOOL finished) {
                                            if (finished && self.playSounds) {
                                                NSString *path = [[NSBundle mainBundle] pathForResource:@"meow"
                                                                                                 ofType:@"wav"];
                                                NSURL *url = [NSURL fileURLWithPath:path];
                                                self.audioPlayer = [[AVPlayer alloc] initWithURL:url];
                                                [self.audioPlayer play];
                                            }
                                        }];
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       NSLog(@"Error displaying image: %@", error);
                                   }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
