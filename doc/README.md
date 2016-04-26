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
1. 협의 완료 후, site_code 를 발급받습니다.
1. site_code 를 포함한 tracker 코드를 iOS 앱의 필요한 곳에 삽입합니다.
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
```objc
// 아래 String 처럼 DeekLink 가 들어왔다고 가정하면
// NSString deepLinkStr = @"someapp://app/?cauly_rt_code=1234&cauly_egmt_sec=8600"; 
[CaulyTracker traceDeepLink:deepLinkStr];
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