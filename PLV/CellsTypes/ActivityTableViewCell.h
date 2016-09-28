//
//  ActivityTableViewCell.h
//  PLV
//
//  Created by Carlos Burgueño on 27/09/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timelbl;
@property (weak, nonatomic) IBOutlet UILabel *eventNamelbl;
@end
