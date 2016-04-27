//
//  TestViewController.m
//  CaulyTrackerTester
//
//  Created by Neil Kwon on 12/9/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import "TestViewController.h"
#import "CaulyTracker.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [CaulyTracker trackEvent:@"gggg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
