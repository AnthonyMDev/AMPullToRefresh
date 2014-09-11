//
//  AMPullToRefreshView_Protected.h
//  AMPullToRefresh
//
//  Created by Anthony Miller on 6/2/14.
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

/**
 *  `AMPullToRefreshView_Protected` contains internal properties used by `AMPullToRefreshView` that should not be used by other controllers or classes. These properties are only exposed for unit testing purposes (see `AMPullToRefreshViewTests.m`)
 */
@interface AMPullToRefreshView ()

/**
 *  Tracks if the view is currently refreshing. This is set to YES when `beingRefreshing` is called and set to NO upon `endRefreshing`.
 */
@property (nonatomic) BOOL refreshing;

/**
 *  The activity indicator for the view. This starts animating as the `refreshViewDidBeginRefreshing:` delegate method is called.
 */
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

/**
 *  Displays the view, starts animation of the `UIActivityIndicator` and calls the delegate method `refreshViewDidBeginRefreshing`. This method is called during the implementation of the `UIScrollViewDelegate`'s `scrollViewWillEndDragging:withVelocity:targetContentOffset` method.
 */
- (void)beginRefreshing;

/**
 *  Sets the contentInsets of the `UITableView` to display the view. This method is called by `beginRefreshing and should not be called manually.
 */
- (void)displayPullToRefreshView;

/**
 *  Sets the contentInsets of the `UITableView` to hide the view. This method is called by `endRefreshing and should not be called manually.
 */
- (void)hidePullToRefreshView;

/**
 *  Calculates the percent of the `AMPullToRefreshView` that has been scrolled to display and returns the value. The implementation of `scrollViewWillEndDragging:withVelocity:targetContentOffset:` uses this value to determine if it will call `beginRefreshing`.
 *
 *  @return A CGFloat representing the percent of the view scrolled.
 */
- (CGFloat)percentScrolled;

@end
