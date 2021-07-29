//
//  AppDelegate.m
//  FlurryStandardEventSampleiOS
//
//  Created by Hantao Yang on 7/28/21.
//

#import "AppDelegate.h"
@import Flurry_iOS_SDK;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // start Flurry session when app finished launching
    FlurrySessionBuilder *sb = [[[FlurrySessionBuilder new]
                                 withLogLevel:FlurryLogLevelAll]
                                withCrashReporting:YES];
    
    [Flurry startSession:@"GQ88TJBYGN46HMHXF65W" withSessionBuilder:sb];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
