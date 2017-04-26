//
//  BackgroundView.m
//  DemoTable
//
//  Created by Max on 2017/4/26.
//  Copyright © 2017年 maxzhang. All rights reserved.
//

#import "BackgroundView.h"
#import "TopView.h"
#import "FirstTableView.h"
#import "SecondTableView.h"
#import "ViewController.h"

#ifndef kScreen_Width
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreen_Height
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#endif

@implementation BackgroundView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


#pragma mark - 重载系统的hitTest方法

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    ViewController *currentVC = (ViewController *)self.nextResponder;
    currentVC.printPoint = point;
    if ([self.topView pointInside:point withEvent:event]) {
        self.scrollView.scrollEnabled = NO;
        if (self.scrollView.contentOffset.x < kScreen_Width *0.5) {
            return self.firstTableView;
        } else {
            return self.secondTableView;
        }
    } else {
        self.scrollView.scrollEnabled = YES;
        return [super hitTest:point withEvent:event];
    }
}


#pragma mark - 添加手势的相应方法

- (void)tapGestureAction:(UITapGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.topView];
    if (CGRectContainsPoint(self.topView.leftBtnFrame, point)) {
        if (self.scrollView.contentOffset.x > 0.5 * kScreen_Width) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            self.topView.selectedItemIndex = 0;
        }
    } else if (CGRectContainsPoint(self.topView.rightBtnFrame, point)) {
        if (self.scrollView.contentOffset.x < 0.5 * kScreen_Width) {
            [self.scrollView setContentOffset:CGPointMake(kScreen_Width, 0) animated:NO];
            self.topView.selectedItemIndex = 1;
        }
    }
}

@end
