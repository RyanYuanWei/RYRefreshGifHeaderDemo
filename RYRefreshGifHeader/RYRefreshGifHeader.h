//
//  RYRefreshGifHeader.h
//
//  Created by RyanYuan on 2019/4/4.
//  Copyright © 2019 ry. All rights reserved.
//

#import "MJRefreshGifHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface RYRefreshGifHeader : MJRefreshGifHeader

+ (instancetype)swizzled_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end

NS_ASSUME_NONNULL_END
