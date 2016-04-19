//
//  WebTestViewController.h
//  CaulyTrackerTester
//
//  Created by Neil Kwon on 12/7/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebTestViewController : UIViewController<UIWebViewDelegate>{
   	UIActivityIndicatorView * _indicatorView;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
