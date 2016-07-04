//
//  Product.h
//  CaulyTracker
//
//  Created by Neil Kwon on 4/25/16.
//  Copyright © 2016 Cauly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) NSString* productId;
@property (nonatomic) NSString* productPrice;
@property (nonatomic) NSString* productQuantity;

- (NSDictionary*) toJson;

@end
