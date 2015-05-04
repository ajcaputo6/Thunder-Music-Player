//
//  ThunderMusicPlayerAppDelegate.h
//  ThunderMusicPlayer
//
//  Created by 14ACaputo on 5/15/14.
//  Copyright __MyCompanyName__ 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class ThunderMusicPlayerViewController;

@interface ThunderMusicPlayerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ThunderMusicPlayerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ThunderMusicPlayerViewController *viewController;

@end

