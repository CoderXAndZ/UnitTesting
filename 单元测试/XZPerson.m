//
//  XZPerson.m
//  单元测试
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 XZ. All rights reserved.
//

#import "XZPerson.h"

@implementation XZPerson

+ (instancetype)personWithDic:(NSDictionary *)dict {
    // 使用self方便子类集成，使用obj是因为KVC不需要知道前面到底是什么对象
//    id obj = [[self alloc] init];
    XZPerson *obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    
    if (obj.age <= 0 || obj.age >= 130) {
        obj.age = 0;
    }
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

// 异步加载个人记录
+ (void)loadPersonAsync:(void(^)(XZPerson *person))completed {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:1.0];
       XZPerson *person = [XZPerson personWithDic:@{@"name":@"zhang",@"age":@5}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!completed) {
                completed(person);
            }
        });
    });
}

@end
