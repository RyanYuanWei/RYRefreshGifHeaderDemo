//
//  RYRefreshGifHeader.m
//
//  Created by RyanYuan on 2019/4/4.
//  Copyright © 2019 ry. All rights reserved.
//

#import "RYRefreshGifHeader.h"

static const NSInteger kRYRefreshGifHeaderMaxImageLoopCount = 200;
static const CGFloat kRYRefreshGifHeaderImageWidth = 40;
static const CGFloat kRYRefreshGifHeaderAppendHight = 15;
static const CGFloat kRYRefreshGifHeaderIPhoneXAppendHight = 22;

@implementation RYRefreshGifHeader

- (void)prepare {
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
    NSArray *idleImageArr = [self configImageArrayWithImagePrefixionString:@"IMG_4315-"];
    NSArray *refreshingImageArr = [self configImageArrayWithImagePrefixionString:@"IMG_5370-"];
    
    [self setImages:idleImageArr duration:idleImageArr.count * 0.1 forState:MJRefreshStateIdle];
    [self setImages:refreshingImageArr duration:refreshingImageArr.count * 0.1 forState:MJRefreshStateRefreshing];
}

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state {
    [super setImages:images duration:duration forState:state];
    BOOL isIphonexSerious = ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896);
    self.mj_h += (isIphonexSerious ? kRYRefreshGifHeaderIPhoneXAppendHight : kRYRefreshGifHeaderAppendHight);
}

- (NSArray *)configImageArrayWithImagePrefixionString:(NSString *)prefixionString {
    
    NSMutableArray *imageArr = @[].mutableCopy;
    for (NSInteger index = 1; index < kRYRefreshGifHeaderMaxImageLoopCount; index++) {
        NSString *imageName = [NSString stringWithFormat:@"%@%@", prefixionString, @(index)];
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (image != nil) {
            // MJRefreshGifHeader 暂不支持修改loading图片的比例，所以这里使用 Quart2D 对图片进行缩放
            CGSize imageTempSize = CGSizeMake(kRYRefreshGifHeaderImageWidth, kRYRefreshGifHeaderImageWidth);
            // 创建一个bitmap的context
            // 并把它设置成为当前正在使用的context
            UIGraphicsBeginImageContextWithOptions(imageTempSize, NO, [[UIScreen mainScreen] scale]);
            // 绘制改变大小的图片
            [image drawInRect:CGRectMake(0, 0, imageTempSize.width, imageTempSize.height)];
            // 从当前context中创建一个改变大小后的图片
            UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            // 使当前的context出堆栈
            UIGraphicsEndImageContext();
            [imageArr addObject:scaledImage];
        } else {
            break;
        }
    }
    return imageArr.copy;
}

+ (instancetype)swizzled_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    RYRefreshGifHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}

@end

