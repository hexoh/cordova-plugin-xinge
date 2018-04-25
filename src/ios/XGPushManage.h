//
//  XGPushManage.h
//  allen
//
//  Created by nopqrstay on 2018/4/24.
//

#ifndef XGPushManage_h
#define XGPushManage_h

@interface XGPushManage : NSObject {
    
}

+(id) getInstance;

-(void)registerAccount:(NSString*) account;

-(void)unregisterAccount:(NSString*) account;

@end

#endif /* XGPushManage_h */
