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
#import "Product.h"


@interface PurchaseEvent : CaulyDefinedEvent

@property (nonatomic) NSString* orderId;
@property (nonatomic) NSString* orderPrice;
@property (nonatomic) NSString* purchaseType;
@property (nonatomic) NSMutableArray* productInfos;
@property NSString* currecyCode;

-(void) addProduct:(Product*) product;
@end
