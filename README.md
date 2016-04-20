CAULY Tracking iOS SDK
===================

본 문서는  애드 네트워크 파트너 혹은 광고주가 SDK API를 통해 타게팅을 위한 정보를 제공 연동 규격을 정의합니다.

----------


|문서 버전	| 작성 날짜 		| 작성자 및 내용 |
 ---------- | ------------- | ------------
| 1.0.0 	| 2015.12.09	| 권대화(neilkwon@fsn.co.kr) - 초안작성 |
| 1.0.1 	| 2016.04.07	| 권대화(neilkwon@fsn.co.kr) - 업데이트 사항 반영 |


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
	   		- Custom Event
	    			- Name Only
	    			- name / single param
	    			- name / given parameters
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
Xcode 프로젝트의 info.plist 에 Cauly 에서 발급받은 track code를 추가합니다.
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
```<objective-c>
include/
	CaulyDefinedEvent.h
	CaulyTracker.h
	CaulyTrackerEvent.h
	PurchaseEvent.h
	TrackerConst.h

libCaulyTracker.so
```
#### Depedency
의존성이 있는 Framework을 Build Phases > Link Binary With Libraries 에 추가합니다.
```
AdSupport.framework
SystemConfiguration.framework
libCaulyTracker.so
```

### Cauly Tracker 초기화
| Method | mandatory | Description |
| --------- | ------------- | ------------- |
| setUserId | optional | 각 서비스를 사용하는 사용자의 고유 ID |
| setAge | optional | 사용자의 연령<br>연령 정보를 추가하면 더욱 세밀한 분석이 가능합니다.|
| setGender | optional | 사용자의 성별<br>성별 정보를 추가하면 더욱 세밀한 분석이 가능합니다. |

```objectivec
#import "CaulyTracker.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[CaulyTracker setAge:@"20"];
	[CaulyTracker setGender:CaulyGender_Male];
	[CaulyTracker setUserId:@"TestUserId_20151201"];
	...
}
```
----------

###  Webview를 사용하는 Hybrid App 참고사항
CaulyTracker Web SDK ( javascript version ) 을 사용는 Hybrid의 앱의 경우 App/Web의 더욱 정교한 Tracking 기능을 사용하고자 할 경우에는 [<i class="icon-file"></i> Cauly JS Interface For UIWebview](#CaulyJSInterfaceForUIWebview) section을 참조해주세요.
> UIWebView를 사용하는 Hybrid App이 아닌 일반 브라우저에서 접근가능한 Web의 경우에는 해당 메시지를 호출하지 않도록 조치를 해주어야 합니다.


----------

### Install check
최초 Application 실행시 Install 여부를 tracking 합니다.
Install Check는 앱의 최초 실행시에만 tracking 됩니다.
```
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
```
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
``` [CaulyTracker trackEvent:@"SAMPLE_EVENT_1"]; ``` 

##### name / single param
 ``` [CaulyTracker trackEvent:@"SAMPLE_EVENT_2" eventParam:@"MessageSent"]; ```  

##### name / given parameters
``` 
CaulyTrackerEvent* caulyTrackerEvent = [[CaulyTrackerEvent alloc] init];
caulyTrackerEvent.param1 = @"param1_value";
caulyTrackerEvent.param2 = @"param2_value";
caulyTrackerEvent.param4 = @"param3_value";
caulyTrackerEvent.param4 = @"param4_value";
[CaulyTracker trackEvent:@"SAMPLE_EVENT_4" caulyTrackerEvent:caulyTrackerEvent];
```

--------------

Cauly JS Interface For UIWebview
---------------------------------
### Inject javascript interface
WebView 의 Load가 끝나는 시점에 JavaScript Interface 를 등록합니다.
```
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

```
<script type="text/javascript">
// Return 방식
function getAdid() {
	if (window.caulyJSInterface) {
		var adid = window.caulyJSInterface.getAdId();
		if (caulyJSInterface.platform() == 'iOS') {
			$('#idfa').val(adid);
		} else {
			$('#gaid').val(adid);
		}
	}
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

