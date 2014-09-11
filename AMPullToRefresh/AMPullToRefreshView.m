//
//  AMPullToRefreshView.m
//  AMPullToRefresh
//
//  Created by Anthony Miller on 5/29/14.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "AMPullToRefreshView.h"
#import "AMPullToRefreshView_Protected.h"

#import "NSBundle+AMPullToRefreshBundle.h"

@interface AMPullToRefreshView()
@end

@implementation AMPullToRefreshView

- (instancetype)initWithTableView:(UITableView *)tableView
{
  self = [super init];
  
  if (self) {
    
    [[self bundleToLoadFrom] loadNibNamed:@"AMPullToRefreshNib" owner:self options:nil];
    [self addSubview:self.container];

    [self setTableView:tableView];
    [self addListener];
    
    [tableView addSubview:self.container];
    
    self.container.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.container setFrame:CGRectMake(0, -(self.container.frame.size.height), self.container.frame.size.width, self.container.frame.size.height)];
  }
  
  return self;
}

- (void)addListener
{
  NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
  [notificationCenter addObserver:self selector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:) name:nil object:self.tableView];
}


- (NSBundle *)bundleToLoadFrom
{
  return [NSBundle AMPullToRefreshBundle];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
  CGFloat percentScrolled = [self percentScrolled];
  if (percentScrolled >= 100.0f) {
    [self beginRefreshing];
  }
}

- (CGFloat)percentScrolled
{
  CGFloat offsetY = MAX(-(self.tableView.contentOffset.y + self.tableView.contentInset.top), 0);
  CGFloat percentScrolled = ((offsetY/self.container.frame.size.height) * 100);
  return percentScrolled;
}

- (void)beginRefreshing
{
  if(self.refreshing == YES) {
    return;
  }
  
  if (self.delegate && [self.delegate respondsToSelector:@selector(refreshViewDidBeginRefreshing:)]) {
    
    self.refreshing = YES;
    [self.activityIndicator startAnimating];
    [self displayPullToRefreshView];
    
    [self.delegate refreshViewDidBeginRefreshing:self];

  }
}

- (void)displayPullToRefreshView
{
  [UIView animateWithDuration:0.4f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
    
    UIEdgeInsets newInsets = self.delegate.tableView.contentInset;
    newInsets.top += self.container.frame.size.height;
    [self.delegate.tableView setContentInset:newInsets];
    
  } completion:nil];
}

- (void)endRefreshing
{
  if(self.refreshing == NO) {
    return;
  };
  
  self.refreshing = NO;
  [self.activityIndicator stopAnimating];
  [self hidePullToRefreshView];
}

- (void)hidePullToRefreshView
{
  [UIView animateWithDuration:0.4f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
    
    UIEdgeInsets newInsets = self.delegate.tableView.contentInset;
    newInsets.top -= self.container.frame.size.height;
    [self.delegate.tableView setContentInset:newInsets];
  } completion:nil];
}

@end
