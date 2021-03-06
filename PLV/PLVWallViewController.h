//
//  PLVWallViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 01/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PLVWallViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak,nonatomic ) NSString *idUser;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *txt_postContent;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)sendPost:(id)sender;
- (IBAction)selectImage:(id)sender;


@end
