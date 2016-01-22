//
//  CellRowsModel.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
@protocol CellRowsModel

@end
@interface CellRowsModel : JSONModel
@property (copy, nonatomic) NSString *article_title;
@property (copy, nonatomic) NSString *article_url;
@property (copy, nonatomic) NSString *article_channel_name;
@property (copy, nonatomic) NSString *article_mall;
@property (copy, nonatomic) NSString *article_pic;
@property (copy, nonatomic) NSString *article_price;
@property (copy, nonatomic) NSString *article_comment;
@property (copy, nonatomic) NSString *article_format_date;
//精选加载更多标签
@property (copy, nonatomic) NSString *time_sort;
//其他加载更多标签
@property (copy, nonatomic) NSString *article_date;


//原创cell属性
@property (copy, nonatomic) NSString *article_type_name;
//资讯cell属性
@property (copy, nonatomic) NSString *article_filter_content;
@property (copy, nonatomic) NSString *article_rzlx;

//众测cell属性
@property (copy, nonatomic) NSString *probation_title;
@property (copy, nonatomic) NSString *probation_need_gold;
@property (copy, nonatomic) NSString *probation_need_point;
@property (copy, nonatomic) NSString *probation_product_num;
@property (copy, nonatomic) NSString *probation_url;
@property (copy, nonatomic) NSString *probation_status_name;
@property (copy, nonatomic) NSString *probation_img;

@end
