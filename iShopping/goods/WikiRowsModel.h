//
//  WikiRowsModel.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
@protocol WikiRowsModel

@end

@interface WikiRowsModel : JSONModel
@property (copy, nonatomic) NSString *article_title;
@property (copy, nonatomic) NSString *article_price;
@property (copy, nonatomic) NSString *article_recommend_uname;
@property (copy, nonatomic) NSString *article_recommend_count;
@property (copy, nonatomic) NSString *article_collect_count;
@property (copy, nonatomic) NSString *article_comment_count;
@property (copy, nonatomic) NSString *article_pic;
@property (copy, nonatomic) NSString *article_reason;
@property (copy, nonatomic) NSString *pro_subtitle;

@end
