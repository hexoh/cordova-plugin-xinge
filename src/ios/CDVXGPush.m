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
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];}

@end
