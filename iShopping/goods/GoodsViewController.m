//
//  GoodsViewController.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "GoodsViewController.h"
#import "SearchViewController.h"
#import "GoodsCell.h"
#import "WikiModel.h"
#import "HotKeyModel.h"
#import "GoodDetailViewController.h"
@interface GoodsViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *search;
    UIView *header;
    UITableView *table;
    WikiModel *model;
    HotKeyModel *keyModel;
    CGFloat labHeight;
    
    
    
    NSMutableArray *dataArrray;
}
@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataArrray = [NSMutableArray array];
    [self loadNetData];
    
    self.navigationItem.title = @"商品";
   
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"spbk_Category"]  style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
//    [self.navigationItem hidesBackButton];
    
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 300,20)];
    self.navigationItem.titleView = search;
    search.placeholder = @"搜索商品内容";
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.delegate =self;
    //    UISearchBarStyleProminent,  // used my Mail, Messages and Contacts
    //    UISearchBarStyleMinimal
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [table addHeaderWithTarget:self action:@selector(headRefresh)];
    [table addFooterWithTarget:self action:@selector(footLoadMore)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 145)];
    header.backgroundColor = [UIColor colorWithRed:229/255.0 green:230/255.0 blue:233/255.0 alpha:0.5];
    table.tableHeaderView = header;
    
    
    UINib *nib = [UINib nibWithNibName:@"GoodsCell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"GoodsCell"];
    

}

-(void)headRefresh{

    [self loadNetData];
}

-(void)footLoadMore{
    int offset = 0;
    offset += 20;
    NSString *url = [NSString stringWithFormat:@"%@&offset=%d",WIKIURL,offset];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        model = [[WikiModel alloc]initWithData:operation.responseData error:nil];
        for (WikiRowsModel *rowMod in model.data.rows) {
            [dataArrray addObject:rowMod];
        }
        
        [table headerEndRefreshing];
        [table footerEndRefreshing];
        [table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)loadNetData{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:WIKIURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        model = [[WikiModel alloc]initWithData:operation.responseData error:nil];
        for (WikiRowsModel *rowMod in model.data.rows) {
            [dataArrray addObject:rowMod];
        }
        
        [table headerEndRefreshing];
        [table footerEndRefreshing];
        [table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    NSString *hotKey = @"http://api.smzdm.com/v1/wiki/hot_tags?f=iphone&s=561083b057156759800&v=5.11&limit=20";
    [manager GET:hotKey parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = operation.responseString;
        keyModel = [[HotKeyModel alloc]initWithString:str error:nil];
        
        for (int i=0; i<3; i++) {
            for (int j=0; j<3; j++) {
                HotKeyDataModel *dataModel = keyModel.data[i*3+j];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(20+j*(SCREENW-40)/3, 10+i*45, (SCREENW-40)/3-10, 30);
                btn.layer.cornerRadius = 15;
                btn.backgroundColor = [UIColor whiteColor];
                btn.layer.borderColor = [UIColor grayColor].CGColor;
                btn.layer.borderWidth = 0.5;
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                [btn setTitle:dataModel.tag_name forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [header addSubview:btn];
            }
            
        }
        

        [table headerEndRefreshing];
        [table footerEndRefreshing];
        [table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)pressLeft{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
//    [search resignFirstResponder];
    
    [self.navigationController pushViewController:searchVC animated:NO];
}

#pragma mark - table的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell"];
    WikiRowsModel *rowsModel = dataArrray[indexPath.row];
    
//    NSLog(@"labH %f",labHeight);
    [cell setUIWithInfo:rowsModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 370+labHeight ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
    WikiRowsModel *rowsMod = dataArrray[indexPath.row];
    vc.picUrl = rowsMod.article_pic;
    vc.detail = rowsMod.article_reason;
    [self.navigationController pushViewController:vc animated:YES];
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
