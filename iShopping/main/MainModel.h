//
//  MainModel.h
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "MidModel.h"
@interface MainModel : JSONModel
@property (nonatomic, copy) NSString *error_msg;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *error_code;


@property (strong, nonatomic) MidModel *data;
@end
