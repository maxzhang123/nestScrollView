//
//  TopView.m
//  DemoTable
//
//  Created by Max on 2017/4/26.
//  Copyright © 2017年 maxzhang. All rights reserved.
//

#import "TopView.h"

#ifndef kScreen_Width
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreen_Height
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#endif

@interface TopView ()

@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

@end

@implementation TopView


- (void)setItemHeight:(CGFloat)itemHeight
{
    _itemHeight = itemHeight;
    self.backgroundColor = [UIColor yellowColor];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, self.frame.size.height - itemHeight, kScreen_Width /2, itemHeight);
    [leftBtn setTitle:@"FirstItem" forState:UIControlStateNormal];
    leftBtn.enabled = NO;
    leftBtn.backgroundColor = [UIColor whiteColor];
    leftBtn.layer.borderWidth = 0.5;
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftBtn.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:leftBtn];
    _leftBtn = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(kScreen_Width /2, self.frame.size.height - itemHeight, kScreen_Width /2, itemHeight);
    [rightBtn setTitle:@"SecondItem" forState:UIControlStateNormal];
    rightBtn.enabled = NO;
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.layer.borderWidth = 0.5;
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    rightBtn.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:rightBtn];
    _rightBtn = rightBtn;
    
    
    self.leftBtnFrame = leftBtn.frame;
    self.rightBtnFrame = rightBtn.frame;
    
}



- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    _selectedItemIndex = selectedItemIndex;
    
    if (selectedItemIndex == 0) {
        [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else {
        [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}


@end
