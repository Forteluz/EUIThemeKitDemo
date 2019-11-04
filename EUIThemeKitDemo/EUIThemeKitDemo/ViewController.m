//
//  ViewController.m
//
//  Created by Lux on 2019/9/18.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_addTableView];

    NSDictionary *systemUI = @
    {
        @"name"  : @"更换系统组件主题",
        @"items" : @[@"UIButton", @"UILabel", @"UITableViewCell"],
    };
    NSDictionary *customUI = @
    {
        @"name"  : @"更换自定义组件主题",
        @"items" : @[@"Custom"]
    };
    self.data = @[
                  systemUI,
                  customUI,
                  ];
}

#pragma mark - ---| UITableViewDelegate & UITableViewDataSource |---

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kTableViewCell"];
    NSDictionary *dict = [self.data objectAtIndex:indexPath.section];
    cell.textLabel.text = [[dict objectForKey:@"items"] objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    NSDictionary *dict = self.data[section];
    return [[dict objectForKey:@"items"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dict = self.data[section];
    return [dict objectForKey:@"name"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *item = self.data[indexPath.section][@"items"][indexPath.row];
    NSString *clsName = [NSString stringWithFormat:@"Demo%@ViewController",item];
    if (NSClassFromString(clsName)) {
        UIViewController *one = [[NSClassFromString(clsName) alloc] init];
        one.modalPresentationStyle = UIModalPresentationAutomatic;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:one];
        [self presentViewController:navi animated:YES completion:nil];
    }
}

#pragma mark - ---| UI-Parts |---

- (void)p_addTableView {
    UITableView *one = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [one setDelegate:self];
    [one setDataSource:self];
    [one registerClass:UITableViewCell.class forCellReuseIdentifier:@"kTableViewCell"];
    [self.view addSubview:one];
    [self setTableView:one];
}

@end
