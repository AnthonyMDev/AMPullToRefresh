//
//  AMPullToRefreshView.h
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


#import <UIKit/UIKit.h>

@class AMPullToRefreshView;

/**
 *  The `AMPullToRefreshDelegate` protocol must be implemented by the `UITableViewController` that contains the `AMPullToRefreshView`.
 */
@protocol AMPullToRefreshDelegate <UIScrollViewDelegate>

/**
 *  This delegate method will be called once the pull to refresh view has been pulled down completely. Code to obtain new content and reload the `UITableView` should be implemented here.
 *
 *  @warning The method `endRefreshing` must be called after the UITableView has refreshed to notify the pull to refresh view to slide out.
 *
 *  @param pullToRefreshView The `AMPullToRefreshView` that has been pulled down to trigger the refresh.
 */
- (void)refreshViewDidBeginRefreshing:(AMPullToRefreshView *)pullToRefreshView;

@optional

/**
 *  This method optionally holds logic for retrieving new data for the `UITableView` to be reloaded. This method can be  implemented called within `refreshViewDidBeginRefreshing` to get new data asynchronously before reloading the table view cells.
 */
- (void)refreshTableViewDataWithCompletionHandler:(void (^)())completion;

@end

/**
 *  A `UIView` for `UITableView` pull to refresh functionality.
 */
@interface AMPullToRefreshView : UIView <UIScrollViewDelegate>

/**
 *  This method initializes the `AMPullToRefreshView` and adds the view to the `UITableView`.
 *
 *  @param tableView The UITableView that the `AMPullToRefreshView` will be added to.
 *
 *  @return Returns an initialized `AMPullToRefreshView` object or nil if the object could not be successfully initialized.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  This method notifies the `AMPullToRefreshView` that the refresh is complete. The view will slide up to hide and the activity indicator will stop animating when this method is called.
 *
 *  @warning This method should be called upon completion of each call to `refreshViewDidBeginRefreshing:`.
 */
- (void)endRefreshing;

/**
 *  The delegate for this view. This must be a `UITableViewController` that implements the `AMPullToRefreshDelegate` protocol.
 */
@property (strong, atomic) UITableViewController <AMPullToRefreshDelegate>* delegate;

/**
 *  The `UITableView` in which this view appears.
 */
@property (weak, nonatomic) UITableView *tableView;

/**
 *  The container for the contents of the view's NIB.
 */
@property (strong, nonatomic) IBOutlet UIView *container;

/**
 *  The text of the view. By default, this is set to "Pull To Refresh".
 */
@property (weak, nonatomic) IBOutlet UILabel *label;

@end