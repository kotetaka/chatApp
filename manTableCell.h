//
//  manTableCell.h
//  chat
//
//  Created by 小寺 貴士 on 2012/10/01.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface manTableCell : UITableViewCell{
    
    IBOutlet UITextField *manTextField;

}
@property (weak, nonatomic) IBOutlet UIImageView *manImage;
@property (weak, nonatomic) IBOutlet UILabel *parLabel;
@property (weak, nonatomic) IBOutlet UILabel *ManLabel;
@property (weak, nonatomic) IBOutlet UILabel *enter;
@property (weak, nonatomic) IBOutlet UILabel *retire;

@property (weak, nonatomic) IBOutlet UILabel *yuza;


//- (IBAction)inputText:(id)sender;

@end
