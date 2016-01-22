//
//  WikiModel.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "WikiMidModel.h"
@interface WikiModel : JSONModel

@property (strong, nonatomic) WikiMidModel *data;

@end
