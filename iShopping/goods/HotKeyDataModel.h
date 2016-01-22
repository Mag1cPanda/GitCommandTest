//
//  HotKeyDataModel.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "JSONModel.h"

@protocol HotKeyDataModel <NSObject>

@end

@interface HotKeyDataModel : JSONModel
@property (copy, nonatomic) NSString *tag_name;
@end
