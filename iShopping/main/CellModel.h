//
//  CellModel.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "CellMidModel.h"

@interface CellModel : JSONModel
@property (nonatomic, copy) NSString *error_msg;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *error_code;


@property (strong, nonatomic) CellMidModel *data;
@end
