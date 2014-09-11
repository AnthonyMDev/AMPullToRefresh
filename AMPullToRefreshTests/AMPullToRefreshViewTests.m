//
//  AMPullToRefreshViewTests.m
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


// Test Class
#import "Test_AMPullToRefreshView.h"
#import "AMPullToRefreshView_Protected.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface AMPullToRefreshViewTests : XCTestCase

@end

@implementation AMPullToRefreshViewTests
{
  Test_AMPullToRefreshView *sut;
  UITableViewController <AMPullToRefreshDelegate> *tableViewController;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  tableViewController = [self givenMockTableViewController];
  sut = [[Test_AMPullToRefreshView alloc] initWithTableView: tableViewController.tableView];
}

#pragma mark - Utilities

- (UITableViewController <AMPullToRefreshDelegate> *)givenMockTableViewController
{
  UITableViewController <AMPullToRefreshDelegate> *controller = mockObjectAndProtocol([UITableViewController class], @protocol(AMPullToRefreshDelegate));
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
  
  [given([controller tableView]) willReturn:tableView];
  return controller;
}


#pragma mark - Initialization Tests

- (void)test_isSubclassOf_UIView
{
  XCTAssertTrue([sut isKindOfClass:[UIView class]]);
}

- (void)test___sut___has_container {
  XCTAssertNotNil(sut.container);
}

- (void)test_addsSubview_container__tableView {
  assertThat(tableViewController.tableView.subviews, hasItem(sut.container));
}

- (void)test_initializesWith_tableView
{
    assertThat(sut.tableView, is(equalTo(tableViewController.tableView)));
}

- (void)test_initializesWith_refreshingEqualTo_False
{
  assertThatBool(sut.refreshing, is(equalToBool(NO)));
}

- (void)test_initializesWith_activityIndicator_stopped
{
  assertThatBool(sut.activityIndicator.isAnimating, is(equalToBool(NO)));
}

#pragma mark - Delegate Tests

- (void)test_delegate_respondsToSelector_refreshViewDidBeginRefreshing
{
  // given
  sut.delegate = tableViewController;
  // then
  assertThatBool([sut.delegate respondsToSelector:@selector(refreshViewDidBeginRefreshing:)], is(equalToBool(YES)));
}

- (void)test___scrollViewWillEndDragging_withVelocity_targetContentOffset___givenPercentScrolled_100_beginsRefreshing
{
  //given
  sut.delegate = tableViewController;
  [sut.tableView setContentOffset:CGPointMake(0, -(sut.container.frame.size.height))];
  CGPoint zeroPoint = CGPointMake(0, 0);
  // when
  [sut scrollViewWillEndDragging:sut.tableView withVelocity:CGPointZero targetContentOffset:&zeroPoint];
  // then
  assertThatBool(sut.refreshing, is(equalToBool(YES)));
}

#pragma mark - Class Method Tests

- (void)test___percentScrolled_givenContentOffsetEqualToViewHeight_is100
{
  // given
  [sut.tableView setContentOffset:CGPointMake(0, -(sut.container.frame.size.height))];
  // when
   CGFloat percentScrolled = [sut percentScrolled];
  // then
  assertThatFloat(percentScrolled, is(equalToFloat(100.0f)));
}

- (void)test___percentScrolled___givenContentOffsetEqualToHalfViewHeight_is50
{
  //given
  [sut.tableView setContentOffset:CGPointMake(0, -(sut.container.frame.size.height/2))];
  //when
  CGFloat percentScrolled = [sut percentScrolled];
  //then
  assertThatFloat(percentScrolled, is(equalToFloat(50.0f)));
}

- (void)test___beginRefreshing___setsRefreshingToYes
{
  //given
  sut.delegate = tableViewController;
  // when
  [sut beginRefreshing];
  // then
  assertThatBool(sut.refreshing, is(equalToBool(YES)));
}

- (void)test___beingRefreshing___startsActivityIndicator
{
  // given
  sut.delegate = tableViewController;
  // when
  [sut beginRefreshing];
  // then
  assertThatBool(sut.activityIndicator.isAnimating, is(equalToBool(YES)));
}

- (void)test___endRefreshing___setsRefreshingToNo
{
  //given
  sut.delegate = tableViewController;
  // when
  [sut beginRefreshing];
  [sut endRefreshing];
  // then
  assertThatBool(sut.refreshing, is(equalToBool(NO)));
}

- (void)test___endRefreshing___stopsActivityIndicator
{
  // given
  sut.delegate = tableViewController;
  // when
  [sut endRefreshing];
  // then
  assertThatBool(sut.activityIndicator.isAnimating, is(equalToBool(NO)));
}

- (void)test___displayPullToRefreshView___addsPullToRefreshViewHeightFromContentInset
{
  // given
  CGFloat oldTopInset = sut.tableView.contentInset.top;
  CGFloat heightToAdd = sut.frame.size.height;
  // when
  [sut displayPullToRefreshView];
  // then
  assertThatFloat(sut.tableView.contentInset.top, is(equalToFloat(oldTopInset + heightToAdd)));
}

- (void)test___hidePullToRefreshView___subtractsPullToRefreshViewHeightFromContentInset
{
  // given
  CGFloat oldTopInset = sut.tableView.contentInset.top;
  CGFloat heightToSubtract = sut.frame.size.height;
  // when
  [sut displayPullToRefreshView];
  // then
  assertThatFloat(sut.tableView.contentInset.top, is(equalToFloat(oldTopInset - heightToSubtract)));
}
@end