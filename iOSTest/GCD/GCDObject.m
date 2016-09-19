//
//  GCDObject.m
//  iOSTest
//
//  Created by desehou on 16/9/18.
//  Copyright © 2016年 wsmall. All rights reserved.
//
/*
 1.什么是GCD？
 
 全称是Grand Central Dispatch，纯C语言，提供了非常多强大的函数
 2.GCD的优势
 GCD是苹果公司为多核的并行运算提出的解决方案
 GCD会自动利用更多的CPU内核（比如双核、四核）
 GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
 我们只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
 
 *多线程相关概念*
 进程与线程
 进程概念： 进程是程序在计算机上的一次执行活动，打开一个app，就开启了一个进程，可包含多个线程。
 线程概念： 独立执行的代码段，一个线程同时间只能执行一个任务，反之多线程并发就可以在同一时间执行多个任务。
 iOS程序中，主线程（又叫作UI线程）主要任务是处理UI事件，显示和刷新UI，（只有主线程有直接修改UI的能力）耗时的操作放在子线程（又叫作后台线程、异步线程）。在iOS中开子线程去处理耗时的操作，可以有效提高程序的执行效率，提高资源利用率。但是开启线程会占用一定的内存，（主线程的堆栈大小是1M，第二个线程开始都是512KB，并且该值不能通过编译器开关或线程API函数来更改）降低程序的性能。所以一般不要同时开很多线程。
 线程相关
 同步线程：同步线程会阻塞当前线程去执行线程内的任务，执行完之后才会反回当前线程。
 异步线程：异步线程不会阻塞当前线程，会开启其他线程去执行线程内的任务。
 串行队列：线程任务按先后顺序逐个执行（需要等待队列里面前面的任务执行完之后再执行新的任务）。
 并发队列：多个任务按添加顺序一起开始执行（不用等待前面的任务执行完再执行新的任务），但是添加间隔往往忽略不计，所以看着像是一起执行的。
 并发VS并行：并行是基于多核设备的，并行一定是并发，并发不一定是并行。
 多线程中会出现的问题
 Critical Section（临界代码段）
 指的是不能同时被两个线程访问的代码段，比如一个变量，被并发进程访问后可能会改变变量值，造成数据污染（数据共享问题）。
 Race Condition (竞态条件)
 当多个线程同时访问共享的数据时，会发生争用情形，第一个线程读取改变了一个变量的值，第二个线程也读取改变了这个变量的值，两个线程同时操作了该变量，此时他们会发生竞争来看哪个线程会最后写入这个变量，最后被写入的值将会被保留下来。
 Deadlock (死锁)
 两个（多个）线程都要等待对方完成某个操作才能进行下一步，这时就会发生死锁。
 Thread Safe（线程安全）
 一段线程安全的代码（对象），可以同时被多个线程或并发的任务调度，不会产生问题，非线程安全的只能按次序被访问。
 所有Mutable对象都是非线程安全的，所有Immutable对象都是线程安全的，使用Mutable对象，一定要用同步锁来同步访问（@synchronized）。
 互斥锁：能够防止多线程抢夺造成的数据安全问题，但是需要消耗大量的资源
 原子属性（atomic）加锁
 atomic: 原子属性，为setter方法加锁，将属性以atomic的形式来声明，该属性变量就能支持互斥锁了。
 nonatomic: 非原子属性，不会为setter方法加锁，声明为该属性的变量，客户端应尽量避免多线程争夺同一资源。
 Context Switch （上下文切换）
 当一个进程中有多个线程来回切换时，context switch用来记录执行状态，这样的进程和一般的多线程进程没有太大差别，但会产生一些额外的开销。
 */

#import "GCDObject.h"

@implementation GCDObject

/*The main queue（主线程串行队列): 与主线程功能相同，提交至Main queue的任务会在主线程中执行，
Main queue 可以通过dispatch_get_main_queue()来获取。
 */
-(void)main_queue_test
{
    dispatch_queue_t main_queue=dispatch_get_main_queue();
    dispatch_async(main_queue, ^{
        
        NSLog(@"主线程，只能异步哦，要不会死锁的");
    });

}
/*
 Global queue（全局并发队列): 全局并发队列由整个进程共享，有高、中（默认）、低、后台四个优先级别。
 Global queue 可以通过调用dispatch_get_global_queue函数来获取（可以设置优先级）
 主线程串行队列由系统默认生成的，所以无法调用dispatch_resume()和dispatch_suspend()来控制执行继续或中断。
 */
-(void)global_queue_test
{
    dispatch_queue_t global_queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global_queue, ^{
        NSLog(@"global_queue1");
        
    });
    dispatch_async(global_queue, ^{
        NSLog(@"global_queue2");
        
    });
    dispatch_async(global_queue, ^{
        NSLog(@"global_queue3");
        
    });
}
//全局队列同步执行
-(void)global_queue_sync_test
{
    dispatch_queue_t global_queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(global_queue, ^{
        NSLog(@"global_queue_sync1");
    });
    dispatch_sync(global_queue, ^{
        NSLog(@"global_queue_sync2");
    });
    dispatch_sync(global_queue, ^{
        NSLog(@"global_queue_sync3");
    });


}
@end
