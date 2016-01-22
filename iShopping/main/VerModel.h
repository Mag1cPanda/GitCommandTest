//
//  VerModel.h
//  iShopping
//
//  Created by Siren on 16/1/6.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "VerResultModel.h"
@interface VerModel : JSONModel
@property (nonatomic, strong) NSArray<VerResultModel> *results;
@end
