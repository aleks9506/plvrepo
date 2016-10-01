//
//  postTableViewCell.h
//  PLV
//
//  Created by Carlos Burgueño on 01/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface postTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_postContent;
@property (weak, nonatomic) IBOutlet UIImageView *img_post;

@end
