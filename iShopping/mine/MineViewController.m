//
//  MineViewController.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "MineViewController.h"
#import "MineDetailViewController.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Hi，你好";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
//    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 160)];
    imageV.image = [UIImage imageNamed:@"QQ20151013-2"];
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = imageV;
    [self.view addSubview:table];
//    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Mag1c_Panda"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"Mag1c_Panda";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    if (indexPath.section == 0) {
        NSArray *ary1 = @[@"名称",@"开发者",@"联系方式"];
        NSArray *ary2 = @[@"iShopping",@"Mag1c_Panda",@"415391360@qq.com"];
        
        cell.textLabel.text = ary1[indexPath.row];
        cell.detailTextLabel.text = ary2[indexPath.row];
        
    }
    else if (indexPath.section == 1){
        NSArray *ary1 = @[@"请我喝杯咖啡",@"给我一点爱",@"你说的我都放在心上"];
        NSArray *ary2 = @[@"捐赠咖啡☕️",@"五星好评吧🌹",@"意见反馈💬"];
        cell.textLabel.text = ary1[indexPath.row];
        cell.detailTextLabel.text = ary2[indexPath.row];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    MineDetailViewController *vc = [[MineDetailViewController alloc]init];
    
    
    [self.navigationController pushViewController:vc animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.000001;
    }
    else
        return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.000001;
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
