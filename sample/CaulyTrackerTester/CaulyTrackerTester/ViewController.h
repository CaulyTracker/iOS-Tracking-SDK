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
@property (weak, nonatomic) IBOutlet UIButton *btnProduct;


@property (weak, nonatomic) IBOutlet UILabel *productState;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productCategory;
@property (weak, nonatomic) IBOutlet UILabel *productCategory2;
@property (weak, nonatomic) IBOutlet UILabel *productItemName;
@property (weak, nonatomic) IBOutlet UILabel *productOriginalPrice;
@property (weak, nonatomic) IBOutlet UILabel *productSalePrice;
@property (weak, nonatomic) IBOutlet UILabel *productItemStock;
@property (weak, nonatomic) IBOutlet UITextView *productDescription;



@end


