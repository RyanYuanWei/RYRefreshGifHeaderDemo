//
//  MJRefreshNormalHeader+Gif.m
//
//  Created by RyanYuan on 2019/4/8.
//  Copyright © 2019 ry. All rights reserved.
//

#import "MJRefreshNormalHeader+Gif.h"
#import "RYRefreshGifHeader.h"
#import <objc/runtime.h>

@implementation MJRefreshNormalHeader (Gif)

+ (void)load {
    Method normalHeaderMethod = class_getClassMethod(self, @selector(headerWithRefreshingBlock:));
    Method gifHeaderMethod = class_getClassMethod(self, @selector(swizzled_headerWithRefreshingBlock:));
    IMP gifHeaderMethodImplementation = method_getImplementation(gifHeaderMethod);
    method_setImplementation(normalHeaderMethod, gifHeaderMethodImplementation);
}

+ (instancetype)swizzled_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    return (MJRefreshNormalHeader *)[RYRefreshGifHeader swizzled_headerWithRefreshingBlock:refreshingBlock];
}

@end
