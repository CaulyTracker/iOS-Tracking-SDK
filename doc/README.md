Cauly 리타겟팅 iOS 연동 가이드
=========================

--------------------------
### 개요
이 문서는 광고주가 Cauly 와 feed 형 리타겟팅 연동을 할 때 iOS tracking SDK 를 삽입하는 방법에 대해서 설명하는 문서입니다.

### 문서 버전 
| 문서 버전 | 작성 날짜 | 작성자 및 내용|
 --- | --- | --- 
| 1.0.0 | 2016. 04. 26. | 권순국(nezy@fsn.co.kr) 초안 작성|



### 목차
- [연동 절차](#연동-절차)
- [연동 상세](#연동-상세)


### 연동 절차
1. Cauly 담당자 혹은 cauly@fsn.co.kr로 연락하여 Cauly 리타겟팅 연동에 대해서 협의합니다.
1. 협의 완료 후, track_code 를 발급받습니다.
1. track_code 를 포함한 tracker 코드를 iOS 앱의 필요한 곳에 삽입합니다.
1. 코드 삽입 이후 연동이 되었는지 Cauly 에서 테스트를 진행합니다.
1. 테스트가 완료되면 광고를 집행합니다.


### 연동 상세

- Setting
 - info.plist: https://github.com/CaulyTracker/iOS-Tracking-SDK#infoplist
 - Library Import
   - header, .so 추가: https://github.com/CaulyTracker/iOS-Tracking-SDK#static-library-import
    - Framework 추가: https://github.com/CaulyTracker/iOS-Tracking-SDK#depedency
- 초기화: https://github.com/CaulyTracker/iOS-Tracking-SDK#cauly-tracker-초기화
- Session: https://github.com/CaulyTracker/iOS-Tracking-SDK#session-start--close

#### DeepLink 처리
```objectivec
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    [CaulyTracker traceDeepLink:url];
    if([[url host] isEqualToString:@"caulytrackertest.com"]){
       ...
        
       return YES;
    }
    else{
        return NO;
    }
}

```

#### Event 전송
##### OPEN 이벤트
```objc
[CaulyTracker trackEvent:@"OPEN"];
```
##### 상품 view 이벤트
```objc
NSString productId = @"987654321"; // 광고주의 product id 를 987654321 라 가정하면
[CaulyTracker trackEvent:@"PRODUCT" eventParam:productId];
```
##### Conversion 이벤트
```objc
[CaulyTracker trackEvent:@"CA_APPLY"];
```

##### Purchase 이벤트
```objc
// 유저가 구매한 20000원짜리 (product id "987654321") 3개와 10000원짜리 (product id "887654321") 1개를 샀고,
// 그래서 총 구매액은 70000원이고,
// 광고주가 발급한 구매 id(order id) 가 "order_20160430" 라고 가정하면,
PurchaseEvent* purchaseEvent = [[PurchaseEvent alloc] init];
purchaseEvent.orderId = @"order_20160430";
purchaseEvent.orderPrice = @"70000";
purchaseEvent.currecyCode = @"KRW";

Product* product = [[Product alloc] init];
product.productId = @"987654321";
product.productPrice = @"20000";
product.productQuantity = @"3";
[purchaseEvent addProduct:product];

Product* product2 = [[Product alloc] init];
product2.productId = @"887654321";
product2.productPrice = @"10000";
product2.productQuantity = @"1";
[purchaseEvent addProduct:product2];

[CaulyTracker trackDefinedEvent:purchaseEvent];
```
상세 설명: https://github.com/CaulyTracker/iOS-Tracking-SDK#purchase
