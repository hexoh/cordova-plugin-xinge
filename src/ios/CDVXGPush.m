/********* XGPush.m Cordova Plugin Implementation *******/

#import <Cordova/CDVPlugin.h>
#import "CDVXGPush.h"
#import "XGPushManage.h"

@implementation CDVXGPush

- (void)registerAccount:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    NSString* account = [command.arguments objectAtIndex:0];

    if (account != nil && [account length] > 0) {
        
        NSLog(@"Start registerAccount:%@",account);
        
        XGPushManage *pushManage = [XGPushManage getInstance];
        
        [pushManage registerAccount:account];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:account];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)unregisterAccount:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* pluginResult = nil;
    NSString* account = [command.arguments objectAtIndex:0];
    
    if (account != nil && [account length] > 0) {
        
        NSLog(@"Start unregisterAccount:%@",account);
        
        XGPushManage *pushManage = [XGPushManage getInstance];
        
        [pushManage unregisterAccount:account];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:account];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setBadge:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* pluginResult = nil;
    NSString* badgeNum = [command.arguments objectAtIndex:0];
    
    if (badgeNum != nil && [badgeNum length] > 0) {
        
        NSLog(@"Start setBadge:%@",badgeNum);
    
        NSInteger num = [badgeNum  intValue];
        
        XGPushManage *pushManage = [XGPushManage getInstance];
        
        [pushManage setBadge:num];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:badgeNum];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
