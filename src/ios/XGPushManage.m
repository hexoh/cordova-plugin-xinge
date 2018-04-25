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

-(void)setBadge:(NSInteger)badgeNumber{
    [[XGPush defaultManager] setXgApplicationBadgeNumber:badgeNumber];
}

@end
