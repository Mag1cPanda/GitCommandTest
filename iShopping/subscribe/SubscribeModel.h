//
//  SubscribeModel.h
//  iShopping
//
//  Created by Siren on 15/10/10.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"
#import "SubDataModel.h"
@interface SubscribeModel : JSONModel
@property (strong, nonatomic) SubDataModel *data;

@end
