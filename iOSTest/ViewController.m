//
//  ViewController.m
//  iOSTest
//
//  Created by desehou on 16/9/9.
//  Copyright © 2016年 wsmall. All rights reserved.
//

#import "ViewController.h"
#import "KVCTestObject.h"
#import "KVCTestSecondObject.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self KVCTest];
  
}


/*
  KVC实际使用
 1.可以用Key-Value-Coding(KVC)键值编码来访问你要存取的类的属性。
 2.键路径访问属性,键路径取值valueForKeyPath,键路径存值：forKeyPath.
 3.自动封装基本数据类型.
 4.操作集合
 */
#pragma mark -KVC
-(void)KVCTest{
    
    KVCTestObject *kvcTestObject=[[KVCTestObject alloc]init];
    [kvcTestObject setValue:@"kvc测试" forKey:@"test"];
    NSString *testLog=[kvcTestObject valueForKey:@"test"];
    NSLog(@"KVC-test:%@",testLog);
    
    KVCTestSecondObject *kvcTestSecondObject=[[KVCTestSecondObject alloc]init];
    [kvcTestSecondObject setValue:@"kvc-Second测试" forKey:@"secondTest"];
    [kvcTestObject setValue:kvcTestSecondObject forKey:@"kvcTestSecondObject"];
    NSString *testSecondLog=[kvcTestObject valueForKeyPath:@"kvcTestSecondObject.secondTest"];
    NSLog(@"KVC-test:%@",testSecondLog);
    
    [kvcTestObject setValue:@"kvc-Second测试2" forKeyPath:@"kvcTestSecondObject.secondTest"];
    testSecondLog=[kvcTestObject valueForKeyPath:@"kvcTestSecondObject.secondTest"];
    NSLog(@"KVC-test:%@",testSecondLog);
    
    
    [kvcTestObject setValue:@"2016" forKey:@"point"];
    testLog=[kvcTestObject valueForKey:@"point"];
    NSLog(@"KVC-test:%@",testLog);
    
    
    
    KVCTestSecondObject *kvcTestSecondObject1=[[KVCTestSecondObject alloc]init];
    [kvcTestSecondObject1 setValue:@"2014" forKey:@"point"];
    
    KVCTestSecondObject *kvcTestSecondObject2=[[KVCTestSecondObject alloc]init];
    [kvcTestSecondObject2 setValue:@"2015" forKey:@"point"];
    
    KVCTestSecondObject *kvcTestSecondObject3=[[KVCTestSecondObject alloc]init];
    [kvcTestSecondObject3 setValue:@"2016" forKey:@"point"];
    
    NSArray *array = [NSArray arrayWithObjects:kvcTestSecondObject1,kvcTestSecondObject2,kvcTestSecondObject3,nil];
    [kvcTestObject setValue:array forKey:@"otherTestsArray"];
    
    NSLog(@"数组里所有成员的point值：%@", [kvcTestObject valueForKeyPath:@"otherTestsArray.point"]);
    NSLog(@"有%@个成员", [kvcTestObject valueForKeyPath:@"otherTestsArray.@count"]);
    NSLog(@"point最高:%@", [kvcTestObject valueForKeyPath:@"otherTestsArray.@max.point"]);
    NSLog(@"point最低:%@", [kvcTestObject valueForKeyPath:@"otherTestsArray.@min.point"]);
    NSLog(@"point平均:%@", [kvcTestObject valueForKeyPath:@"otherTestsArray.@avg.point"]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
