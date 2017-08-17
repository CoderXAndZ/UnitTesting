//
//  PersonTests.m
//  单元测试
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 XZ. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XZPerson.h"

@interface PersonTests : XCTestCase

@end

@implementation PersonTests

// 一次单元测试开始前的准备工作，可以设置全局变量
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

// 一次单元测试结束前的销毁工作
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
// 前缀都是test,前面加一个小的◇，点一下可以看到模拟器晃了一下，然后◇变成绿色的√了
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

// 注意：单元测试的方法都要以test开头
/**
 1.单元测试是以代码测试代码
 2.红灯/绿灯 迭代开发
 3.在日常开发中，数据大部分来自于网络，很难出现'所有的'边界数据！如果没有测试所有条件就上架，在运行时造成闪退！
 4.可以自己建立'测试用例（使用的例子数据，专门检查边界点）'
 5.单元测试不是靠 NSLog 来测试，NSLog 是程序员用眼睛看的笨办法。使用`断言`来测试的，提前预判条件必须满足！
 
 // 扩展：为什么有些公司讨厌单元测试！因为‘代码覆盖度’不好确认！
 
 提示：
 1.不是所有的方法都需要测试
    例如：私有方法不需要测试！只有暴露在.h中的方法需要测试！面向对象有一个原则：开闭原则！
 2.所有跟UI有关的都不需要测试，也不好测试！
 MVVM，把‘小的业务逻辑’代码封装出来！变成可以测试的代码，让程序更加健壮！
 3.一般而言，代码的覆盖度大概在 50% ~ 70%
 */
// 测试新建Person模型
- (void)testNewPerson {
    [self checkPersonWithDict:@{@"name":@"zhang",@"age":@20}];
    [self checkPersonWithDict:@{@"name":@"zhang"}];
    [self checkPersonWithDict:@{}];
    [self checkPersonWithDict:@{@"name":@"zhang",@"age":@20,@"title":@"boss"}];
    [self checkPersonWithDict:@{@"name":@"zhang",@"age":@-1,@"title":@"boss"}];
}

// 根据字典检查新建的Person信息
- (void)checkPersonWithDict:(NSDictionary *)dict {
    XZPerson *person = [XZPerson personWithDic:dict];
    
    NSLog(@"%@",person);
    
    // 获取字典信息
    NSString *name = dict[@"name"];
    NSInteger age = [dict[@"age"] integerValue];
    
    // 1.检查名称
    XCTAssert([name isEqualToString:person.name] || person.name == nil,@"姓名不一致");
    // 2.检查年龄
    if (person.age > 0 && person.age < 130) {
        XCTAssert(age == person.age,@"年龄不正确");
    }else {
        XCTAssert(person.age == 0,@"年龄超限");
    }
    
}

// 性能 Performance
/**
 相同的代码重复执行 10 次，统计计算时间，平均时间！
 
 性能测试代码一旦写好，可以随时测试！
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 将需要测量执行时间的代码放在此处！
        NSTimeInterval start = CACurrentMediaTime();
        for (int i = 0; i < 10000; i++) {
            [XZPerson personWithDic:@{@"name":@"zhang",@"age":@20}];
        }
        
        NSLog(@"%f",CACurrentMediaTime() - start);
    }];
}

/**
 苹果的单元测试是串行的
 setUp
    testXXX1
    testXXX2
    testXXX3
 tearDown
 
 中间不会等待异步的回调完成
 */
// 测试异步加载Person
- (void)testLoadPersonAsync {
    // Xcode 6.0 开始解决 'Expectation' 预期
    XCTestExpectation *expectation = [self expectationWithDescription:@"异步加载 Person"];
    [XZPerson loadPersonAsync:^(XZPerson *person) {
        NSLog(@"%@",person.name);
        
        // 标注预期达成
        [expectation fulfill];
    }];
    
    // 痴痴的等待预期的达成
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
