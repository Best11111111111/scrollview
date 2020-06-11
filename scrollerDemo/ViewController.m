//
//  ViewController.m
//  scrollerDemo
//
//  Created by 郑志成 on 2020/6/10.
//  Copyright © 2020 郑志成. All rights reserved.
//

#import "ViewController.h"
#import "topView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)topView *topView;
@property(nonatomic, copy)NSArray *titleArray;
@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArray = @[@"新闻", @"电视剧", @"电影", @"娱乐", @"综艺", @"游戏", @"八卦", @"相声", @"评书", @"音乐", @"小品", @"军事", @"直播", @"情感", @"历史", @"健康", @"懂车", @"美食", @"财经", @"科技", @"漫画"];
    
    _topView = [[topView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
    _topView.titleArray = _titleArray;
    [self.view addSubview:_topView];
    __weak typeof(self) weakSelf = self;
    _topView.titleButtonClick = ^(NSInteger tag, UIButton * _Nonnull button) {
        [weakSelf menuViewTitleClick:tag];
    };
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(_topView.frame))];
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _titleArray.count, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 50, 80)];
    _titleLabel.text = _titleArray.firstObject;
    _titleLabel.textColor = [UIColor redColor];
    [_scrollView addSubview:_titleLabel];
}

- (void)menuViewTitleClick:(NSInteger)tag{
    NSString *title = [NSString stringWithFormat:@"%@", self.titleArray[tag]];
    _titleLabel.text = title;
    [self updateTitleLabelFrame:tag];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    NSString *title = [NSString stringWithFormat:@"%@", self.titleArray[index]];
    _titleLabel.text = title;
    [self updateTitleLabelFrame:index];
    [_topView setSelectButtonWithTag:index];
}

- (void)updateTitleLabelFrame:(NSInteger)index{
    _titleLabel.frame = CGRectMake(100+[UIScreen mainScreen].bounds.size.width*index, 200, 80, 30);
    _scrollView.contentOffset = CGPointMake(index * [UIScreen mainScreen].bounds.size.width, 0);
}

@end
