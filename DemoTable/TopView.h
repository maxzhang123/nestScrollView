//
//  TopView.h
//  DemoTable
//
//  Created by Max on 2017/4/26.
//  Copyright © 2017年 maxzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView

@property (assign, nonatomic) CGFloat itemHeight;
@property (assign, nonatomic, getter=getSelectedItemIndex) NSInteger selectedItemIndex;

@property (assign, nonatomic) CGRect leftBtnFrame;
@property (assign, nonatomic) CGRect rightBtnFrame;

@end
