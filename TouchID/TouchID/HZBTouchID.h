//
//  HZBTouchID.h
//  TouchID
//
//  Created by 安宁 on 2017/6/19.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZBTouchID : NSObject


+(void)showTouchID:(void(^)(BOOL success, NSError * _Nullable error))callback ;


+(BOOL)supportTouchID ;

@end
