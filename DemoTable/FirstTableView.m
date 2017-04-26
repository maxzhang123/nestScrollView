//
//  FirstTableView.m
//  DemoTable
//
//  Created by Max on 2017/4/26.
//  Copyright © 2017年 maxzhang. All rights reserved.
//

#import "FirstTableView.h"
#import "TopView.h"
#import "UIView+Extension.h"
#import "ViewController.h"

#ifndef kScreen_Width
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreen_Height
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#endif


@interface FirstTableView ()<UITableViewDelegate, UITableViewDataSource>



@end


@implementation FirstTableView


- (void)setTopView:(TopView *)topView
{
    _topView = topView;
    
    self.dataSource = self;
    self.delegate = self;
    
    self.scrollIndicatorInsets = UIEdgeInsetsMake(self.topView.height, 0, 0, 0);
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.topView.height)];
    self.tableHeaderView = tableHeaderView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseFirstTableViewCell = @"reuseFirstTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseFirstTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseFirstTableViewCell];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"FirstTableView:第%ld行", (long)indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        ViewController *currentVC = (ViewController *)scrollView.nextResponder.nextResponder;
        
        if (currentVC.printPoint.x < kScreen_Width/2.0f) {
            if (scrollView.contentOffset.x > kScreen_Width *0.5) {
                [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
        else {
            if (scrollView.contentOffset.x < kScreen_Width *0.5) {
                [scrollView setContentOffset:CGPointMake(kScreen_Width, 0) animated:YES];
            }
        }
    }
    else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"FirstTableView_didSelectRowAtIndexPathRow:%ld", (long)indexPath.row);
        
    }
}


#pragma mark - firstTableView的代理方法scrollViewDidScroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat placeHolderHeight = self.topView.height - self.topView.itemHeight;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0 && offsetY <= placeHolderHeight) {
        self.topView.y = -offsetY;
    }
    else if (offsetY > placeHolderHeight) {
        self.topView.y = - placeHolderHeight;
    }
    else if (offsetY <0) {
        self.topView.y =  - offsetY;
    }
}


@end
