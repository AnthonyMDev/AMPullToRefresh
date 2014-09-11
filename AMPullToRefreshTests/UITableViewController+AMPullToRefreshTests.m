//
//  UITableViewController+AMPullToRefreshTests.m
//  AMPullToRefresh
//
//  Created by Anthony Miller on 8/15/14.
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
#import <UIKit/UITableViewController.h>
#import "UITableViewController+AMPullToRefresh.h"

// Collaborators
#import "AMPullToRefreshView.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface UITableViewController_AMPullToRefreshTests : XCTestCase
@end

@implementation UITableViewController_AMPullToRefreshTests
{
  UITableViewController *sut;
  id mockSUT;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [[UITableViewController alloc] init];
  [sut setUpPullToRefreshView];
}

- (void)givenMockSUT
{
  mockSUT = OCMPartialMock(sut);
  OCMStub([mockSUT refreshTableViewDataWithCompletionHandler:[OCMArg any]]).andDo(^(NSInvocation *invocation) {
    void (^completer)();
    [invocation getArgument:&completer atIndex:2];
    
    completer();
    
  });
}

#pragma mark - Set Up Pull to Refresh Tests

- (void)test___setUpPullToRefreshView___addsPullToRefreshViewToTableView
{
  expect(sut.pullToRefreshView).to.beInstanceOf([AMPullToRefreshView class]);
}

- (void)test___setUpPullToRefreshView___setsDelegate
{
  expect(sut.pullToRefreshView.delegate).to.equal(sut);
}

#pragma mark - AMPullToRefreshViewDelegate Tests

- (void)test___refreshViewDidBeginRefreshing___callsRefreshTableViewData
{
  // given
  [self givenMockSUT];
  
  // when
  [sut refreshViewDidBeginRefreshing:sut.pullToRefreshView];
  
  // then
  OCMVerify([mockSUT refreshTableViewDataWithCompletionHandler:[OCMArg any]]);
}

- (void)test___refreshViewDidBeginRefreshing___reloadsTableViewData
{
  // given
  [self givenMockSUT];
  id mockTableView = OCMPartialMock(sut.tableView);
  
  // when
  [sut refreshViewDidBeginRefreshing:sut.pullToRefreshView];
  
  // then
  OCMVerify([mockTableView reloadData]);
}

- (void)test___refreshViewDidBeginRefreshing___notifiesPullToRefreshViewToEndRefreshing
{
  // given
  [self givenMockSUT];
  id mockPullToRefreshView = OCMPartialMock(sut.pullToRefreshView);
  
  // when
  [sut refreshViewDidBeginRefreshing:sut.pullToRefreshView];
  
  // then
  OCMVerify([mockPullToRefreshView endRefreshing]);
}


@end