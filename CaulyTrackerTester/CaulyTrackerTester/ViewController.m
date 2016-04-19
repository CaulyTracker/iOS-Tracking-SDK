//
//  ViewController.m
//  CaulyTrackerTester
//
//  Created by Neil Kwon on 12/7/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import "ViewController.h"
#import "CaulyTracker.h"
#import "PurchaseEvent.h"
#import "CaulyTrackerEvent.h"
#import "WebTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CaulyTracker setAge:@"20"];
    [CaulyTracker setGender:CaulyGender_Male];
    [CaulyTracker setUserId:@"neilTestUserId_20151201"];
    // Do any additional setup after loading the view, typically from a nib.
    
    currencyArray=[[NSArray alloc] initWithObjects:CURRENCY_USD,CURRENCY_THB,CURRENCY_KRW, CURRENCY_JPY, CURRENCY_CNY,nil];
    
    
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
    
    NSMutableDictionary* test = [[NSMutableDictionary alloc]init];
    CaulyTrackerEvent* caulyTrackerEvent = [[CaulyTrackerEvent alloc] init];
    
    
    switch (sender.tag) {
        case 0:
            [CaulyTracker trackEvent:@"SAMPLE_EVENT_1"];
            break;
        case 1:
            [CaulyTracker trackEvent:@"SAMPLE_EVENT_2" eventParam:@"WHY"];
            break;
        case 2:
            // NOT SUPPORTED YET
//            test[@"why"] = @"forFun";
//            [CaulyTracker trackEvent:@"SAMPLE_EVENT_3" eventParams:[NSDictionary dictionaryWithDictionary:test]];
            break;
        case 3:
            // NOT SUPPORTED YET
//            test[@"achieved"] = @"level";
//            test[@"value"] = @"20";
//            [CaulyTracker trackEvent:@"SAMPLE_EVENT_4" eventParams:[NSDictionary dictionaryWithDictionary:test]];
            break;
        case 4:
            caulyTrackerEvent.param1 = @"param1_value";
            caulyTrackerEvent.param2 = @"param2_value";
            caulyTrackerEvent.param4 = @"param4_value";
            [CaulyTracker trackEvent:@"SAMPLE_EVENT_4" caulyTrackerEvent:caulyTrackerEvent];
            break;
        case 5:
            caulyTrackerEvent.param1 = @"param1_value";
            caulyTrackerEvent.param2 = @"param2_value";
            caulyTrackerEvent.param4 = @"param4_value";
            
            test[@"resson"] = @"explode";
            
            caulyTrackerEvent.paramEtc = test;
            [CaulyTracker trackEvent:@"SAMPLE_EVENT_5" caulyTrackerEvent:caulyTrackerEvent];

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
        
        purchaseEvent.productName = _purchaseProductName.text;
        
        @try{
            purchaseEvent.unitPrice = _purchaseUnitPrice.text;
        } @catch (NSException *exception) {
            _purchaseUnitPrice.text = exception.reason;
        }
        
        @try{
            purchaseEvent.quantity = _purchaseQuantity.text;
        }@catch (NSException *exception) {
            _purchaseQuantity.text = exception.reason;
        }
        @try{
            purchaseEvent.revenue = _purchaseRevenue.text;
        }@catch (NSException *exception) {
            _purchaseRevenue.text = exception.reason;
        }
        
        purchaseEvent.currecyCode = [currencyArray objectAtIndex:[_purchaseCurrencyPicker selectedRowInComponent:0]];
        
        [CaulyTracker trackDefinedEvent:purchaseEvent];
        
        
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.name);
        NSLog(@"%@", exception.reason);
        
    }
    @finally {
        
    }
    
}

#pragma PickerView

// 필수 사용메소드 2개 : 이 작업을 하면 피커에 데이터가 들어간다.
// 피커를 사용하기 위해 반드시 사용되어야 할 필수 메소드이다.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// 피커를 사용하기 위해 반드시 사용되어야 할 필수 메소드이다.
- (NSInteger)pickerView:(UIPickerView *) pickerView numberOfRowsInComponent : (NSInteger)component{
    if (component == 0) {
        return [currencyArray count]; // 0번째 컴퍼넌트의 들어갈 데이터 소스의 수를 반환한다.
    }
    return 0;
}

// 피커를 사용하기 위해 반드시 사용되어야 할 필수 델리게이트이다.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component{
    switch (component) {
        case 0:
            return [currencyArray objectAtIndex:row]; //0번째 컴퍼넌트의 선택된 문자열을 반환한다.
            
    }
    return nil;
}


@end
