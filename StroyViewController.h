//
//  StroyViewController.h
//  RoposoTask
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 V group Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StroyViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
