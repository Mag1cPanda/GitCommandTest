//
//  WikiMidModel.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "WikiRowsModel.h"
@interface WikiMidModel : JSONModel
@property (strong, nonatomic) NSArray<WikiRowsModel> *rows;

@end
