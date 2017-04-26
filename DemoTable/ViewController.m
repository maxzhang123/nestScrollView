//
//  ViewController.m
//  DemoTable
//
//  Created by Max on 2017/4/26.
//  Copyright © 2017年 maxzhang. All rights reserved.
//

#import "ViewController.h"
#import "TopView.h"
#import "FirstTableView.h"
#import "SecondTableView.h"
#import "BackgroundView.h"
#import "UIView+Extension.h"
#define kItemheight 50

#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kTopView_Height 200

@interface ViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *bottomScrollView;
@property (strong, nonatomic) TopView *topView;
@property (strong, nonatomic) FirstTableView *firstTableView;
@property (strong, nonatomic) SecondTableView *secondTableView;

@end

@implementation ViewController


- (void)loadView
{
    [super loadView];
    
    BackgroundView *view = [[BackgroundView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.topView = self.topView;
    view.scrollView = self.bottomScrollView;
    view.firstTableView = self.firstTableView;
    view.secondTableView = self.secondTableView;
    self.view = view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bottomScrollView];
    [self.view addSubview:self.topView];
}


- (UIScrollView *)bottomScrollView
{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _bottomScrollView.contentSize = CGSizeMake(kScreen_Width*2, 0);
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.delegate = self;
        
        [_bottomScrollView addSubview:self.firstTableView];
        [_bottomScrollView addSubview:self.secondTableView];
    }
    return _bottomScrollView;
}


- (TopView *)topView
{
    if (!_topView) {
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopView_Height)];
        _topView.itemHeight = kItemheight;
    }
    return _topView;
}


- (FirstTableView *)firstTableView
{
    if (!_firstTableView) {
        _firstTableView = [[FirstTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _firstTableView.topView = self.topView;
    }
    return _firstTableView;
}


- (SecondTableView *)secondTableView
{
    if (!_secondTableView) {
        _secondTableView = [[SecondTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _secondTableView.x = kScreen_Width;
        _secondTableView.topView = self.topView;
    }
    return _secondTableView;
}


#pragma mark - 底部的scrollViuew的代理方法scrollViewDidScroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat placeholderOffset = 0;
    if (self.topView.getSelectedItemIndex == 0) {
        if (self.firstTableView.contentOffset.y > self.topView.height - kItemheight) {
            placeholderOffset = self.topView.height - kItemheight;
        } else {
            placeholderOffset = self.firstTableView.contentOffset.y;
        }
        [self.secondTableView setContentOffset:CGPointMake(0, placeholderOffset) animated:NO];
    } else {
        if (self.secondTableView.contentOffset.y > self.topView.height - kItemheight) {
            placeholderOffset = self.topView.height - kItemheight;
        } else {
            placeholderOffset = self.secondTableView.contentOffset.y;
        }
        [self.firstTableView setContentOffset:CGPointMake(0, placeholderOffset) animated:NO];
    }
}


#pragma mark - 底部的scrollViuew的代理方法scrollViewDidEndDecelerating

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{    
    NSInteger index = ceilf(scrollView.contentOffset.x / kScreen_Width);
    self.topView.selectedItemIndex = index;
}


@end
