//
//  HZBTouchID.m
//  TouchID
//
//  Created by 安宁 on 2017/6/19.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBTouchID.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation HZBTouchID

+(void)showTouchID:(void(^)(BOOL success, NSError * _Nullable error))callback
{
    if ([self supportTouchID])
    {
        LAContext * context = [[LAContext alloc]init] ;
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证已有指纹" reply:callback];
    }else
    {
        
    }

}


+(BOOL)supportTouchID
{
    LAContext * context = [[LAContext alloc]init] ;
    
    NSError * error ;
    
    BOOL support = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error] ;
    
    if (!support)
    {
        NSLog(@"%@",[self getErrorMessage:error.code]);
    }
    return support ;
}

+(NSString *)getErrorMessage:(NSInteger)errorCode
{
    
    NSString * errorMessage = nil ;
    switch (errorCode)
    {
        case -1:
            errorMessage = @"指纹无法识别" ;
            break;
            
        case -2:
            errorMessage = @"用户点击了\"取消\" 按钮" ;
            break;
            
        case -3:
            errorMessage = @"用户取消，点击了 \"输入密码\" 按钮" ;
            break;
            
        case -4:
            errorMessage = @"系统取消，例如激活了其他应用程序" ;
            break;
            
        case -5:
            errorMessage = @"验证无法启动，因为设备上没有设置密码" ;
            break;
            
        case -6:
            errorMessage = @"验证无法启动，因为设备上没有 Touch ID" ;
            break;
            
        case -7:
            errorMessage = @"验证无法启动，因为没有输入指纹" ;
            break;
            
        default:
            errorMessage = @"其他错误" ;
            break;
    }
    
    return errorMessage ;
}


/*
 
 NS_CLASS_AVAILABLE(10_10, 8_0) @interface LAContext : NSObject
 
 指纹识别功能是 iPhone 5s 推出的，SDK 是 iOS 8.0 推出。
 
 推出指纹识别的主要原因是为了简化支付，移动支付的环节越简单越好。
 
 
 
 指纹验证方式：
 
 // 只使用指纹验证
 LAPolicyDeviceOwnerAuthenticationWithBiometrics NS_ENUM_AVAILABLE(NA, 8_0) = kLAPolicyDeviceOwnerAuthenticationWithBiometrics,
 
 // 使用指纹和设备密码验证，指纹错误或无法验证时会自动跳转到输入密码验证界面
 LAPolicyDeviceOwnerAuthentication NS_ENUM_AVAILABLE(10_11, 9_0) = kLAPolicyDeviceOwnerAuthentication
 2）指纹验证错误信息：
 
 // 指纹无法识别                        error.code == -1
 LAErrorAuthenticationFailed = kLAErrorAuthenticationFailed,
 
 // 用户点击了 "取消" 按钮               error.code == -2
 LAErrorUserCancel           = kLAErrorUserCancel,
 
 // 用户取消，点击了 "输入密码" 按钮       error.code == -3
 LAErrorUserFallback         = kLAErrorUserFallback,
 
 // 系统取消，例如激活了其他应用程序        error.code == -4
 LAErrorSystemCancel         = kLAErrorSystemCancel,
 
 // 验证无法启动，因为设备上没有设置密码     error.code == -5
 LAErrorPasscodeNotSet       = kLAErrorPasscodeNotSet,
 
 // 验证无法启动，因为设备上没有 Touch ID   error.code == -6
 LAErrorTouchIDNotAvailable  = kLAErrorTouchIDNotAvailable,
 
 // 验证无法启动，因为没有输入指纹          error.code == -7
 LAErrorTouchIDNotEnrolled   = kLAErrorTouchIDNotEnrolled,
 
 LAErrorTouchIDLockout   NS_ENUM_AVAILABLE(10_11, 9_0) = kLAErrorTouchIDLockout,
 LAErrorAppCancel        NS_ENUM_AVAILABLE(10_11, 9_0) = kLAErrorAppCancel,
 LAErrorInvalidContext   NS_ENUM_AVAILABLE(10_11, 9_0) = kLAErrorInvalidContext
 */


@end
