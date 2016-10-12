//
//  MenuViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 12/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
- (IBAction)btn_logOut:(id)sender;




@end
