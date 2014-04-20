//
//  GNAppDelegate.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNAppDelegate.h"

@implementation GNAppDelegate

-(void)findFonts {
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray* fontFiles = [infoDict objectForKey:@"UIAppFonts"];
    
    for (NSString *fontFile in fontFiles) {
        
        NSLog(@"file name: %@", fontFile);
        NSURL *url = [[NSBundle mainBundle] URLForResource:fontFile withExtension:NULL];
        NSData *fontData = [NSData dataWithContentsOfURL:url];
        CGDataProviderRef fontDataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)fontData);
        CGFontRef loadedFont = CGFontCreateWithDataProvider(fontDataProvider);
        NSString *fullName = CFBridgingRelease(CGFontCopyFullName(loadedFont));
        CGFontRelease(loadedFont);
        CGDataProviderRelease(fontDataProvider);
        NSLog(@"font name: [%@]", fullName);
    }
    
    
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self findFonts];
    
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"win.wav" ofType:nil] forKey:@"win"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"selected.wav" ofType:nil] forKey:@"selected"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"opener.wav" ofType:nil] forKey:@"opener"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
