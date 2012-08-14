//
//  SORelativeDateTransformerTester
//
//  Created by StdOrbit on 12/6/10.
//  Copyright 2010 Standard Orbit Software, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "TesterViewController.h"

@implementation AppDelegate

@synthesize window = _window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    TesterViewController *rootController = [[TesterViewController alloc] initWithNibName:nil bundle:nil];
    
    [_window setRootViewController:rootController];
    [_window makeKeyAndVisible];
    
#if !__has_feature(objc_arc)
    [rootController release];
#endif

    return YES;
}

@end
