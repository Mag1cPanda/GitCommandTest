//
//  MidModel.h
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "SubModel.h"
@interface MidModel : JSONModel
@property (strong, nonatomic) NSArray<SubModel> *rows;
@property (strong, nonatomic) NSArray<SubModel> *little_banner;


@end
