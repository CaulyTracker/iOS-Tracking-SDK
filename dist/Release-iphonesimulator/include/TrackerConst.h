//
//  TrackerConst.h
//  CaulyTracker
//
//  Created by Neil Kwon on 11/19/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import <Foundation/Foundation.h>


# define CAULY_SDK_VERSION (@"1.0.8")
// Log 레벨

static NSString* CURRENCY_KRW = @"KRW";
static NSString* CURRENCY_USD = @"USD";
static NSString* CURRENCY_CNY = @"CNY";
static NSString* CURRENCY_THB = @"THB";
static NSString* CURRENCY_JPY = @"JPY";

// 성별 설정
typedef enum {
    CaulyGender_Male,		// Male
    CaulyGender_Female,		// Female
    CaulyGender_Unknown,	// Unknown
    CaulyGender_All			// Whole
} CaulyGender;


// Log 레벨
typedef enum {
    CaulyLogLevelMinimal,
    CaulyLogLevelRelease,
    CaulyLogLevelDebug,
    CaulyLogLevelAll
} CaulyLogLevel;

#define CaulyError_OK					(0)
#define CaulyError_INVAILD_TRACK_CODE	(400)
#define CaulyError_SERVER_ERROR			(500)
#define CaulyError_SDK_INNER_ERROR		(-100)
