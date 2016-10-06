//
//  ContacsViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 05/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContacsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UISwitch *sw_follows;
@property (weak, nonatomic) IBOutlet UISwitch *sw_followers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *txt_search;


- (IBAction)changeValueSwitch:(id)sender;


@end
