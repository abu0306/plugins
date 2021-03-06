//
//  Biology.m
//  local_auth
//
//  Created by 李广斌 on 2020/9/24.
//

#import "Biology.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation Biology

+(void) biologyUnLockTips:(NSString *)tips negativeBtn:(NSString *)negativeBtn positiveBtn:(NSString *)positiveBtn sensitiveTransaction:(NSInteger)sensitiveTransaction unLockSuccess:(void (^)(void)) unLockSuccess unLockFail:(void (^)(NSInteger)) unLockFail unLockError:(void (^)(NSInteger)) unLockError {
    
    LAContext *context = [[LAContext alloc] init];
    NSError *authError = nil;
    context.localizedFallbackTitle = positiveBtn;
    if (@available(iOS 10.0, *)) {
        context.localizedCancelTitle = negativeBtn;
    } else {
    }
    
    BOOL isSupport = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                          error:&authError];
    
    if (isSupport) {
        
        [context evaluatePolicy: sensitiveTransaction == 0 ? LAPolicyDeviceOwnerAuthentication : LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:tips reply:^(BOOL success, NSError * _Nullable error) {

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (success) {
                    unLockSuccess();
                }
                else{
                    unLockFail(error.code);
                }
            }];
        }];
    }
    else {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            unLockError(authError.code);
        }];
    }
}

+(NSInteger)isSupport {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthentication error:&error];
    
    if (error == nil) {
        return 0;
    }
    else {
        return error.code;
    }
}

+(NSInteger)getWhitchBiology {
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthentication error:&error];
    if (@available(iOS 11.0, *)) {
        return [context biometryType];
    } else {
        return 1;
    }
}

///  去设置权限
+(void) setBiologyOkTitle1:(NSString *)title1 negativeBtn:(NSString *)negativeBtn positiveBtn:(NSString *)positiveBtn onNegative:(void (^)(void))onNegative onPositive:(void (^)(void))onPositive{
    
    UIAlertController *one = [UIAlertController alertControllerWithTitle:title1 message:@"" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *negative = [UIAlertAction actionWithTitle:negativeBtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        onNegative();
    }];
    
    UIAlertAction *positive = [UIAlertAction actionWithTitle:positiveBtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self systemSeting];
    }];
    
    [one addAction: negative];
    [one addAction:positive];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:one animated:YES completion:nil];
}


///  去设置权限
/// 跳转到系统设置主页
+(void)systemSeting {
    NSURL *url = [[NSURL alloc] initWithString: UIApplicationOpenSettingsURLString];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}


+(void) setBiologyshouldOpenTitle2:(NSString *)title2 negativeBtn:(NSString *)negativeBtn onNegative:(void (^)(void))onNegative{
    
    UIAlertController *one = [UIAlertController alertControllerWithTitle:title2 message:@"" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *negative = [UIAlertAction actionWithTitle:negativeBtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        onNegative();
    }];
    
    [one addAction: negative];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:one animated:YES completion:nil];
}


+(void) biologyOutTitle3:(NSString *)title3 negativeBtn:(NSString *)negativeBtn positiveBtn:(NSString *)positiveBtn onNegative:(void (^)(void))onNegative onPositive:(void (^)(void))onPositive{
    
    UIAlertController *one = [UIAlertController alertControllerWithTitle:title3 message:@"" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *negative = [UIAlertAction actionWithTitle:negativeBtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        onNegative();
    }];
    
    UIAlertAction *positive = [UIAlertAction actionWithTitle:positiveBtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        onPositive();
    }];
    
    [one addAction: negative];
    [one addAction:positive];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:one animated:YES completion:nil];
}

@end
