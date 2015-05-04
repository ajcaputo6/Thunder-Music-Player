//
//  ThunderMusicPlayerAppDelegate.m
//  ThunderMusicPlayer
//
//  Created by 14ACaputo on 5/15/14.
//  Copyright __MyCompanyName__ 2014. All rights reserved.
//

#import "ThunderMusicPlayerAppDelegate.h"
#import "ThunderMusicPlayerViewController.h"

@implementation ThunderMusicPlayerAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
