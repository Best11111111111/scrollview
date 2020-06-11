//
//  UIView+Extention.h
//  scrollerDemo
//
//  Created by 郑志成 on 2020/6/10.
//  Copyright © 2020 郑志成. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extention)

@property (nonatomic, assign) CGFloat Bw_x;
@property (nonatomic, assign) CGFloat Bw_y;
@property (nonatomic, assign) CGFloat Bw_width;
@property (nonatomic, assign) CGFloat Bw_height;
@property (nonatomic, assign) CGFloat Bw_centerX;
@property (nonatomic, assign) CGFloat Bw_centerY;

@property (nonatomic, assign) CGSize Bw_size;

@property (nonatomic, assign) CGFloat Bw_right;
@property (nonatomic, assign) CGFloat Bw_bottom;

+ (instancetype)Bw_viewFromXib;

@end

NS_ASSUME_NONNULL_END
