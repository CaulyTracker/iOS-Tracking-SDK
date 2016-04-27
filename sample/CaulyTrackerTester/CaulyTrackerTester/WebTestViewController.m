//
//  WebTestViewController.m
//  CaulyTrackerTester
//
//  Created by Neil Kwon on 12/7/15.
//  Copyright © 2015 Cauly. All rights reserved.
//

#import "WebTestViewController.h"
#import "CaulyTracker.h"

#define REQUEST_TIMEOUT				(300)

@interface WebTestViewController ()

@end

@implementation WebTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CaulyTracker trackEvent:@"test"];
    
//    NSString* url = @"http://image.cauly.co.kr/richad/test/changju/stage/tracker/CaulyTrackingSample.html";
    NSString* url = @"http://image.cauly.co.kr/richad/test/changju/tracker/initadid/CaulyTrackingSample.html";
    
#if TARGET_IPHONE_SIMULATOR

#endif
    
    
    //    _webView.scalesPageToFit = YES;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:REQUEST_TIMEOUT]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didCloseBtnTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
    
}
- (IBAction)didReloadBtnTouchUpInside:(id)sender {
    
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    
//    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
//        
//        NSLog(@"%@",cookie);
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//        
//    }
    
    [_webView reload];
}

- (void)showIndicator:(BOOL)show {
    if(show) {
        if(_indicatorView == nil) {
            _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self.view addSubview:_indicatorView];
        }
        _indicatorView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
        [_indicatorView startAnimating];
        _indicatorView.hidden = NO;
    } else {
        [_indicatorView stopAnimating];
        _indicatorView.hidden = YES;
    }
}

#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id *)frame {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"확인" otherButtonTitles: nil];
    [alert show];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    [CaulyTracker callJSInterface:webView request:request];
    
    NSLog(@"LOAD");
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showIndicator:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self showIndicator:NO];
    
    [CaulyTracker setJSInterface:webView];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self showIndicator:NO];
    
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
