//
//  ContentViewEvent.h
//  CaulyTracker
//
//  Created by Neil Kwon on 5/11/16.
//  Copyright © 2016 Cauly. All rights reserved.
//

#import "CaulyDefinedEvent.h"

extern NSString *const ContentViewEventDetailParameterNameCategory3;
extern NSString *const ContentViewEventDetailParameterNameCategory4;
extern NSString *const ContentViewEventDetailParameterNameCategory5;
extern NSString *const ContentViewEventDetailParameterNameRegDate;
extern NSString *const ContentViewEventDetailParameterNameUpdateDate;
extern NSString *const ContentViewEventDetailParameterNameExpireDate;
extern NSString *const ContentViewEventDetailParameterNameStock;
extern NSString *const ContentViewEventDetailParameterNameState;
extern NSString *const ContentViewEventDetailParameterNameDescription;
extern NSString *const ContentViewEventDetailParameterNameExtraImage;
extern NSString *const ContentViewEventDetailParameterNameLocale;

@interface ContentViewEvent : CaulyDefinedEvent{
    
}

@property (nonatomic) NSString* itemId;
@property (nonatomic) NSString* itemName;
@property (nonatomic) NSString* itemImage;
@property (nonatomic) NSString* itemUrl;
@property (nonatomic) NSString* originalPrice;
@property (nonatomic) NSString* salePrice;
@property (nonatomic) NSString* category1;
@property (nonatomic) NSString* category2;

-(instancetype)initWithItemId : (NSString*) itemId;
-(instancetype)initWithTypeAndItemId : (NSString*) type  itemId : (NSString*) itemId;
-(void)setDetailParam : (NSString*) paramName value : (NSString*) value;

@end
