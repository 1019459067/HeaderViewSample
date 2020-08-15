//
//  TestViewController.m
//  HeaderViewSample
//
//  Created by HN on 2020/8/5.
//  Copyright © 2020 HN. All rights reserved.
//

#import "TestViewController.h"
#import "TableHeaderView.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TableHeaderView *headerView;
@property (strong, nonatomic) UIView *header;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger num;
@end

@implementation TestViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_SAFE_AREA_MARGIN_TOP, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_SAFE_AREA_MARGIN_TOP) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.delaysContentTouches = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.num = 20;
    
    self.header = [[UIView alloc]init];
    self.headerView = [TableHeaderView headerContentView];
    CGFloat height = [self.headerView rowHeightWithModelsWithCellCount:self.num];
    
    self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    self.headerView.frame = self.header.bounds;
    [self.header addSubview:self.headerView];
    
    self.tableView.tableHeaderView = self.header;
    self.tableView.tableFooterView = [UIView new];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, SCREEN_SAFE_AREA_MARGIN_TOP, SCREEN_WIDTH, height);
    button.backgroundColor = UIColor.blackColor;
    button.alpha = 0.5;
    [button setTitle:@"Test" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(onActionClickedNormal:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(onActionClickedHighlighted:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(onActionClickedNormal:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:button];
}

- (void)onActionClickedHighlighted:(UIButton *)sender
{
    [sender setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.whiteColor;
    sender.layer.borderColor = UIColor.greenColor.CGColor;
    sender.layer.borderWidth = 2;
}

- (void)onActionClickedNormal:(UIButton *)sender
{
    self.num++;
    CGFloat height = [self.headerView rowHeightWithModelsWithCellCount:self.num];
    self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    self.tableView.tableHeaderView = self.header;

    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.blackColor;
    sender.layer.borderColor = UIColor.clearColor.CGColor;
    sender.layer.borderWidth = 0;
    
    sender.selected = !sender.selected;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 125.5;
    } else {
        return 93.5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.redColor;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"tcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index: %ld",indexPath.row];
    cell.backgroundColor = UIColor.whiteColor;
//    cell.selectionStyle =
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
