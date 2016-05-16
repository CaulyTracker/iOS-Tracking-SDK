//
//  ViewController.m
//  CaulyTrackerTester
//
//  Created by Neil Kwon on 12/7/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import "ViewController.h"
#import "CaulyTracker.h"
#import "Product.h"
#import "PurchaseEvent.h"
#import "ContentViewEvent.h"
#import "CaulyTrackerEvent.h"
#import "WebTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CaulyTracker setAge:@"20"];
    [CaulyTracker setGender:CaulyGender_Male];
    [CaulyTracker setUserId:@"TestUserId_20151201"];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    currencyArray=[[NSArray alloc] initWithObjects:CURRENCY_USD,CURRENCY_THB,CURRENCY_KRW, CURRENCY_JPY, CURRENCY_CNY,nil];
    
    
    NSURL *url = [NSURL URLWithString:@"https://www.cauly.net/images/logo_cauly_main.png"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    [_productImage autoresizingMask];
    [_productImage setImage:image];
    
    
    _productCategory.text = @"생활물품";
    _productCategory2.text = @"구급";
    _productItemName.text = @"[오늘의 특가] 카울리 반창고!";
    _productOriginalPrice.text = @"KRW 24000";
    _productSalePrice.text = @"KRW 18000";
    
    NSAttributedString * title =
    [[NSAttributedString alloc] initWithString:@"KRW 24000"
                                    attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [_productOriginalPrice setAttributedText:title];
    
    _productItemStock.text = @"재고 10개";
    _productDescription.text = @" 한번 사용하면 멈출 수 없는 쫄깃함 !";
    _productState.text = @"판매중";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTouchUpInsideSessionStart:(id)sender {
    [CaulyTracker startSession];
}

- (IBAction)didTouchUpInsideSessionClose:(id)sender {
    [CaulyTracker closeSession];
}

- (IBAction)didTouchUpInsideInstall:(id)sender {
    [CaulyTracker testInstallCheck];
}

- (IBAction)didTouchUpInsideWebTest:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"WebTest" bundle:[NSBundle mainBundle]];
    
    
    WebTestViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"WebTest"];
    [dvc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:dvc animated:YES completion:nil];
}

- (IBAction)didTouchUpInsideSingleEventBtn:(id)sender {
    
    
    [CaulyTracker setAge:@"21"];
    [CaulyTracker setGender:CaulyGender_Female];
    
    
    NSString* eventName = _sigleEventName.text;
    NSString* eventParam = _sigleEventParam.text;
    
    @try {
        [CaulyTracker trackEvent:eventName eventParam:eventParam];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    }
    @finally {
        
    }
    
    
}

- (IBAction)didTouchUpInsideSampleEventBtns:(UIButton *)sender {
    
    
    switch (sender.tag) {
        case 0:
            [CaulyTracker trackEvent:@"SAMPLE_EVENT_1"];
            break;
        case 1:
            [CaulyTracker trackEvent:@"SAMPLE_EVENT_2" eventParam:@"WHY"];
            break;
        default:
            break;
    }
}


- (IBAction)didTouchUpInsidePurchaseEventBtn:(id)sender {
    
    @try{
        
        [CaulyTracker setAge:@"22"];
        [CaulyTracker setGender:CaulyGender_Unknown];
        
        
        PurchaseEvent* purchaseEvent = [[PurchaseEvent alloc] init];
        
        purchaseEvent.orderId = _orderId.text;
        
        @try{
            purchaseEvent.orderPrice = _orderPrice.text;
        } @catch (NSException *exception) {
            _orderPrice.text = exception.reason;
        }
        
        @try{
            purchaseEvent.purchaseType = _purchaseType.text;
        }@catch (NSException *exception) {
            _purchaseType.text = exception.reason;
        }
        
        
        purchaseEvent.currecyCode = [currencyArray objectAtIndex:[_purchaseCurrencyPicker selectedRowInComponent:0]];
        
        Product* product = [[Product alloc] init];
        product.productId = @"p_0344411&*#$^";
        product.productPrice = @"20000";
        product.productQuantity = @"3";
        [purchaseEvent addProduct:product];
        
        
        Product* product2 = [[Product alloc] init];
        product2.productId = @"p_0344412양";
        product2.productPrice = @"10000";
        product2.productQuantity = @"13";
        
        [purchaseEvent addProduct:product2];
        
        [CaulyTracker trackDefinedEvent:purchaseEvent];
        
        
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.name);
        NSLog(@"%@", exception.reason);
        
    }
    @finally {
        
    }
    
}
- (IBAction)didTouchUpInsideProductEventBtn:(id)sender {
    
    
    ContentViewEvent* contentViewEvent = [[ContentViewEvent alloc] initWithItemId:@"test_item_1"];
    contentViewEvent.itemName = @"[오늘의 특가] 카울리 반창고!";
    contentViewEvent.itemImage = @"https://www.cauly.net/images/logo_cauly_main.png";
    contentViewEvent.itemUrl = @"caulytrackertest://caulytracker.com/product?item_id=p20160510_test_1";
    contentViewEvent.originalPrice = @"24000";
    contentViewEvent.salePrice = @"18000";
    contentViewEvent.category1 = @"생활물품";
    contentViewEvent.category2 = @"구급";
    
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameCategory3 value:@""];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameCategory4 value:@""];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameCategory5 value:@""];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameRegDate value:@""];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameUpdateDate value:@""];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameExpireDate value:@""];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameStock value:@"10"];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameState value:@"available"];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameDescription value:@" 한번 사용하면 멈출 수 없는 쫄깃함 !"];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameExtraImage value:@""];
    [contentViewEvent setDetailParam:ContentViewEventDetailParameterNameLocale value:@"KRW"];
    
    [CaulyTracker trackDefinedEvent:contentViewEvent];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma PickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *) pickerView numberOfRowsInComponent : (NSInteger)component{
    if (component == 0) {
        return [currencyArray count];
    }
    return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component{
    switch (component) {
        case 0:
            return [currencyArray objectAtIndex:row];
            
    }
    return nil;
}


@end
