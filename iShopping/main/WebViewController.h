//
//  WebViewController.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellRowsModel.h"
@interface WebViewController : UIViewController
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) CellRowsModel *rowsMod;


@end
