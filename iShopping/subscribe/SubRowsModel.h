//
//  SubRowsModel.h
//  iShopping
//
//  Created by Siren on 15/10/10.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
@protocol SubRowsModel

@end

@interface SubRowsModel : JSONModel

@property (copy, nonatomic) NSString *article_pic;
@property (copy, nonatomic) NSString *article_title;
@property (copy, nonatomic) NSString *article_format_date;
@property (copy, nonatomic) NSString *article_comment;
@property (copy, nonatomic) NSString *article_price;
@property (copy, nonatomic) NSString *article_url;

@property (strong, nonatomic) NSArray *dingyue_tags;


@end
