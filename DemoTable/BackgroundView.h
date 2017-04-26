//
//  BackgroundView.h
//  DemoTable
//
//  Created by Max on 2017/4/26.
//  Copyright © 2017年 maxzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopView;
@class FirstTableView;
@class SecondTableView;

@interface BackgroundView : UIView

@property (strong ,nonatomic) TopView *topView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FirstTableView *firstTableView;
@property (strong, nonatomic) SecondTableView *secondTableView;

@end
