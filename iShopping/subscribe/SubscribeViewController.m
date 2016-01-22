//
//  SubscribeViewController.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SubscribeModel.h"
#import "SubscribeCell.h"
#import "ThirdCell.h"
@interface SubscribeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    SubscribeModel *model;
    
    NSMutableArray *dataArray;
    int num;
}
@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataArray = [NSMutableArray array];
    self.navigationItem.title = @"推荐";
    //改变系统自带的返回键的颜色
//    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0,40, 44);
//    [btn setTitle:@"管理" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    num = 0;
    [self loadNetData];
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [table addHeaderWithTarget:self action:@selector(headerRefresh)];
    [table addFooterWithTarget:self action:@selector(footerLoadMore)];
    [self.view addSubview:table];
    
    UINib *nib = [UINib nibWithNibName:@"SubscribeCell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"SubscribeCell"];
}

-(void)headerRefresh{
    [self loadNetData];
}

-(void)footerLoadMore{
    
    num += 20;
    NSString *str = [NSString stringWithFormat:@"%d",num];
    NSLog(@"%@",str);
    NSString *url = @"http://api.smzdm.com/v1/user/dingyue/articles";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"f":@"iphone",@"v":@"5.11",@"offset":str,@"s":@"561083b057156759800",@"token":@"56167c9e10e44534750",@"limit":@"20"};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = operation.responseString;
        model = [[SubscribeModel alloc]initWithString:str error:nil];
        for (SubRowsModel *subMod in model.data.rows) {
            [dataArray addObject:subMod];
        }
        
        [table headerEndRefreshing];
        [table footerEndRefreshing];
        [table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(void)loadNetData{
   
    NSString *url = @"http://api.smzdm.com/v1/user/dingyue/articles";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"f":@"iphone",@"v":@"5.11",@"offset":@"0",@"s":@"561083b057156759800",@"token":@"56167c9e10e44534750",@"limit":@"20"};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = operation.responseString;
        model = [[SubscribeModel alloc]initWithString:str error:nil];
        for (SubRowsModel *subMod in model.data.rows) {
            [dataArray addObject:subMod];
        }
        
        [table headerEndRefreshing];
        [table footerEndRefreshing];
        [table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubscribeCell"];
    SubRowsModel *rowsModel = dataArray[indexPath.row];
   
    [cell setUIWithInfo:rowsModel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *webVC = [[WebViewController alloc]init];
    SubRowsModel *rowsModel = dataArray[indexPath.row];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.url = rowsModel.article_url;
    webVC.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [webVC.view addSubview:webVC.webView];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:webVC.url]];
    [webVC.webView loadRequest:request];
    [self.navigationController pushViewController:webVC animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
