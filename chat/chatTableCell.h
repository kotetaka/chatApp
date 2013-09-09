//
//  chatTableCell.h
//  chat
//
//  Created by 小寺 貴士 on 2012/10/01.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface chatTableCell : UITableViewCell{
    
    IBOutlet UITextField *womanTextField;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *womanImage;
@property (weak, nonatomic) IBOutlet UILabel *womanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *huki;
@property (weak, nonatomic) IBOutlet UIImageView *huki2;



//- (IBAction)inputText:(id)sender;

@end
