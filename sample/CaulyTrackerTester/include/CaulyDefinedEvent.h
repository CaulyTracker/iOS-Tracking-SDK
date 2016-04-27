//
//  CaulyDefinedEvent.h
//  CaulyTracker
//
//  Created by Neil Kwon on 11/30/15.
//  Copyright © 2015 Cauly. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface CaulyDefinedEvent : NSObject{
    NSString* eventName;
}

-(NSString*) eventName;
-(NSDictionary*) getParameterDictionary;
@end

