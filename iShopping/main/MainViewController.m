//
//  MainViewController.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "MainViewController.h"
#import "SecondCell.h"
#import "ThirdCell.h"
#import "AFNetworking.h"
#import "MainModel.h"
#import "UIImageView+AFNetworking.h"
#import "SubModel.h"
#import "WebViewController.h"
#import "CellModel.h"
#import "iCarousel.h"
#import "XTSegmentControl.h"
#import "FXCollectionViewCell.h"
#import "YCCollectionViewCell.h"
#import "ZXTableViewCell.h"
#import "ZCCollectionViewCell.h"
#import "VerModel.h"

@interface MainViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate,
iCarouselDataSource,
iCarouselDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
SecondCellDelegate,
UIAlertViewDelegate>
{
    UITableView *table;
    UITableView *yhTable;
    UITableView *htTable;
    UITableView *zxTable;
    

    UICollectionView *ycCollection;
    UICollectionView *zcCollection;
    
    UIScrollView *scroll;
    UIScrollView *imgScroll;
    NSTimer *timer;
    UIPageControl *page;
    UIView *header;
    NSInteger btnIndex;
    MainModel *model;
    CellModel *modelOfCell;
    
    NSMutableArray *jxDataArray;
    NSMutableArray *yhDataArray;
    NSMutableArray *htDataArray;
    NSMutableArray *ycDataArray;
    NSMutableArray *zxDataArray;
    NSMutableArray *zcDataArray;
    
    int hourValue;
    NSDate *ycDate;
    NSDate *zxDate;
    int urlOffset;
    NSString *url;
    NSString *timeSort;
    
    WebViewController *web;
}
@property (nonatomic , strong) iCarousel *carousel;
@property (nonatomic , strong) HMSegmentedControl *segmentControl;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread sleepForTimeInterval:1.5];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"爱购";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_search"]  style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    
    jxDataArray = [NSMutableArray array];
    yhDataArray = [NSMutableArray array];
    htDataArray = [NSMutableArray array];
    ycDataArray = [NSMutableArray array];
    zxDataArray = [NSMutableArray array];
    zcDataArray = [NSMutableArray array];
    url = @"";
    urlOffset = 0;
    page.currentPage = 1;
    web = [WebViewController new];
    
    //改变系统自带的返回键的颜色
//    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    [self checkVersion];
    [self createScroll];
    [self loadNetDataOfSectionOneAndHeader];
    [self singleLoadTableData];
    [self initTableView];
    [self initCollectionView];

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate: [NSDate date]];
    NSMutableString *mdateTime = [NSMutableString stringWithString:dateTime];
    NSRange range = NSMakeRange(11, 2);
    NSString  *hourStr = [mdateTime substringWithRange:range];
    hourValue = [hourStr intValue];
   
    ycDate = [NSDate date];
    zxDate = [NSDate date];
    
}


#pragma mark - 检测版本更新
-(void)checkVersion{
    
    //获取本地版本
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *localVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"localVersion -> %@",localVersion);
    
    //日日厨网址
    
    NSString *urlString = @"https://itunes.apple.com/lookup?id=1060973985";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    

    //获取AppStore的版本
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
        if (nil != operation.responseString) {
            
            VerModel *verModel = [[VerModel alloc]initWithString:operation.responseString error:nil];
            VerResultModel *resModel = verModel.results[0];
            NSString *storeVersion = resModel.version;
            NSLog(@"storeVersion -> %@",storeVersion);
            if ([localVersion floatValue] < [storeVersion floatValue]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"有新的版本，请及时更新。" delegate:self cancelButtonTitle: nil otherButtonTitles:@"确定",@"取消",nil];
                
                [alertView show];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        NSLog(@"请求失败");
    
    }];
}

#pragma mark - alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0)
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ri-ri-zhu/id1060973985?mt=8&ign-mpt=uo%3D4"]];
        
    }
}


//[[NSUserDefaults standardUserDefaults] synchronize];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://appsto.re/cn/lgTL-.i"]];

#pragma mark - 初始化table
-(void)initTableView{
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, self.view.frame.size.height-30) style:UITableViewStyleGrouped];
    [self createHeader];
    [table addHeaderWithTarget:self action:@selector(headRefresh)];
    [table addFooterWithTarget:self action:@selector(footLoadMore)];
    table.delegate = self;
    table.dataSource = self;
    
    UINib *nib1 = [UINib nibWithNibName:@"SecondCell" bundle:nil];
    [table registerNib:nib1 forCellReuseIdentifier:@"SecondCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"ThirdCell" bundle:nil];
    [table registerNib:nib2 forCellReuseIdentifier:@"ThirdCell"];
    
    yhTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, self.view.frame.size.height-30) style:UITableViewStyleGrouped];
    [yhTable addHeaderWithTarget:self action:@selector(headRefresh)];
    [yhTable addFooterWithTarget:self action:@selector(footLoadMore)];
    yhTable.delegate = self;
    yhTable.dataSource = self;
    [yhTable registerNib:nib2 forCellReuseIdentifier:@"ThirdCellyh"];
    
    htTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, self.view.frame.size.height-30) style:UITableViewStyleGrouped];
    [htTable addHeaderWithTarget:self action:@selector(headRefresh)];
    [htTable addFooterWithTarget:self action:@selector(footLoadMore)];
    htTable.delegate = self;
    htTable.dataSource = self;
    [htTable registerNib:nib2 forCellReuseIdentifier:@"ThirdCellht"];
    
    zxTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, self.view.frame.size.height-30) style:UITableViewStyleGrouped];
    [zxTable addHeaderWithTarget:self action:@selector(headRefresh)];
    [zxTable addFooterWithTarget:self action:@selector(footLoadMore)];
    zxTable.delegate = self;
    zxTable.dataSource = self;
    UINib *zxNib = [UINib nibWithNibName:@"ZXTableViewCell" bundle:nil];
    [zxTable registerNib:zxNib forCellReuseIdentifier:@"ZXTableViewCell"];
}

#pragma mark - 初始化collection
-(void)initCollectionView{
    
    UICollectionViewFlowLayout *ycLayout = [[UICollectionViewFlowLayout alloc]init];
    ycLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    ycLayout.minimumLineSpacing = 10;
    ycCollection = [[UICollectionView alloc]initWithFrame:_carousel.bounds collectionViewLayout:ycLayout];
    ycCollection.backgroundColor = [UIColor whiteColor];
    UINib *ycNib = [UINib nibWithNibName:@"YCCollectionViewCell" bundle:nil];
    [ycCollection registerNib:ycNib forCellWithReuseIdentifier:@"YCCollectionViewCell"];
    ycCollection.delegate = self;
    ycCollection.dataSource = self;
    [ycCollection addHeaderWithTarget:self action:@selector(headRefresh)];
    [ycCollection addFooterWithTarget:self action:@selector(footLoadMore)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    zcCollection = [[UICollectionView alloc]initWithFrame:_carousel.bounds collectionViewLayout:layout];
    UINib *zcNib = [UINib nibWithNibName:@"ZCCollectionViewCell" bundle:nil];
    zcCollection.backgroundColor = [UIColor whiteColor];
    [zcCollection registerNib:zcNib forCellWithReuseIdentifier:@"ZCCollectionViewCell"];
    zcCollection.delegate = self;
    zcCollection.dataSource = self;
    [zcCollection addHeaderWithTarget:self action:@selector(headRefresh)];
    [zcCollection addFooterWithTarget:self action:@selector(footLoadMore)];
}

#pragma mark - 添加下拉刷新和上拉加载更多
-(void)headRefresh{
    
    if (_carousel.currentItemIndex == 0) {
        [self singleLoadTableData];
    }
    
    [self singleLoadTableData];
    
}

-(void)footLoadMore{
    
    if (_carousel.currentItemIndex == 0) {
        url = [NSMutableString stringWithFormat:@"%@&time_sort=%@",url,timeSort];
        
    }
    else if (_carousel.currentItemIndex == 5){
        urlOffset += 20;
        url = [NSMutableString stringWithFormat:@"%@&offset=%d",ZCURL,urlOffset];
    }
    else if (_carousel.currentItemIndex == 4){
        
        //资讯
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        NSDate *yesterday = [zxDate dateByAddingTimeInterval: -secondsPerDay];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *yesterdayStr = [formatter stringFromDate: yesterday];
        NSString *zxUrl = @"http://api.smzdm.com/v1/news/articles?f=iphone&imgmode=0&limit=20&v=6.1.1&weixin=0&page=2&article_date=";
        NSString *appendStr = @"%2019%3A24%3A37";
        url = [NSString stringWithFormat:@"%@%@%@",zxUrl,yesterdayStr,appendStr];
        zxDate = yesterday;
    }
    else if (_carousel.currentItemIndex == 3){
    
        //原创
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        NSDate *yesterday = [zxDate dateByAddingTimeInterval: -secondsPerDay];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *yesterdayStr = [formatter stringFromDate: yesterday];
        NSString *ycUrl = @"http://api.smzdm.com/v1/yuanchuang/articles?f=iphone&imgmode=0&limit=20&page=2&v=6.1.1&weixin=0&article_date=";
        NSString *appendStr = @"%2009%3A40%3A00";
        url = [NSString stringWithFormat:@"%@%@%@",ycUrl,yesterdayStr,appendStr];
        zxDate = yesterday;
        
    }
    else  {
        hourValue = hourValue - 1;

        NSLog(@"timeSort -> %@",timeSort);
        
        NSMutableString *newTime = [NSMutableString stringWithString:timeSort];

        [newTime replaceCharactersInRange:NSMakeRange(11, 2) withString:[NSString stringWithFormat:@"%02d",hourValue]];
        
        NSString *urlTime = [newTime stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

        url = [NSString stringWithFormat:@"%@&article_date=%@",url,urlTime];

        
    }
    
    
    [self RequestNetSource];
}



#pragma mark - 加载网络数据
-(void)loadNetDataOfSectionOneAndHeader{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:BANNERURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        
        model = [[MainModel alloc]initWithData:data error:nil];
        imgScroll.pagingEnabled = YES;
        imgScroll.showsHorizontalScrollIndicator = NO;
        imgScroll.contentSize = CGSizeMake(SCREENW*(model.data.rows.count+2), 180);
        imgScroll.contentOffset = CGPointMake(SCREENW, 0);
        imgScroll.delegate = self;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOne)];
        [imgScroll addGestureRecognizer:tap];
        
        page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 170, SCREENW, 10)];
        page.numberOfPages = model.data.rows.count;
        page.userInteractionEnabled = NO;
//        page.pageIndicatorTintColor = [UIColor redColor];
        [header addSubview:page];
        
        for (int i=0; i<model.data.rows.count+2; i++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREENW, 0, SCREENW, 180)];
            if (i==0) {
                SubModel *sub = [model.data.rows lastObject];
                [imageV setImageWithURL:[NSURL URLWithString:sub.banner_pic]];
            }
            else if (i==model.data.rows.count+1){
                SubModel *sub = [model.data.rows firstObject];
                [imageV setImageWithURL:[NSURL URLWithString:sub.banner_pic]];
            }
            else{
                SubModel *sub = model.data.rows[i-1];
                [imageV setImageWithURL:[NSURL URLWithString:sub.banner_pic]];
            }
            [imgScroll addSubview:imageV];
           
        }
        
        
        [table headerEndRefreshing];
        [table footerEndRefreshing];
        [table reloadData];
        
        [self setTimer];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


//单独加载cell的数据

-(void)singleLoadTableData{
   
        
        if (_carousel.currentItemIndex == 0) {
            url = CELLURL;
            
        }
        else if (_carousel.currentItemIndex == 1) {
            url = YHURL;

            
        }
        else if (_carousel.currentItemIndex == 2) {
            url = HTURL;
            
        }
        else if (_carousel.currentItemIndex == 3){
            url = YCURL;
            
        }
        else if (_carousel.currentItemIndex == 4){
            url = ZXURL;
            
        }
        else{
            url = ZCURL;

        }

    
    [self RequestNetSource];
}


-(void)RequestNetSource{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        modelOfCell = [[CellModel alloc]initWithData:data error:nil];
        
        if (_carousel.currentItemIndex == 0) {
            [table headerEndRefreshing];
            [table footerEndRefreshing];
            for (CellRowsModel *jxModel in modelOfCell.data.rows) {
                [jxDataArray addObject:jxModel];
            }
            CellRowsModel *rowMod = [jxDataArray lastObject];
            timeSort = rowMod.time_sort;
//            NSLog(@"jx = %@",timeSort);
            [table reloadData];
            
        }
        else if (_carousel.currentItemIndex == 1) {
            [yhTable headerEndRefreshing];
            [yhTable  footerEndRefreshing];
            for (CellRowsModel *yhModel in modelOfCell.data.rows) {
                [yhDataArray addObject:yhModel];
            }
            CellRowsModel *rowMod = [yhDataArray lastObject];
            timeSort = rowMod.article_date;
//            NSLog(@"yh = %@",timeSort);
            [yhTable reloadData];
        }
        else if (_carousel.currentItemIndex == 2) {
            [htTable headerEndRefreshing];
            [htTable  footerEndRefreshing];
            for (CellRowsModel *htModel in modelOfCell.data.rows) {
                [htDataArray addObject:htModel];
            }
            CellRowsModel *rowMod = [htDataArray lastObject];
            timeSort = rowMod.article_date;
//            NSLog(@"ht = %@",timeSort);
            [htTable reloadData];
        }
        
        else if (_carousel.currentItemIndex == 3) {
            [ycCollection headerEndRefreshing];
            [ycCollection  footerEndRefreshing];
            for (CellRowsModel *ycModel in modelOfCell.data.rows) {
                [ycDataArray addObject:ycModel];
            }
            [ycCollection reloadData];
        }
        else if (_carousel.currentItemIndex == 4) {
            [zxTable headerEndRefreshing];
            [zxTable  footerEndRefreshing];
            for (CellRowsModel *zxModel in modelOfCell.data.rows) {
                [zxDataArray addObject:zxModel];
            }
            [zxTable reloadData];
        }
        else{
            [zcCollection headerEndRefreshing];
            [zcCollection footerEndRefreshing];
            for (CellRowsModel *zxModel in modelOfCell.data.rows) {
                [zcDataArray addObject:zxModel];
            }
            [zcCollection reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark - 顶部scroll点击事件
-(void)tapOne{
    
    web = [[WebViewController alloc]init];
    SubModel *sub = model.data.rows[page.currentPage];
    web.url = sub.banner_url;
    web.hidesBottomBarWhenPushed = YES;
    web.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [web.view addSubview:web.webView];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:web.url]];
    [web.webView loadRequest:request];
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark - 创建顶部按钮与_carousel
-(void)createScroll{
    NSArray *btnTitle = @[@"精选",@"优惠",@"海淘",@"原创",@"资讯",@"众测"];
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 30, SCREENW, CGRectGetHeight(self.view.bounds) - 30)];
    _carousel.backgroundColor = [UIColor whiteColor];
    _carousel.dataSource = self;
    _carousel.delegate = self;
    _carousel.decelerationRate = 0.7;
    _carousel.type = iCarouselTypeLinear;
    _carousel.pagingEnabled = YES;
    _carousel.edgeRecognition = YES;
    _carousel.bounceDistance = 0.4;
    [self.view addSubview:_carousel];
    
    
    
    _segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 30)];
    _segmentControl.layer.borderColor = RGBA(230, 230, 230, 1.0).CGColor;
    _segmentControl.layer.borderWidth = 1.0;
    _segmentControl.sectionTitles = btnTitle;
    _segmentControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : NAVICOLOR};
    _segmentControl.selectionIndicatorColor = NAVICOLOR;
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorHeight = 3.0;
    [self.view addSubview:_segmentControl];
    
    __weak typeof(self) weakSelf = self;
    
    [_segmentControl setIndexChangeBlock:^(NSInteger index) {
        
        [weakSelf.carousel scrollToItemAtIndex:index animated:NO];
        
    }];
}



#pragma mark - 跳转到详情网页
-(void)jumpToWeb{
    
    web.hidesBottomBarWhenPushed = YES;
    web.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [web.view addSubview:web.webView];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:web.url]];
    [web.webView loadRequest:request];
    [self.navigationController pushViewController:web animated:YES];
    
}



#pragma mark - iCarousel的代理方法
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    return 6;
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{

    if (index == 0 ) {
        view = table;
    }
    else if (index == 1){
        view = yhTable;
    }
    else if (index == 2){
        view = htTable;
    }
    else if (index == 3){
        view = ycCollection;
    }
    else if (index == 4){
        view = zxTable;
    }
    else {
        view = zcCollection;
    }
    
    return view;
    
}

//测试currentItemIndex
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [_segmentControl setSelectedSegmentIndex:carousel.currentItemIndex animated:YES];
    if (carousel.currentItemIndex == 0) {
        [table headerBeginRefreshing];
    }
    else if (carousel.currentItemIndex == 1){
        [yhTable headerBeginRefreshing];
    }
    
    else if (carousel.currentItemIndex == 2){
        [htTable headerBeginRefreshing];
    }
    
    else if (carousel.currentItemIndex == 3){
        [ycCollection headerBeginRefreshing];
    }
    
    else if (carousel.currentItemIndex == 4){
        [zxTable headerBeginRefreshing];
    }
    
    else {
        [zcCollection headerBeginRefreshing];
    }
    
    
}




//- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
//{
//    if (_segmentControl) {
//
//        [_segmentControl setSelectedSegmentIndex:carousel.currentItemIndex];
//        
//    }
//}

#pragma mark - 创建table头部视图
-(void)createHeader{
    
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 180)];
    imgScroll = [[UIScrollView alloc]initWithFrame:header.bounds];
    [header addSubview:imgScroll];
    table.tableHeaderView = header;
    
}

#pragma mark - 创建定时器
-(void)setTimer{

    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollCycle) userInfo:nil repeats:YES];
    }
}

#pragma mark - 循环scroll
-(void)scrollCycle{
    if (page.currentPage == model.data.rows.count-1) {
        page.currentPage = 0;
        [imgScroll setContentOffset:CGPointMake(SCREENW, 0) animated:YES];
    }
    else{
        page.currentPage ++;
        [imgScroll setContentOffset:CGPointMake(SCREENW * (page.currentPage+1), 0) animated:YES];
    }
}


#pragma mark - 导航栏左按钮点击事件
-(void)pressLeft{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - imgScroll的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == imgScroll) {
        if (scrollView.contentOffset.x > model.data.rows.count *SCREENW) {
            [imgScroll setContentOffset:CGPointMake(SCREENW, 0)];
            page.currentPage = 0;
        }
        else if (scrollView.contentOffset.x < SCREENW){
            
            [imgScroll setContentOffset:CGPointMake(SCREENW * model.data.rows.count, 0)];
            page.currentPage = model.data.rows.count-1;
        }
        else
            page.currentPage = (scrollView.contentOffset.x/SCREENW )-1;
    }
}


#pragma mark - table的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == table) {
        return 2;
    }
    else
        return 1;
    
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == table) {
        if (section == 0) {
            return 1;
        }
        
        else{
            return jxDataArray.count;
        }
    }
    
    else if (tableView == yhTable){
        return yhDataArray.count;
    }
    else if (tableView == htTable){
        return htDataArray.count;
    }
    else if (tableView == zxTable){
        return zxDataArray.count;
    }
    
    else
        return 0;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellRowsModel *rowModel = [[CellRowsModel alloc]init];
    if (tableView == table) {
        if (indexPath.section == 0) {
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
        
            for (int i=0; i<3; i++) {
                SubModel *subMod = model.data.little_banner[i];
                if (i == 0) {
                    [cell.bannerImg setImageWithURL:[NSURL URLWithString:subMod.img]];
                    cell.url = subMod.link;
                }
                if (i == 1) {
                    [cell.topImg setImageWithURL:[NSURL URLWithString:subMod.img]];
                    cell.url = subMod.link;
                }
                if (i == 2) {
                    [cell.bottemImg setImageWithURL:[NSURL URLWithString:subMod.img]];
                    cell.url = subMod.link;
                }
                
            }
            
            cell.delegate = self;
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        
        else{
            ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCell"];
            rowModel = jxDataArray[indexPath.row];
            [cell setUIWithInfo:rowModel];
            return cell;
        }
    }
    
    else if (tableView == yhTable){
        ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCellyh"];
        rowModel = yhDataArray[indexPath.row];
        [cell setUIWithInfo:rowModel];
        return cell;
    }
    
    else if (tableView == htTable){
        ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCellht"];
        rowModel = htDataArray[indexPath.row];
        [cell setUIWithInfo:rowModel];
        return cell;
    }
    else if (tableView == zxTable){
        
        ZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZXTableViewCell"];
        rowModel = zxDataArray[indexPath.row];
        [cell setUIWithInfo:rowModel];
        
        return cell;
    }
    
    else
        return nil;
 

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == table) {
        if (indexPath.section == 0) {
            return 140;
        }
        return 120;
    }
    
    else if (tableView == zxTable){
        return 150;
    }
    
    else
        return 120;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView == table) {
        return 10;
    }
    return 0.00001;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (tableView == table ) {
        if (indexPath.section == 0) {
            
            NSLog(@"sec%ld",indexPath.section);
            NSLog(@"row%ld",indexPath.row);
            
        } else {
            CellRowsModel *rowsModel = jxDataArray[indexPath.row];
            web.url = rowsModel.article_url;
            web.rowsMod = rowsModel;
            [self jumpToWeb];
        }
        
        
    }
    else if(tableView == yhTable){
       
        CellRowsModel *rowsModel = yhDataArray[indexPath.row];
        web.url = rowsModel.article_url;
        web.rowsMod = rowsModel;
        [self jumpToWeb];
    }
    else if(tableView == htTable){
        
        CellRowsModel *rowsModel = htDataArray[indexPath.row];
        web.url = rowsModel.article_url;
        web.rowsMod = rowsModel;
        [self jumpToWeb];
    }
    else if(tableView == zxTable){
        
        CellRowsModel *rowsModel = zxDataArray[indexPath.row];
        web.url = rowsModel.article_url;
        web.rowsMod = rowsModel;
        [self jumpToWeb];
    }
    
}

#pragma mark - secondCell的代理
-(void)bannerImageTap:(SecondCell *)cell{

    NSLog(@"1");
    SubModel *sub = model.data.little_banner[0];
    web.url = sub.link;
    [self jumpToWeb];
    
}

-(void)topImageTap:(SecondCell *)cell{

    NSLog(@"12");
    SubModel *sub = model.data.little_banner[1];
    web.url = sub.link;
    [self jumpToWeb];
}

-(void)bottemImageTap:(SecondCell *)cell{

    NSLog(@"13");
    SubModel *sub = model.data.little_banner[2];
    web.url = sub.link;
    [self jumpToWeb];
}




#pragma mark - collection的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (collectionView == ycCollection){
        return ycDataArray.count;
    }
    else {
        return zcDataArray.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView == ycCollection){
        YCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YCCollectionViewCell" forIndexPath:indexPath];
        CellRowsModel *rowsModel = ycDataArray[indexPath.row];
        timeSort = rowsModel.time_sort;
        [cell setUIWithInfo:rowsModel];
        return cell;
    }
    
    else {
        ZCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZCCollectionViewCell" forIndexPath:indexPath];
        CellRowsModel *rowsModel = zcDataArray[indexPath.row];
        timeSort = rowsModel.time_sort;
        [cell setUIWithInfo:rowsModel];
        cell.layer.borderColor = RGBA(240, 240, 240, 1.0).CGColor;
        cell.layer.borderWidth = 0.5;
        return cell;
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (collectionView == ycCollection){
        return CGSizeMake(SCREENW-30, 200);
    }
    else {
        return CGSizeMake(187.5, 250);
    }
    

}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

//}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == zcCollection) {
        CellRowsModel *rowsModel = zcDataArray[indexPath.row];
        web.rowsMod = rowsModel;
        web.url = rowsModel.probation_url;
    }
    
    else if(collectionView == ycCollection){
        CellRowsModel *rowsModel = ycDataArray[indexPath.row];
        web.rowsMod = rowsModel;
        web.url = rowsModel.article_url;
    }
    
    [self jumpToWeb];
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
