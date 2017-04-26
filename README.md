# nestScrollView
nested tableView slide fluency
因为最近工作项目中需要用到UIScrollView嵌套UItableView嵌套交互问题，顺便网上搜了下的demo，发现实现的效果并不是很理想，滑动偶尔会有延迟现象，所以自己想了个办法，顺便把自己实现写了个demo分享出来，当然有更好的实现欢迎留言。



实现过程，最底部放置的为一个UIScrollView，设置ScrollView的contentSize属性，使可以发生横向滚动，同时隐藏横向滚动条，设置代理为当前控制器本身。然后，在最底部的UIScrollView上放置2个UITableView,因为只有2个所以没有考虑重用问题，如果数量大于3个建议写下UIScrollView子视图的重用。最后在最上面覆盖一个topView，使得它可以和tableView发生纵向滚动，为了实现最上面的topView可以随着tableView发生一起滚动，需要在tableView的scrollViewDidScroll代理方法中获取tableview的contentOffset偏移量，随便改变topView的frame。

当手势点开始落在从topView上时候，在controller的loadView方法中设置自定义view，通过在自定义view中重载hittest方法，判断是否需要让tableView进行交互。此时需要注意的是因为有自定义的左右选择segmentControl，这么设置的时候segmentController是不会相应点击方法的。为了让segmentController可以实现随着tableView滚动并且可以相应单击事件，我在在controller的view上添加了单击手势，判定是否点击在了自定义的segmentControll上(因为tableView本身不会相应- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event事件，所以也可以自定义一个tableVuew,重载touchBegin 等方法，然后把tableView继承自这个tableView， 这样就可以相应相应的touchbegin等方法了)， 好了，下面直接上代码

controller中代码如下：

#pragma mark - 底部的scrollViuew的代理方法scrollViewDidScroll

 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat placeholderOffset = 0;
    if (self.topView.getSelectedItemIndex == 0) {

        if (self.firstTableView.contentOffset.y > self.topView.height - kItemheight) {
            placeholderOffset = self.topView.height - kItemheight;
        }
         else {
            placeholderOffset = self.firstTableView.contentOffset.y;
        }
        [self.secondTableView setContentOffset:CGPointMake(0, placeholderOffset) animated:NO];
    }
     else {
        if (self.secondTableView.contentOffset.y > self.topView.height - kItemheight {
            placeholderOffset = self.topView.height - kItemheight;
        }
         else {
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



controller的view中部分代码如下 

#pragma mark - 重载系统的hitTest方法

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    ViewController *currentVC = (ViewController *)self.nextResponder;
    currentVC.printPoint = point;

    if ([self.topView pointInside:point withEvent:event]) {

        self.scrollView.scrollEnabled = NO;

        if (self.scrollView.contentOffset.x < kScreen_Width *0.5) {
            return self.firstTableView;
        }
         else {
            return self.secondTableView;
        }
    }
     else {
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
    }
     else if (CGRectContainsPoint(self.topView.rightBtnFrame, point)) {

        if (self.scrollView.contentOffset.x < 0.5 * kScreen_Width) {
            [self.scrollView setContentOffset:CGPointMake(kScreen_Width, 0) animated:NO];
            self.topView.selectedItemIndex = 1;
        }
    }
}



firstTableView中部分代码如下

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



secondTableView中部分代码如下

#pragma mark - secondTableView的代理方法scrollViewDidScroll

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
            
