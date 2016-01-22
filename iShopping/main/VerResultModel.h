//
//  VerResultModel.h
//  iShopping
//
//  Created by Siren on 16/1/6.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import "JSONModel.h"

@protocol VerResultModel <NSObject>


@end

@interface VerResultModel : JSONModel
@property (nonatomic, strong) NSString *version;
@end
