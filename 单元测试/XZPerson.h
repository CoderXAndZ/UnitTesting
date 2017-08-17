//
//  XZPerson.h
//  单元测试
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 XZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;

+ (instancetype)personWithDic:(NSDictionary *)dict;

// 异步加载个人记录
+ (void)loadPersonAsync:(void(^)(XZPerson *person))completed;
@end
