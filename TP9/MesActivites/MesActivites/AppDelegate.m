//
//  AppDelegate.m
//  MesActivites
//
//  Created by ilyas TOUMLILT on 22/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "AppDelegate.h"
#import "MASplitViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MASplitViewController *mySVC = [[MASplitViewController alloc] init];
    
    UINavigationController *nmvc = [[UINavigationController alloc] initWithRootViewController:mySVC.masterVC];
    UINavigationController *ndvc = [[UINavigationController alloc] initWithRootViewController:mySVC.detailsVC];
    
    [mySVC setViewControllers:[NSArray arrayWithObjects:nmvc, ndvc, nil]];
    [mySVC setDelegate:mySVC.masterVC];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&[[UIScreen mainScreen] scale] != 3.0) {
        
        UINavigationController *nc1;
        nc1 = [[UINavigationController alloc] init];
        [nc1.navigationBar setTintColor:[UIColor blackColor]];
        
        UIViewController *viewController1 = [[MAMasterViewController alloc] init];
        viewController1.tabBarItem= [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
        nc1.viewControllers = [NSArray arrayWithObjects:viewController1, nil];
        
        UINavigationController *nc2;
        nc2 = [[UINavigationController alloc] init];
        [nc2 setTitle:@"Musique"];
        nc2.tabBarItem.image = [UIImage imageNamed:@"tete-a-toto"];
        [nc2.navigationBar setTintColor:[UIColor blackColor]];
        
        UIViewController *viewController2 = [[MADetailsViewController alloc] init];
        nc2.viewControllers = [NSArray arrayWithObjects:viewController2, nil];
        
        self.tabBarController = [[[UITabBarController alloc] init] autorelease];
        self.tabBarController.viewControllers = [NSArray arrayWithObjects:nc2, nc1,nil];
        
        self.window.rootViewController = self.tabBarController;
        [self.window makeKeyAndVisible];
    } else {
        [_window setRootViewController:mySVC];
        [mySVC setPreferredDisplayMode:UISplitViewControllerDisplayModeAutomatic];
        if ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height) {
            // N'afficher le bouton qu'en mode portrait
            [[[ndvc topViewController] navigationItem] setLeftBarButtonItem:[mySVC displayModeButtonItem]];
            [[[ndvc topViewController] navigationItem] setLeftItemsSupplementBackButton:YES];
        }
    }
    [_window makeKeyAndVisible];
    
    // releasing stuff
    [nmvc release];
    [ndvc release];
    [mySVC release];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
