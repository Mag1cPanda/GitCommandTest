//
//  SearchViewController.m
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "SearchViewController.h"
#import "GoodsCell.h"
#import "WikiModel.h"
#import "GoodDetailViewController.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *search;
    NSMutableArray *searchList;
    UITableView *table;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 30);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 300,20)];
    self.navigationItem.titleView = search;
    search.placeholder = @"搜索商品内容";
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.delegate =self;
    [search becomeFirstResponder];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressRight)];
    
    searchList = [NSMutableArray array];
    table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    UINib *nib = [UINib nibWithNibName:@"GoodsCell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"GoodsCell"];
    
}

-(void)loadNetData{
    NSString *str = @"http://api.smzdm.com/v1/wiki/articles?offset=0&order=byrecommend&imgmode=0&limit=20&get_total=1&v=5.11&f=iphone&s=561083b057156759800&search=";
    
//    NSString *str = [NSString str]
    NSString *codeStr = [search.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",str,codeStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        WikiModel *model = [[WikiModel alloc]initWithData:operation.responseData error:nil];
        for (WikiRowsModel *rowMod in model.data.rows) {
            [searchList addObject:rowMod];
        }
        
        
        
        [table reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
}


-(void)pressRight{
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - searchBar代理
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"%@",searchBar.text);
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchList removeAllObjects];
    [self loadNetData];
    
}




#pragma mark - table代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return searchList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (searchList.count > indexPath.row) {
        GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell"];
        WikiRowsModel *rowMod = searchList[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setUIWithInfo:rowMod];
        
        return cell;
    }
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 370;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
    WikiRowsModel *rowsMod = searchList[indexPath.row];
    vc.picUrl = rowsMod.article_pic;
    vc.detail = rowsMod.article_reason;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
[search resignFirstResponder];
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
