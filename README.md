Cauly 리타겟팅 연동 가이드
=========================
iOS Native APP
--------------------------
### 개요
네이티브 앱은 obj-c 로 작성된 일반적인 iOS 앱을 지칭합니다. 본 문서는 광고주의 앱이 네이티브 앱일 경우 리타겟팅 연동을 하는 방법에 대해서 설명하는 문서입니다. 컨텐츠 제공에 Webview 를 주로 사용한다면 [iOS Hybrid APP](https://github.com/CaulyTracker/iOS-Tracking-SDK-Hybrid) 문서를 참고해주세요. 

### 문서 버전 
|문서 버전	| 작성 날짜 		| 작성자 및 내용 |
 ---------- | ------------- | ------------
| 1.0.0 	| 2015.12.09	| 권대화(neilkwon@fsn.co.kr) - 초안작성 |
| 1.0.1 	| 2016.04.07	| 권대화(neilkwon@fsn.co.kr) - 업데이트 사항 반영 |
| 1.0.2 	| 2016.04.28	| 권대화(neilkwon@fsn.co.kr) - 업데이트 사항 반영 |
| 1.0.3 	| 2016.05.01	| 권대화(neilkwon@fsn.co.kr) - 업데이트 내역(Purchase/ContentView(Product) Event 추가) |
| 1.0.4 	| 2016.06.22	| 권대화(neilkwon@fsn.co.kr) - 업데이트 내역(BITCODE 관련/미사용 파일 삭제) |
| 1.0.5 	| 2016.07.04	| 권대화(neilkwon@fsn.co.kr) - 정밀성을 위한 추가 정보 전송 |
| 1.0.6         | 2016.09.22    | 권순국(nezy@fsn.co.kr) - 문서 레이아웃 변경 |
----------

### 목차
- [연동 절차](#연동-절차)
- [연동 상세](#연동-상세)
  - [Native APP SDK 연동](#native-app-sdk-연동)
  - [Deep Link 처리 (해당시에만)](#deeplink-처리-해당시에만)
  - [Event 처리](#event-처리)
  - [Reference](#reference)

--------------------------

### 연동 절차

1. Cauly 담당자 혹은 fsn_rt@fsn.co.kr로 연락하여 Cauly 리타겟팅 연동에 대해서 협의합니다.
1. 협의 완료 후, Cauly 담당자를 통해 track_code를 발급받습니다.
1. track_code 를 포함한 tracker 코드를 아래 ‘연동상세’을 참고하여 해당하는 부분에 해당하는 곳에 삽입합니다.
1. 코드 삽입 이후 연동이 되었는지 Cauly에게 IPA 전달하여 테스트를 요청합니다.
1. Cauly에서 테스트를 완료하면 APP을 마켓에 업데이트하고 업데이트 내용을 Cauly와 공유합니다.
1. 마켓 업데이트 완료 후 7일 뒤 (주말 및 공휴일 포함) 광고 라이브 가능합니다. (단, 모수가 너무 적을 경우 모수 수집을 위해 추가 시간이 소요될 수 있습니다.)

### 연동 상세
------------
#### Native APP SDK 연동
대상 OS 버전: iOS 7.1 이상

| 항목 | 세부항목 | 목적 | 연동 가이드 |
| ---------- | -------------- | ----------- | --------------- |
| Setting | info.plist |  | [Infoplist 부분 참고](#infoplist) |
|  | Library Import – header, .so 추가 |  | [Static-library-import 부분 참고](#static-library-import) |
|  | Framework 추가 |  | [dependency 부분 참고](#depedency) |
| 초기화 | | | [Cauly tracker 초기화 부분 참고](#cauly-tracker-초기화) |
| Session | Session | | [Session 부분 참고](#session-start--close) |

##### info.plist
info.plist 파일에 아래의 CaulyTrackCode를 key로  발급받은 track_code를 삽입합니다.
예시의 '[CAULY_TRACK_CODE]'부분을 변경합니다. ( [] 기호는 불필요 )
```
<?xml version="1.0" encoding="UTF-8"?>
...
<dict>
...
	<key>CaulyTrackCode</key>
	<string>[CAULY_TRACK_CODE]</string>	
...
</dict>
```
##### Static Library Import
CaulyTracker의 Header 파일과 .so 파일을 프로젝트에 import 합니다.

```
include/
	CaulyDefinedEvent.h
	CaulyTracker.h
	ContentViewEvent.h
	TrackerConst.h
	Product.h
	PurchaseEvent.h

libCaulyTracker.so
```
##### Depedency
의존성이 있는 Framework을 Build Phases > Link Binary With Libraries 에 추가합니다.

```
AdSupport.framework
SystemConfiguration.framework
```

##### Cauly Tracker 초기화
Tracker를 사용하고자 하는 View 또는 Source에서 아래와 같이 정보를 입력합니다.
각 정보는 해당하는 정보를 세팅할 수 있는 타이밍에 호출하면 됩니다.

| Function | Required | Description |
| --------- | ------------- | ------------- |
| setUserId | optional | 각 서비스를 사용하는 사용자의 고유 ID |
| setAge | optional | 사용자의 연령연령<br>정보를 추가하면 더욱 세밀한 분석이 가능합니다.|
| setGender | optional | 사용자의 성별<br>성별 정보를 추가하면 더욱 세밀한 분석이 가능합니다. |


```objectivec
#import "CaulyTracker.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[CaulyTracker setAge:@"20"];
	[CaulyTracker setGender:CaulyGender_Male];
	[CaulyTracker setUserId:@"UserId_20151201"];
	...
}
```

##### Session Start / Close
사용자의 앱에서의 Activity가 시작/종료 되는 시점에 호출합니다.
AppDelegate.m 파일의 Active/Terminate에 대한 Delegation이되는 시점에 호출하는 것을 권장합니다.

```objectivec
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [CaulyTracker startSession];
}
...
- (void)applicationWillTerminate:(UIApplication *)application {
    [CaulyTracker closeSession];
    [self saveContext];
}
```

#### DeepLink 처리 (해당시에만)
광고주의 APP이 Deep Link를 지원하여 유저가 광고를 클릭 했을 때 랜딩하는 위치가 APP의 메인 페이지가 아닌 다른 특정 페이지 (또는 상품상세페이지)인 경우에만 해당되는 사항입니다. 해당사항이 없을 경우 Event 처리 단계로 넘어갑니다.
```objectivec
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

    // 앱이 실행된 직후 설정
    [CaulyTracker traceDeepLink:url];
    // 이후 개별 로직 실행
    if([[url host] isEqualToString:@"caulytrackertest.com"]){
       ...

       return YES;
    }
    else{
        return NO;
    }
}
```

#### Event 처리
아래 2가지 캠페인 중 집행 예정인 캠페인에 맞게 code 를 삽입합니다.
- [A. Feed 캠페인](#a-feed-캠페인)
- [B. Static 캠페인](#b-static 켐페인)

#### A.	Feed 캠페인
| 이벤트명 | 목적 | 연동 가이드 |
| -------- | ----- | --------- |
| OPEN | - 리타겟팅 광고 노출 대상자 선정 | [OPEN 이벤트](#open-이벤트) |
| PRODUCT | - 광고노출 대상자 별 추천 상품목록 생성 | [상품 VIEW 이벤트](#상품-view-이벤트) |
| CART | - 광고노출 대상자 별 추천 상품목록 생성(option)  | [장바구니 이벤트](#장바구니-이벤트) |
| SEARCH | - 사용자의 검색어 (option) | [검색 이벤트](#검색-이벤트) |
| CONTENT | - 상품이미지 및 상품 상세정보를 광고 소재로 활용 | [ContentView 이벤트](#contentview-이벤트) |
| PURCHASE | - 추천상품에서 구매상품 제외 처리 <br>- ROAS 측정 | [PURCHASE 이벤트](#purchase-이벤트) |
| RE-PURCHASE | - 재구매율 측정 (option) | [RE-PURCHASE 이벤트](#re-purchase-이벤트) |

#### B. Static 캠페인
| 이벤트명 | 목적 | 연동 가이드 |
| -------- | ----- | --------- |
| OPEN | - 리타겟팅 광고 노출 대상자 선정 | [OPEN 이벤트](#open-이벤트) |
| CA_CONVERSION | - 전환 건수 측정 <br>- 예) 상담신청완료 등 | [CONVERSION 이벤트](#conversion-이벤트) |

##### OPEN 이벤트
```objectivec
[CaulyTracker trackEvent:@"OPEN"];
```

##### 상품 view 이벤트
```objectivec
NSString productId = @"987654321"; // 광고주의 product id 를 987654321 라 가정하면
[CaulyTracker trackEvent:@"PRODUCT" eventParam:productId];
```

##### 검색 이벤트
```objectivec
NSString searchWord = @"search_word"; // 사용자 검색어
[CaulyTracker trackEvent:@"SEARCH" eventParam:searchWord];
```

##### 장바구니 이벤트
```objectivec
NSString productId = @"987654321"; // 광고주의 product id 를 987654321 라 가정하면
[CaulyTracker trackEvent:@"CART" eventParam:productId];
```

##### ContentView 이벤트
```objectivec
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
```

##### PURCHASE 이벤트
```objectivec
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

##### Re-Purchase 이벤트
재구매(첫 구매가 아닌) 유저를 골라서 분류해보고 싶으면 아래처럼 한 줄 추가된 코드를 사용합니다.
```objectivec
PurchaseEvent* purchaseEvent = [[PurchaseEvent alloc] init];
purchaseEvent.orderId = @"order_20160430";
purchaseEvent.orderPrice = @"70000";
purchaseEvent.currecyCode = @"KRW";

// 아래 한 줄을 추가합니다
purchaseEvent.purchaseType = @"RE-PURCHASE";
// 한 줄 추가 끝

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

##### Conversion 이벤트
```objectivec
[CaulyTracker trackEvent:@"CA_CONVERSION"];
```

---------------------

#### Reference

#####  Webview를 사용하는 Hybrid App 참고사항
CaulyTracker Web SDK ( javascript version ) 을 사용는 Hybrid의 앱의 경우 App/Web의 더욱 정교한 Tracking 기능을 사용하고자 할 경우에는 [<i class="icon-file"></i> Cauly JS Interface For UIWebview](#cauly-js-interface-for-uiwebview) section을 참조해주세요.
> UIWebView를 사용하는 Hybrid App이 아닌 일반 브라우저에서 접근가능한 Web의 경우에는 해당 메시지를 호출하지 않도록 조치를 해주어야 합니다.

----------

##### Install check
최초 Application 실행시 Install 여부를 tracking 합니다.
Install Check는 앱의 최초 실행시에만 tracking 됩니다.

```objectivec
#import "CaulyTracker.h"
...
@implementation AppDelegate
...
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [CaulyTracker installCheck];
    
    return YES;
}
...
```
----------

##### Event
사용자 또는 System에서 발생하는 Event를 Tracking 합니다.

###### Custom Event
Custom Event를 Tracking 합니다. Event 명과 parameter 모두 자유롭게 세팅가능합니다.

| Parameter | Required | Description |
| ----------- | ---------- | ------------- |
| event_name | mandatory | 트래킹할 이벤트명 |
| event_param | optional | 세부 정보 등 이벤트에 추가적으로 기입할 값 |

####### Name Only
```objectivec 
[CaulyTracker trackEvent:@"SAMPLE_EVENT_1"]; 
``` 

####### name / single param
 ```objectivec
[CaulyTracker trackEvent:@"SAMPLE_EVENT_2" eventParam:@"MessageSent"]; 
```  

###### Defined Event
자주 사용되거나 또는 중요하다 판단되는 Event에 대한 선정의된 Event입니다.

####### Purchase
구매 또는 지불이 발생하였을때 호출

| Parameter | Type |Required | Default | Description |
| --------- | ---- | ------- | ------- | ----------- |
| order_id | String | mandatory | - | Order ID |
| order_price | String | mandatory | - | 발생한 전체 금액 |
| purchase_type | String | optional | - | 구매의 성격<br>eg)재구매 : RE-PURCHASE |
| product_infos | List<Product> | mandatory | - | 구매된 상품의 상세 정보 목록<br>최소 1개 이상 상품이 등록되어야 합니다. |
| currency_code | String | optional | KRW | 통화 코드 |

```objectivec
PurchaseEvent* purchaseEvent = [[PurchaseEvent alloc] init];
purchaseEvent.orderId = @"order_20160430";
purchaseEvent.orderPrice = @"70000";
purchaseEvent.currecyCode = @"KRW";

Product* product = [[Product alloc] init];
product.productId = @"p_0344411";
product.productPrice = @"20000";
product.productQuantity = @"3";
[purchaseEvent addProduct:product];

Product* product2 = [[Product alloc] init];
product2.productId = @"p_0344412";
product2.productPrice = @"10000";
product2.productQuantity = @"1";
[purchaseEvent addProduct:product2];

[CaulyTracker trackDefinedEvent:purchaseEvent];

```
####### ContentView(Product)
Content(Product)에 대한 트래킹 상품의 상세한 정보가 포함된 이벤트입니다.

```objectivec
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
```
--------------

Cauly JS Interface For UIWebview
---------------------------------
### Inject javascript interface
WebView 의 Load가 끝나는 시점에 JavaScript Interface 를 등록합니다.

```objectivec
#pragma mark - UIWebViewDelegate
...
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	...
    [CaulyTracker callJSInterface:webView request:request];
    ...
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    ...
    [CaulyTracker setJSInterface:webView];
    ...
}
...
```
### Get Platform String
Native SDK의 platform (Android / iOS) 값을 얻습니다. 리턴값은 ‘Android’ 또는 ‘iOS’ 입니다.
#### sample
```javascript
if(window.caulyJSInterface.platform() == 'Android'){
...
}else if(window.caulyJSInterface.platform() == 'iOS'){
...
}
```

### Get ADID
Apple OS에서 제공하는 Identity For Advertising (IDFA)를 Javascript에서 사용할 수 있습니다.
2가지 방식으로 구현할 수 있습니다.

!! Return 방식은 caulyJSInterface Object가 set되기 까지 딜레이가 있을 수 있습니다.
<br>window.setTimeout을 통해 약 50msec 정도 후에 사용하는 것을 권장합니다.

```javascript
<script type="text/javascript">
// Return 방식
function getAdid() {
	window.setTimeout(function(){
		if (window.caulyJSInterface) {
			var adid = window.caulyJSInterface.getAdId();
			if (caulyJSInterface.platform() == 'iOS') {
				$('#idfa').val(adid);
			} else {
				$('#gaid').val(adid);
			}
		}
	},50);
}

//Callback 방식
function getIdfa() {
	if (window.caulyJSInterface) {
		if (caulyJSInterface.platform() == 'iOS') {
			location.href = "caulyTrackerBridge://?getIdfa=true&callback=window.retIdfa";
		}
	}
}

window.retIdfa = function(idfa) {
	console.log(idfa);
	document.getElementById('idfa').innerText = idfa;
}

</script>
        
```

