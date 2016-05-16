CAULY Tracking iOS SDK
===================

본 문서는  애드 네트워크 파트너 혹은 광고주가 SDK API를 통해 타게팅을 위한 정보를 제공 연동 규격을 정의합니다.

----------


|문서 버전	| 작성 날짜 		| 작성자 및 내용 |
 ---------- | ------------- | ------------
| 1.0.0 	| 2015.12.09	| 권대화(neilkwon@fsn.co.kr) - 초안작성 |
| 1.0.1 	| 2016.04.07	| 권대화(neilkwon@fsn.co.kr) - 업데이트 사항 반영 |
| 1.0.2 	| 2016.04.28	| 권대화(neilkwon@fsn.co.kr) - 업데이트 사항 반영 |
| 1.0.3 	| 2016.05.1	| 권대화(neilkwon at fsn.co.kr) - 업데이트 내역(Purchase / ContentView(Product) Event 추가) |
----------

### Table of contents

- CAULY Tracking iOS SDK
	- [연동 절차](#연동-절차)
 	- [SDK 적용](#sdk-적용)
	  	- [Xcode Project Setting](#xcode-project-setting)
	   		- info.plist
			- Static Library Import
	   		- Depedency
	  	- [Cauly Tracker 초기화](#cauly-tracker-초기화)
	  	- [Webview를 사용하는 Hybrid App 참고사항](#webview를-사용하는-hybrid-app-참고사항)
	  	- [Install check](#install-check)
	  	- [Session Start / Close](#session-start--close)
	  		- Sample
	  	- [Event](#event)
	   		- [Custom Event](#custom-event)
				- Name Only
				- name / single param
   			- [Defined Event](#defined-event)
	   			- Purchase
	   			- ContentView(Product)
 	- [Cauly JS Interface For UIWebview](#cauly-js-interface-for-uiwebview)
  		- Inject javascript interface
  		- Get Platform String
   			- sample
  		- Get ADID


----------

연동 절차
-------------

 1. 카울리 담당자 혹은 cauly@fsn.co.kr로 연락하여 트래킹 연동 광고주 파트너로 Track Code 발급을 요청하고 수신 합니다.
 2. SDK 적용법을 참고하여 구현하고 검증합니다.
 3. 카울리 담당자에게 SDK가 적용된 APK 파일을 전달 후 검증을 진행합니다.
검증 완료 후 배포 합니다. 

SDK 적용
-------------

### Xcode Project Setting
info.plist 파일에 아래의 CaulyTrackCode를 key로  발급받은 track_code를 삽입합니다.
예시의 '[CAULY_TRACK_CODE]'부분을 변경합니다. ( [] 기호는 불필요 )

#### info.plist
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
#### Static Library Import
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
#### Depedency
의존성이 있는 Framework을 Build Phases > Link Binary With Libraries 에 추가합니다.

```
AdSupport.framework
SystemConfiguration.framework
```

### Cauly Tracker 초기화
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

----------

###  Webview를 사용하는 Hybrid App 참고사항
CaulyTracker Web SDK ( javascript version ) 을 사용는 Hybrid의 앱의 경우 App/Web의 더욱 정교한 Tracking 기능을 사용하고자 할 경우에는 [<i class="icon-file"></i> Cauly JS Interface For UIWebview](#cauly-js-interface-for-uiwebview) section을 참조해주세요.
> UIWebView를 사용하는 Hybrid App이 아닌 일반 브라우저에서 접근가능한 Web의 경우에는 해당 메시지를 호출하지 않도록 조치를 해주어야 합니다.


----------

### Install check
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

### Session Start / Close
사용자의 앱에서의 Activity가 시작/종료 되는 시점에 호출합니다.
AppDelegate.m 파일의 Active/Terminate에 대한 Delegation이되는 시점에 호출하는 것을 권장합니다.
#### Sample

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

----------

### Event
사용자 또는 System에서 발생하는 Event를 Tracking 합니다.

#### Custom Event
Custom Event를 Tracking 합니다. Event 명과 parameter 모두 자유롭게 세팅가능합니다.

| Parameter | Required | Description |
| ----------- | ---------- | ------------- |
| event_name | mandatory | 트래킹할 이벤트명 |
| event_param | optional | 세부 정보 등 이벤트에 추가적으로 기입할 값 |

##### Name Only
```objectivec 
[CaulyTracker trackEvent:@"SAMPLE_EVENT_1"]; 
``` 

##### name / single param
 ```objectivec
[CaulyTracker trackEvent:@"SAMPLE_EVENT_2" eventParam:@"MessageSent"]; 
```  

#### Defined Event
자주 사용되거나 또는 중요하다 판단되는 Event에 대한 선정의된 Event입니다.

##### Purchase
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
##### ContentView(Product)
Content에 대한 트래킹
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

