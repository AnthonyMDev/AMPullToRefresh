AMPullToRefresh
===============

An easy to use pull to refresh element to add to a UITableViewController. 

Features
------------------------
* iOS 7 & 8 supported
* Installation with [CocoaPods](http://cocoapods.org/)

Installation With CocoaPods
------------------------

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the ["Getting Started" for more information](http://guides.cocoapods.org/using/getting-started.html).

#### Podfile

```ruby
platform :ios, '7.0'
pod 'AMPullToRefresh', '~> 1.0'
```

How To Use
------------------------

You can add an AMPullToRefreshView to any UITableView with the designated initializer.

```
- (void)viewDidLoad {
  [super viewDidLoad];
  AMPullToRefreshView *refreshView = [[AMPullToRefreshView alloc] initWithTableView:myTableView];
  refreshView.delegate = myTableViewController;
}
```

The delegate of the AMPullToRefreshView should be a UITableViewController that implements the AMPullToRefreshDelegate.

```
- (void)refreshViewDidBeginRefreshing:(AMPullToRefreshView *)pullToRefreshView {
  ///Add logic to refresh data source.

  [self.tableView reloadData];
  [pullToRefreshView endRefreshing];
}
```
