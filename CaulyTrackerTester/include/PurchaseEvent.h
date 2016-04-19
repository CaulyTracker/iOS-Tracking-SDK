//
//  PurchaseEvent.h
//  CaulyTracker
//
//  Created by Neil Kwon on 11/30/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackerConst.h"
#import "CaulyDefinedEvent.h"


@interface PurchaseEvent : CaulyDefinedEvent

@property NSString* productName;
@property (nonatomic, setter=setUnitPrice:) NSString* unitPrice;
@property (nonatomic, setter=setQuantity:) NSString* quantity;
@property (nonatomic, setter=setRevenue:) NSString* revenue;
@property NSString* currecyCode;

@end
