---
标题: XGPush
描述: Tencent xinge message push.
---
<!---
# license: Licensed to the Apache Software Foundation (ASF) under one
#         or more contributor license agreements.  See the NOTICE file
#         distributed with this work for additional information
#         regarding copyright ownership.  The ASF licenses this file
#         to you under the Apache License, Version 2.0 (the
#         "License"); you may not use this file except in compliance
#         with the License.  You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#         Unless required by applicable law or agreed to in writing,
#         software distributed under the License is distributed on an
#         "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#         KIND, either express or implied.  See the License for the
#         specific language governing permissions and limitations
#         under the License.
-->

**`提示: 由于腾讯已经将信鸽项目与腾讯云合并，因此插件已经不能使用。`**

# cordova-plugin-xinge

此插件是主要是为了在 cordova 应用中使用腾讯的信鸽推送。它提供信鸽的注册以及反注册等一些功能。[腾讯信鸽推送](http://xg.qq.com/)是腾讯提供的免费移动消息推送的平台。

## 安装 

```shell
cordova plugin add https://github.com/hexoh/cordova-plugin-xinge.git
```

## 如何使用

安装完插件后，需要按照[官方说明](http://docs.developer.qq.com/xg/)修改对应的包名以及添加相关启动程序。

### Android

Android 端需要修改 **`AndroidManifest.xml`** 中使用信鸽的配置包名，将以下配置中的 `当前应用的包名` 修改为你的APP包名，修改 _`YOUR_ACCESS_ID`_ 和 _`YOUR_ACCESS_KEY`_ 为你在信鸽申请的 _ACCESS_ID_ 和 _ACCESS_KEY_。

```
<!-- 【必须】 信鸽receiver广播接收 -->
<receiver android:name="com.tencent.android.tpush.XGPushReceiver" android:process=":xg_service_v3">
    <intent-filter android:priority="0x7fffffff">
        <!-- 【必须】 信鸽SDK的内部广播 -->
        <action android:name="com.tencent.android.tpush.action.SDK"/>
        <action android:name="com.tencent.android.tpush.action.INTERNAL_PUSH_MESSAGE"/>
        <!-- 【必须】 系统广播：开屏和网络切换 -->
        <action android:name="android.intent.action.USER_PRESENT"/>
        <action android:name="android.net.conn.CONNECTIVITY_CHANGE"/>
        <!-- 【可选】 一些常用的系统广播，增强信鸽service的复活机会，请根据需要选择。当然，你也可以添加APP自定义的一些广播让启动service -->
        <action android:name="android.bluetooth.adapter.action.STATE_CHANGED"/>
        <action android:name="android.intent.action.ACTION_POWER_CONNECTED"/>
        <action android:name="android.intent.action.ACTION_POWER_DISCONNECTED"/>
    </intent-filter>
</receiver>

<!-- 【可选】APP实现的Receiver，用于接收消息透传和操作结果的回调，请根据需要添加 -->
<!-- YOUR_PACKAGE_PATH.CustomPushReceiver需要改为自己的Receiver： -->
<receiver android:name="org.apache.cordova.xinge.MessageReceiver" android:exported="false">
    <intent-filter>
        <!-- 接收消息透传 -->
        <action android:name="com.tencent.android.tpush.action.PUSH_MESSAGE"/>
        <!-- 监听注册、反注册、设置/删除标签、通知被点击等处理结果 -->
        <action android:name="com.tencent.android.tpush.action.FEEDBACK"/>
    </intent-filter>
</receiver>

<!-- 【注意】 如果被打开的activity是启动模式为SingleTop，SingleTask或SingleInstance，请根据通知的异常自查列表第8点处理-->
<activity android:name="com.tencent.android.tpush.XGPushActivity" android:exported="false">
    <intent-filter>
        <!-- 若使用AndroidStudio，请设置android:name="android.intent.action"-->
        <action android:name="android.intent.action"/>
    </intent-filter>
</activity>

<!-- 【必须】 信鸽service -->
<service android:name="com.tencent.android.tpush.service.XGPushServiceV3" android:exported="true"
         android:persistent="true"
         android:process=":xg_service_v3"/>


<!-- 【必须】 提高service的存活率 -->
<service android:name="com.tencent.android.tpush.rpc.XGRemoteService" android:exported="true">
    <intent-filter>
        <!-- 【必须】 请修改为当前APP包名 .PUSH_ACTION, 如demo的包名为：com.qq.xgdemo -->
        <action android:name="当前应用的包名.PUSH_ACTION"/>
    </intent-filter>
</service>


<!-- 【必须】 【注意】authorities修改为 包名.AUTH_XGPUSH, 如demo的包名为：com.qq.xgdemo-->
<provider android:name="com.tencent.android.tpush.XGPushProvider" android:authorities="当前应用的包名.AUTH_XGPUSH"
          android:exported="true"/>

<!-- 【必须】 【注意】authorities修改为 包名.TPUSH_PROVIDER, 如demo的包名为：com.qq.xgdemo-->
<provider android:name="com.tencent.android.tpush.SettingsContentProvider"
          android:authorities="当前应用的包名.TPUSH_PROVIDER"
          android:exported="false"/>

<!-- 【必须】 【注意】authorities修改为 包名.TENCENT.MID.V3, 如demo的包名为：com.qq.xgdemo-->
<provider android:name="com.tencent.mid.api.MidProvider" android:authorities="当前应用的包名.TENCENT.MID.V3"
          android:exported="true">
</provider>


<!-- 【必须】 请将YOUR_ACCESS_ID修改为APP的AccessId，“21”开头的10位数字，中间没空格 -->
<meta-data android:name="XG_V2_ACCESS_ID" android:value="YOUR_ACCESS_ID"/>
<!-- 【必须】 请将YOUR_ACCESS_KEY修改为APP的AccessKey，“A”开头的12位字符串，中间没空格 -->
<meta-data android:name="XG_V2_ACCESS_KEY" android:value="YOUR_ACCESS_KEY"/>
```

### iOS

iOS 端需要在 `AppDelegate.m` 文件中添加信鸽的启动配置以及监控配置。可以参考以下进行配置，修改 _`YOUR_ACCESS_ID`_ 和 _`YOUR_ACCESS_KEY`_ 为你在信鸽申请的 _ACCESS_ID_ 和 _ACCESS_KEY_。

```
/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  allen
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "XGPush.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate()<XGPushDelegate, XGPushTokenManagerDelegate>
@end

@implementation AppDelegate

#pragma mark - XGPushDelegate
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
    NSLog(@"%@%@", @"启动信鸽服务", (isSuccess?@"成功":@"失败"));
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%@%@", @"注销信鸽服务", (isSuccess?@"成功":@"失败"));
}

- (void)xgPushDidRegisteredDeviceToken:(NSString *)deviceToken error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
}

- (void)xgPushDidBindWithIdentifier:(NSString *)identifier type:(XGPushTokenBindType)type error:(NSError *)error {
    NSLog(@"%s, id is %@, error %@", __FUNCTION__, identifier, error);
    NSLog(@"绑定%@%@%@", ((type == XGPushTokenBindTypeAccount)?@"账号":@"标签"), ((error == nil)?@"成功":@"失败"), identifier);
}

- (void)xgPushDidUnbindWithIdentifier:(NSString *)identifier type:(XGPushTokenBindType)type error:(NSError *)error {
    NSLog(@"%s, id is %@, error %@", __FUNCTION__, identifier, error);
    NSLog(@"解绑%@%@%@", ((type == XGPushTokenBindTypeAccount)?@"账号":@"标签"), ((error == nil)?@"成功":@"失败"), identifier);
}

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    [[XGPush defaultManager] setEnableDebug:NO]; //打开调试
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionDestructive];
    XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
    XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
    [[XGPush defaultManager] setNotificationConfigure:configure];
    [[XGPush defaultManager] startXGWithAppID:YOUR_ACCESS_ID appKey:@"YOUR_ACCESS_KEY" delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    [XGPushTokenManager defaultTokenManager].delegate = self;
    
    self.viewController = [[MainViewController alloc] init];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 此方法不再需要实现；
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSLog(@"[XGDemo] device token is %@", [[XGPushTokenManager defaultTokenManager] deviceTokenString]);
//}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[APP] register APNS fail.\n[APP] reason : %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerDeviceFailed" object:nil];
}


/**
 收到通知的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"[APP] receive Notification");
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
}


/**
 收到静默推送的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[APP] receive slient Notification");
    NSLog(@"[APP] userinfo %@", userInfo);
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"[APP] click notification");
    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
        NSLog(@"click from Action1");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
        NSLog(@"click from Action2");
    }
    
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif

@end
```

## API Reference <a name="reference"></a>

* [XGPush](#module_XGPush)
    * [.registerAccount: function (account, success, error)](#module_XGPush.registerAccount)
    * [.unregisterAccount: function (account, success, error)](#module_XGPush.unregisterAccount)
    * [.setBadge: function (badgeNum, success, error)](#module_XGPush.setBadge)


<a name="module_XGPush"></a>

### XGPush

<a name="module_XGPush.registerAccount"></a>

#### XGPush.registerAccount: function (account, success, error)

在信鸽服务器绑定账号并返回信息，只有在信鸽服务器绑定的账号，信鸽服务器才会给账号推送信息。

__Supported Platforms__

- Android
- iOS

**Kind**

| Param | Type | Description |
| --- | --- | --- |
| account | String | 需要绑定的账号 |
| success | function | 调用成功回调函数 |
| error | function | 调用失败回调函数 |

**Example**  

```js
document.addEventListener('deviceready', function () {
  cordova.plugins.XGPush.registerAccount('bbb', function (success) {
    console.log('success:' + JSON.stringify(success));
  }, function (error) {
    console.log('error:' + JSON.stringify(error));
  });
});
```

<a name="module_XGPush.unregisterAccount"></a>

#### XGPush.unregisterAccount: function (account, success, error)

在信鸽服务器解绑账号并返回信息。

__Supported Platforms__

- Android
- iOS

**Kind**

| Param | Type | Description |
| --- | --- | --- |
| account | String | 需要解绑的账号 |
| success | function | 调用成功回调函数 |
| error | function | 调用失败回调函数 |

**Example**  

```js
document.addEventListener('deviceready', function () {
  cordova.plugins.XGPush.unregisterAccount('***', function (success) {
    console.log('success:' + JSON.stringify(success));
  }, function (error) {
    console.log('error:' + JSON.stringify(error));
  })
});
```

<a name="module_XGPush.setBadge"></a>

#### XGPush.setBadge: function (badgeNum, success, error)

管理 App 显示的角标数量。

__Supported Platforms__

- iOS

**Kind**

| Param | Type | Description |
| --- | --- | --- |
| badgeNum | string | 角标数 |
| success | function | 调用成功回调函数 |
| error | function | 调用失败回调函数 |

**Example**  

```js
document.addEventListener('deviceready', function () {
  cordova.plugins.XGPush.setBadge('0', function (success) {
    console.log('success:' + JSON.stringify(success));
  }, function (error) {
    console.log('error:' + JSON.stringify(error));
  })
});
```

