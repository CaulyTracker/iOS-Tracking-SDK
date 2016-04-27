//
//  CaulyTracker.h
//  CaulyTracker
//
//  Created by Neil Kwon on 11/19/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackerConst.h"
#import "CaulyDefinedEvent.h"
#import "CaulyTrackerEvent.h"
#import <UIKit/UIKit.h>

@interface CaulyTracker : NSObject
+(void) testInstallCheck;
+(void) installCheck;
+(void) setUserId:(NSString*) userId;
+(void) setAge:(NSString*) age;
+(void) setGender:(CaulyGender) gender;
+(void) startSession;
+(void) closeSession;
+(void) trackEvent:(NSString*) eventName;
+(void) trackEvent:(NSString*) eventName eventParam:(NSString*)eventParam;
+(void) trackEvent:(NSString*) eventName caulyTrackerEvent:(CaulyTrackerEvent*) caulyTrackerEvent;
+(void) trackDefinedEvent:(CaulyDefinedEvent*) definedEvent;
+(void) traceDeepLink:(NSURL*) url;
+(NSString*) setJSInterface:(UIWebView*)webView;
+(NSString*) callJSInterface:(UIWebView*) webView request:(NSURLRequest *)request;
@end
