//
//  SubModel.h
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
@protocol SubModel

@end

@interface SubModel : JSONModel
//rows
@property (copy, nonatomic) NSString *banner_pic;
@property (copy, nonatomic) NSString *banner_url;

//little_banner
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *link;
@end
