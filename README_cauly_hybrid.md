Cauly 하이브리드 연동 가이드
=========================
iOS Native APP
--------------------------
### 개요
네이티브 앱은 obj-c 로 작성된 일반적인 iOS 앱을 지칭합니다. 본 문서는 광고주의 앱이 네이티브 앱일 경우 하이브리드 연동을 하는 방법에 대해서 설명하는 문서입니다. 컨텐츠 제공에 Webview 를 주로 사용한다면 [iOS Hybrid APP](https://github.com/CaulyTracker/iOS-Tracking-SDK-Hybrid) 문서를 참고해주세요. 

### 문서 버전 
|문서 버전	| 작성 날짜 		| 작성자 및 내용 |
 ---------- | ------------- | ------------
| 1.0.0 	| 2018.04.03	| 윤창주(yoonc1@fsn.co.kr) - 초안작성 |

----------

### 목차
- [연동 절차](#연동-절차)
- [연동 상세](#연동-상세)
  - [Reference](#reference)

--------------------------

### 연동 절차

1. 코드 삽입 이후 연동이 되었는지 Cauly에게 IPA 전달하여 테스트를 요청합니다.
1. Cauly에서 테스트를 완료하면 APP을 마켓에 업데이트하고 업데이트 내용을 Cauly와 공유합니다.

### 연동 상세
------------
#### Native APP SDK 연동
대상 OS 버전: iOS 7.1 이상


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

---------------------

#### Reference

#####  Webview를 사용하는 Hybrid App 참고사항
CaulyTracker Web SDK ( javascript version ) 을 사용는 Hybrid의 앱의 경우 App/Web의 더욱 정교한 Tracking 기능을 사용하고자 할 경우에는 [<i class="icon-file"></i> Cauly JS Interface For UIWebview](#cauly-js-interface-for-uiwebview) section을 참조해주세요.
> UIWebView를 사용하는 Hybrid App이 아닌 일반 브라우저에서 접근가능한 Web의 경우에는 해당 메시지를 호출하지 않도록 조치를 해주어야 합니다.

### Webview Link 클릭시 외부 브라우저 또는 Scheme 실행


```objectivec
#pragma mark - UIWebViewDelegate
...
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if([url.absoluteString rangeOfString:@"click.cauly.co.kr"].location != NSNotFound) {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }
}

...
```

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

