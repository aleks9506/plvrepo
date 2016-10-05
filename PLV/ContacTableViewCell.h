//
//  ContacTableViewCell.h
//  PLV
//
//  Created by Carlos Burgueño on 05/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContacTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *confirmImage;
@property (weak, nonatomic) IBOutlet UILabel *llbl_name;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
