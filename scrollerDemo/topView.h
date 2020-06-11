//
//  topView.h
//  scrollerDemo
//
//  Created by 郑志成 on 2020/6/10.
//  Copyright © 2020 郑志成. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface topView : UIView

@property(nonatomic, copy)NSArray *titleArray;
@property (nonatomic, copy) void (^titleButtonClick)(NSInteger tag, UIButton *button);
/**
 外面选中按钮后，调节按钮的位置
 */
- (void)setSelectButtonWithTag:(NSInteger)tag;


@end

NS_ASSUME_NONNULL_END
