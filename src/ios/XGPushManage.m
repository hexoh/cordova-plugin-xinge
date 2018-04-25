//
//  XGPushManage.m
//  allen
//
//  Created by nopqrstay on 2018/4/24.
//

#import <Foundation/Foundation.h>

#import "XGPushManage.h"
#import "XGPush.h"

@implementation XGPushManage

+(id) getInstance{
    
    static XGPushManage *xGPushManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xGPushManage = [[self alloc] init];
        
    });
    return xGPushManage;
}

-(void)registerAccount:(NSString *)account{
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:account type:XGPushTokenBindTypeAccount];
}

-(void)unregisterAccount:(NSString *)account{
    [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:account type:XGPushTokenBindTypeAccount];
}

#pragma mark - XGPushTokenManagerDelegate
- (void)xgPushDidBindWithIdentifier:(NSString *)identifier type:(XGPushTokenBindType)type error:(NSError *)error {
    NSLog(@"%s, id is %@, error %@", __FUNCTION__, identifier, error);
    NSLog(@"绑定%@%@%@", ((type == XGPushTokenBindTypeAccount)?@"账号":@"标签"), ((error == nil)?@"成功":@"失败"), identifier);
}

- (void)xgPushDidUnbindWithIdentifier:(NSString *)identifier type:(XGPushTokenBindType)type error:(NSError *)error {
    NSLog(@"%s, id is %@, error %@", __FUNCTION__, identifier, error);
    NSLog(@"解绑%@%@%@", ((type == XGPushTokenBindTypeAccount)?@"账号":@"标签"), ((error == nil)?@"成功":@"失败"), identifier);
}

@end
