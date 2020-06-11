//
//  topView.m
//  scrollerDemo
//
//  Created by 郑志成 on 2020/6/10.
//  Copyright © 2020 郑志成. All rights reserved.
//

#import "topView.h"
#import "UIView+Extention.h"

#define k_Screen_Width  [UIScreen mainScreen].bounds.size.width
#define k_Screen_Height [UIScreen mainScreen].bounds.size.height
#define k_Button_Title_Font   [UIFont systemFontOfSize:16]

@interface topView ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollerView;
@property(nonatomic, copy)NSMutableArray *buttonArray;
@property(nonatomic, strong)UIView *indicatorView;
@property (nonatomic, strong)UIButton *selectButton;

@end

@implementation topView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray{
    _scrollerView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollerView.delegate = self;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.bounces = NO;
    [self addSubview:_scrollerView];
    CGFloat bw_x = 0.0;
    CGFloat bw_y = 0.0;
    CGFloat btnSpace = 10;
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize size = [self sizeWithText:titleArray[i] font:k_Button_Title_Font maxSize:CGSizeMake(k_Screen_Width, MAXFLOAT)];
        CGFloat bw_w = size.width + btnSpace * 2;
        button.frame = CGRectMake(bw_x, bw_y, bw_w, 44);
        bw_x += bw_w;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_scrollerView addSubview:button];
        [self.buttonArray addObject:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.selectButton = button;
        }
    }
    // 计算ScrollView的宽度，设置contentSize
    UIButton *lastButton = (UIButton *)self.buttonArray.lastObject;
    CGFloat scrollWid = CGRectGetMaxX(lastButton.frame);
    _scrollerView.contentSize = CGSizeMake(scrollWid, 44);
    
    UIButton *button = (UIButton *)self.buttonArray.firstObject;
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor greenColor];
    indicatorView.Bw_height = 2;
    indicatorView.Bw_y = self.Bw_height - 2 * 2;
    indicatorView.Bw_width = button.Bw_width - 2 * btnSpace;
    indicatorView.Bw_centerX = button.Bw_centerX;
    self.indicatorView = indicatorView;
    [_scrollerView addSubview:indicatorView];
    
}

- (void)buttonAction:(UIButton *)button{
    [self setButton:button];
     // 让选中的按钮调整位置
    [self setSelectButtonCenter:button];
    if (self.titleButtonClick) {
        self.titleButtonClick(button.tag, button);
    }
}

// 设置选中按钮的状态以及指示器的位置等
- (void)setButton:(UIButton *)button{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    [UIView animateWithDuration:.3f animations:^{
        self.indicatorView.Bw_width = button.Bw_width - 2 * 10;
        self.indicatorView.Bw_centerX = button.Bw_centerX;
    }];
   
}

- (void)setSelectButtonCenter:(UIButton *)centerButton{
    CGFloat offsetX = centerButton.Bw_centerX - k_Screen_Width / 2;
    CGFloat maxOffsetX = _scrollerView.contentSize.width - k_Screen_Width;
    if (offsetX < 0) {
        offsetX = 0;
    } else {
        if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
    }
    [_scrollerView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)setSelectButtonWithTag:(NSInteger)tag{
    UIButton *button = self.buttonArray[tag];
    [self setButton:button];
    [self setSelectButtonCenter:button];
}

#pragma mark - 计算按钮的宽度
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
