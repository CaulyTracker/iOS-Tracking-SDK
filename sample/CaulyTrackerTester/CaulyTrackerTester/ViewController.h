//
//  ViewController.h
//  CaulyTrackerTester
//
//  Created by Neil Kwon on 12/7/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    NSArray* currencyArray;

}

@property (weak, nonatomic) IBOutlet UITextField *sigleEventName;
@property (weak, nonatomic) IBOutlet UITextField *sigleEventParam;
@property (weak, nonatomic) IBOutlet UIButton *sendSingleEvent;


@property (weak, nonatomic) IBOutlet UITextField *orderId;
@property (weak, nonatomic) IBOutlet UITextField *orderPrice;
@property (weak, nonatomic) IBOutlet UITextField *purchaseType;

@property (weak, nonatomic) IBOutlet UIButton *sendPurchaseEvent;

@property (weak, nonatomic) IBOutlet UIPickerView *purchaseCurrencyPicker;

@property (weak, nonatomic) IBOutlet UIButton *btnWebTest;

@end


