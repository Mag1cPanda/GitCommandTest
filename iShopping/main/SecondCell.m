//
//  SecondCell.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "SecondCell.h"
#import "SubModel.h"
#import "UIImageView+AFNetworking.h"
#import "WebViewController.h"
WebViewController *web;
@implementation SecondCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerImageTap)];
    [self.bannerImg addGestureRecognizer:leftTap];
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topImageTap)];
    [self.topImg addGestureRecognizer:topTap];
    UITapGestureRecognizer *bottemTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottemImageTap)];
    [self.bottemImg addGestureRecognizer:bottemTap];
    
    web = [WebViewController new];
}

-(void)bannerImageTap{
    
//        NSLog(@"banner");
    if ([_delegate respondsToSelector:@selector(bannerImageTap:)]) {
        [_delegate bannerImageTap:self];
    }
    
    
}
-(void)topImageTap{
   
//        NSLog(@"top");
    if ([_delegate respondsToSelector:@selector(topImageTap:)]) {
        [_delegate topImageTap:self];
    }
    

}
-(void)bottemImageTap{

//        NSLog(@"bottem");
    if ([_delegate respondsToSelector:@selector(bottemImageTap:)]) {
        [_delegate bottemImageTap:self];
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
