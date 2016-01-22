//
//  SubDataModel.h
//  iShopping
//
//  Created by Siren on 15/10/10.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "SubRowsModel.h"
@interface SubDataModel : JSONModel

@property (strong, nonatomic) NSArray<SubRowsModel> *rows;

@end
