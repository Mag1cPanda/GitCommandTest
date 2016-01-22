//
//  CellMidModel.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "CellRowsModel.h"
@interface CellMidModel : JSONModel

@property (strong, nonatomic) NSArray<CellRowsModel> *rows;

@end
