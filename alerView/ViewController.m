//
//  ViewController.m
//  alerView
//
//  Created by xia on 2017/11/21.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "ViewController.h"
#import "RDListAlertView.h"
#import "AlertCreateDataSouce.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, RDListAlertViewDelegate>
@property(nonatomic, strong) NSArray *arr;
@property(nonatomic, strong) NSArray<NSDictionary *> *arr1;
@property(nonatomic, strong) NSArray<NSDictionary *> *arr2;
@property(nonatomic, strong) NSArray<NSDictionary *> *arr3;
@property(nonatomic, strong) NSArray *arr4;
@property(nonatomic, strong) NSArray<AlertIMGAndTFModel *> *arr5;

@property(nonatomic, strong) RDListAlertView *alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableView];
    _arr = @[@"第一种", @"第二种", @"第三种",@"第四种",@"第五种",@"第六种"];
    [self createData];
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self showAlertView];
            break;
        case 1:
            [self showAlert2View];
            break;
        case 2:
            [self showAlert3View];
            break;
        case 3:
            [self showAlert4View];
            break;
        case 4:
            [self showAlert5View];
            break;
        case 5:
            [self showAllAlertView];
            break;
        default:
            break;
    }
}

- (void)createData {
    _arr1 = @[@{@"title":@"费用1",@"value":@"200.00元"},@{@"title":@"费用2",@"value":@"220.00元"}];
    _arr2 = @[@{@"title":@"用户名",@"valueTF":@"请输入用户名",@"isPassword":@"NO"},@{@"title":@"密码",@"valueTF":@"请输入密码",@"isPassword":@"YES"}];
    _arr3 = @[@{@"title":@"验证码",@"Textplaceholder":@"请输入验证码",@"btnStr":@"发送验证码"}];
    _arr4 = @[@{@"title":@"评价",@"placeholderStr":@"请输入评论内容"}];
}

- (void)showAlertView {
    AlertListModel *listModel = [[AlertCreateDataSouce alloc] AlertCreateDadaWithShowcasingArr: _arr1
                                                                 labelAndTFArr:nil
                                                              labelTFAndBtnArr:nil
                                                                   textViewArr:nil];
    RDListAlertView *alertView = [[RDListAlertView alloc] initWithTitle:@"费用详情" inputTextDictionary:listModel cancelButtonTitle:@"我知道啦"];
    alertView.mainColor = [UIColor orangeColor];
    [alertView show];
}
- (void)showAlert2View {
    AlertListModel *listModel = [[AlertCreateDataSouce alloc] AlertCreateDadaWithShowcasingArr:_arr1
                                                                 labelAndTFArr:nil
                                                              labelTFAndBtnArr:@[]
                                                                   textViewArr:nil];
    RDListAlertView *alertView = [[RDListAlertView alloc] initWithTitle:@"" inputTextDictionary:listModel cancelButtonTitle:@"我知道啦"];
    alertView.mainColor = [UIColor orangeColor];
    [alertView show];
}
- (void)showAlert3View {
    AlertListModel *listModel = [[AlertCreateDataSouce alloc] AlertCreateDadaWithShowcasingArr:nil
                                                                 labelAndTFArr:_arr2
                                                              labelTFAndBtnArr:_arr3
                                                                   textViewArr:nil];
    _alertView = [[RDListAlertView alloc] initWithTitle:@"找回密码" inputTextDictionary:listModel sureButtonTitle:@"发送" cancelButtonTitle:@"离开"];
    _alertView.mainColor = [UIColor orangeColor];
    _alertView.textLColor = [UIColor greenColor];
    _alertView.alignmentL = NSTextAlignmentRight;
    __weak typeof(self) weakSelf = self;
    _alertView.sureBtnBlock = ^{
        NSLog(@"点击了确定按钮");
        NSDictionary *dic = [weakSelf.alertView alertTableViewCellContentStringWithCellLabelKey];
        NSLog(@"dic: %@",dic);
    };
    _alertView.cellBtnBlock = ^{
        NSLog(@"点击了cell中按钮");
        NSDictionary *dic = [weakSelf.alertView alertTableViewCellContentStringWithCellLabelKey];
        if (dic) {
            NSString *numberStr = [dic objectForKey:@"用户名"];
            NSLog(@"numberStr: %@",numberStr);
        }
    };
    
    [_alertView show];
}

- (void)showAlert4View {
    AlertListModel *listModel = [[AlertCreateDataSouce alloc] AlertCreateDadaWithShowcasingArr:nil
                                                                 labelAndTFArr:nil
                                                              labelTFAndBtnArr:nil
                                                                   textViewArr:_arr4];
    _alertView = [[RDListAlertView alloc] initWithTitle:@"给我们评分" inputTextDictionary:listModel cancelButtonTitle:@"评价"];
    _alertView.mainColor = [UIColor orangeColor];
    _alertView.textLColor = [UIColor greenColor];
    _alertView.alignmentL = NSTextAlignmentRight;
    __weak typeof(self) weakSelf = self;
    _alertView.dismissBlock = ^{
        NSDictionary                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    *dic = [weakSelf.alertView alertTableViewCellContentStringWithCellLabelKey];
        NSLog(@"dic: %@",dic);
    };
    [_alertView show];
}

- (void)showAlert5View {
    _arr5 = [[AlertCreateDataSouce alloc] createIMGTFArr:@[@{@"IMGStr":@"money",@"valueTF":@"连连还款1"},
                                                                                        @{@"IMGStr":@"money",@"valueTF":@"连连还款22"},
                                                                                        @{@"IMGStr":@"money",@"valueTF":@"连连还款333"},
                                                                                        @{@"IMGStr":@"money",@"valueTF":@"连连还款44444"}]];
    _alertView = [[RDListAlertView alloc] initWithTitle:@"还款方式" IMGTFDictionary:_arr5 cancelButtonTitle:@""];
    _alertView.alertDelegate = self;
    _alertView.mainColor = [UIColor orangeColor];
    [_alertView show];
}

- (void)showAllAlertView {
    AlertListModel *listModel = [[AlertCreateDataSouce alloc] AlertCreateDadaWithShowcasingArr:_arr1
                                                                 labelAndTFArr:_arr2
                                                              labelTFAndBtnArr:_arr3
                                                                   textViewArr:_arr4];
    _alertView = [[RDListAlertView alloc] initWithTitle:@"所有的" inputTextDictionary:listModel sureButtonTitle:@"发送" cancelButtonTitle:@"离开"];
    _alertView.mainColor = [UIColor orangeColor];
    _alertView.textLColor = [UIColor greenColor];
    _alertView.alignmentL = NSTextAlignmentRight;
    __weak typeof(self) weakSelf = self;
    _alertView.sureBtnBlock = ^{
        NSLog(@"点击了确定按钮");
        NSDictionary *dic = [weakSelf.alertView alertTableViewCellContentStringWithCellLabelKey];
        NSLog(@"dic: %@",dic);
    };
    _alertView.cellBtnBlock = ^{
        NSLog(@"点击了cell中按钮");
        NSDictionary *dic = [weakSelf.alertView alertTableViewCellContentStringWithCellLabelKey];
        if (dic) {
            NSString *numberStr = [dic objectForKey:@"用户名"];
            NSLog(@"numberStr: %@",numberStr);
        }
    };
    
    [_alertView show];
}

- (void)RDListAlertTableViewImageLabelCellSelectedWithIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = _arr5[indexPath.row].valueTF;
    vc.view.backgroundColor = [UIColor orangeColor];
    [_alertView dismissAlert];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
