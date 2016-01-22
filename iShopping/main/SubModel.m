//
//  SubModel.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "SubModel.h"

@implementation SubModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+(JSONKeyMapper *)keyMapper{
    JSONKeyMapper *map = [[JSONKeyMapper alloc]initWithDictionary:@{@"img":@"banner_pic",@"link":@"banner_url"}];
    return map;
}
@end
