//
//  PostCellWithoutImageTableViewCell.h
//  PLV
//
//  Created by Carlos Burgueño on 01/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCellWithoutImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_username;
@property (weak, nonatomic) IBOutlet UILabel *lbl_postContent;

@end
