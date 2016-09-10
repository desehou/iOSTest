//
//  KVCTestObject.h
//  iOSTest
//
//  Created by desehou on 16/9/9.
//  Copyright © 2016年 wsmall. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KVCTestSecondObject;
@interface KVCTestObject : NSObject
{
    NSString *test;
    KVCTestSecondObject *kvcTestSecondObject;
    int  point;
    NSArray *otherTestsArray;
}

@end
