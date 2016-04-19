//
//  CaulyTrackerEvent.h
//  CaulyTracker
//
//  Created by Neil Kwon on 12/9/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaulyTrackerEvent : NSObject
@property NSString* param1;
@property NSString* param2;
@property NSString* param3;
@property NSString* param4;
@property NSDictionary* paramEtc;

-(NSDictionary*) getParameterDictionary;

@end

