//
//  DetailSpeakerViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 06/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailSpeakerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_country;
@property (weak, nonatomic) IBOutlet UILabel *lbl_city;
@property (weak, nonatomic) IBOutlet UILabel *lbl_eventName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_eventDetail;

@end
